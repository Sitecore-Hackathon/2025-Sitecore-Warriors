using System;
using System.Xml.Linq;
using System.Linq;
using System.IO;
using System.Collections.Generic;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;

namespace SitecoreWarriorsAudit
{
    public static class ConfigCompare
    {
        public static void Run(IConfiguration configuration)
        {
            Console.WriteLine($"\n************Config Compare selected************\n");

            // Load the XML file using a relative path
            string basePath = AppDomain.CurrentDomain.BaseDirectory;
            string xmlPath = Path.Combine(basePath, "ConfigComparison", "sitecore_folders.xml");
            XDocument xmlDoc = XDocument.Load(xmlPath);

            // Get available versions
            var versions = xmlDoc.Descendants("Folder")
                                 .Select(x => x.Element("Version").Value)
                                 .Distinct()
                                 .OrderBy(v => Version.Parse(v))
                                 .ToList();

            // Prompt for version
            string version = GetValidUserInput("version", versions);

            // Get available revisions for the selected version
            var revisions = xmlDoc.Descendants("Folder")
                                  .Where(x => x.Element("Version").Value == version)
                                  .Select(x => x.Element("Revision").Value)
                                  .Distinct()
                                  .ToList();

            // Prompt for revision
            string revision = GetValidUserInput("revision", revisions);

            // Get available types for the selected version and revision
            var types = xmlDoc.Descendants("Folder")
                              .Where(x => x.Element("Version").Value == version && x.Element("Revision").Value == revision)
                              .Select(x => x.Element("Type").Value)
                              .Distinct()
                              .ToList();

            // Prompt for type
            string type = types.Contains("") ? "" : GetValidUserInput("type", types);

            // Get available roles for the selected version, revision, and type
            var roles = xmlDoc.Descendants("Folder")
                              .Where(x => x.Element("Version").Value == version && x.Element("Revision").Value == revision && x.Element("Type").Value == type)
                              .Select(x => x.Element("Role").Value)
                              .Distinct()
                              .ToList();

            // Prompt for role
            string role = roles.Contains("") ? "" : GetValidUserInput("role", roles);

            // Get the folder name based on the selected options
            var folderName = xmlDoc.Descendants("Folder")
                                   .Where(x => x.Element("Version").Value == version && x.Element("Revision").Value == revision && x.Element("Type").Value == type && x.Element("Role").Value == role)
                                   .Select(x => x.Element("FolderName").Value)
                                   .FirstOrDefault();

            Console.WriteLine($"Selected Sitecore Version: {folderName}");

            // Ask for the Sitecore App_Config folder path
            string appConfigPath;
            do
            {
                Console.Write("Please enter the path to the Sitecore App_Config folder (e.g., C:\\inetpub\\wwwroot\\App_Config): ");
                appConfigPath = Console.ReadLine();

                // Check if the folder exists and the last folder name equals App_Config
                if (Directory.Exists(appConfigPath) && Path.GetFileName(appConfigPath).Equals("App_Config", StringComparison.OrdinalIgnoreCase))
                {
                    Console.WriteLine("Yes, the folder exists and the folder is App_Config.");
                    Console.WriteLine("Comparing files and exporting to SQL Table....");
                }
                else
                {
                    Console.WriteLine("No, the folder does not exist or the folder is not App_Config. Please enter a valid path.");
                }
            } while (!Directory.Exists(appConfigPath) || !Path.GetFileName(appConfigPath).Equals("App_Config", StringComparison.OrdinalIgnoreCase));

            // Find the folder in \ConfigComparison\Configuration
            string configFolderPath = Path.Combine(basePath, "ConfigComparison", "Configuration", folderName, "App_Config");

            // Check if the folder exists
            if (!Directory.Exists(configFolderPath))
            {
                Console.WriteLine("The specified configuration folder does not exist.");
                return;
            }

            // Compare the App_Config folders and generate the report
            var comparisonResults = CompareConfigFiles(appConfigPath, configFolderPath);

            // Send the report to the SQL table
            SendReportToSqlTable(configuration, comparisonResults);

            // Display the comparison results
            Console.WriteLine("\nComparison Report has been inserted in Database. \n\n");
        }


        static string GetValidUserInput(string property, List<string> options)
        {
            string input = null;
            while (input == null || !options.Contains(input))
            {
                Console.WriteLine($"Select {property}:");
                options.ForEach(Console.WriteLine);
                Console.Write($"\nChoose the {property}: ");
                input = Console.ReadLine();
                if (!options.Contains(input))
                {
                    Console.WriteLine($"\nxxxx Invalid {property}. Please select a valid {property}.\n");
                }
            }
            return input;
        }

        static List<(string Filename, bool AvailableInSource, bool AvailableInDestination, bool ModifiedInDestination)> CompareConfigFiles(string folder1, string folder2)
        {
            var report = new List<(string Filename, bool AvailableInSource, bool AvailableInDestination, bool ModifiedInDestination)>();

            var files1 = Directory.GetFiles(folder1, "*.config", SearchOption.AllDirectories)
                      .Where(f => !f.EndsWith("ConnectionStrings.config") && !f.EndsWith("ConnectionStringsOracle.config"))
                      .ToArray();
            var files2 = Directory.GetFiles(folder2, "*.config", SearchOption.AllDirectories)
                      .Where(f => !f.EndsWith("ConnectionStrings.config") && !f.EndsWith("ConnectionStringsOracle.config"))
                      .ToArray();

            var allFiles = files1.Select(f => f.Substring(folder1.Length)).Union(files2.Select(f => f.Substring(folder2.Length))).Distinct();

            foreach (var relativePath in allFiles)
            {
                string file1 = string.Concat(folder1, relativePath);
                string file2 = string.Concat(folder2, relativePath);

                bool availableInSource = File.Exists(file1);
                bool availableInDestination = File.Exists(file2);
                bool modifiedInDestination = false;

                if (availableInSource && availableInDestination)
                {
                    var content1 = File.ReadAllLines(file1);
                    var content2 = File.ReadAllLines(file2);

                    if (!content1.SequenceEqual(content2))
                    {
                        modifiedInDestination = true;
                    }
                }

                report.Add((relativePath, availableInSource, availableInDestination, modifiedInDestination));
            }

            return report;
        }

        static void SendReportToSqlTable(IConfiguration configuration, List<(string Filename, bool AvailableInSource, bool AvailableInDestination, bool ModifiedInDestination)> report)
        {
            string connectionString = configuration.GetConnectionString("DefaultConnection");

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Truncate the table first
                string truncateQuery = "TRUNCATE TABLE ConfigComparison";
                using (SqlCommand truncateCommand = new SqlCommand(truncateQuery, connection))
                {
                    truncateCommand.ExecuteNonQuery();
                }

                foreach (var item in report)
                {
                    string query = "INSERT INTO ConfigComparison (Filename, AvailableInSource, AvailableInDestination, ModifiedInDestination) VALUES (@Filename, @AvailableInSource, @AvailableInDestination, @ModifiedInDestination)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Filename", item.Filename);
                        command.Parameters.AddWithValue("@AvailableInSource", item.AvailableInSource);
                        command.Parameters.AddWithValue("@AvailableInDestination", item.AvailableInDestination);
                        command.Parameters.AddWithValue("@ModifiedInDestination", item.ModifiedInDestination);

                        command.ExecuteNonQuery();
                    }
                }
            }
        }
    }
}