using System;
using System.Xml.Linq;
using System.Linq;
using System.IO;
using System.Collections.Generic;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.IO.Compression;

namespace SitecoreWarriorsAudit
{
    public static class ConfigCompare
    {
        public static void Run(IConfiguration configuration, SitecoreVersion sitecoreVersion)
        {
            Console.WriteLine($"\n************Config Compare selected************\n");

            // Load the XML file using a relative path
            string basePath = AppDomain.CurrentDomain.BaseDirectory;
            string xmlPath = Path.Combine(basePath, "ConfigComparison", "sitecore_folders.xml");
            XDocument xmlDoc = XDocument.Load(xmlPath);

            // Prompt for version
            string version = sitecoreVersion.Version;

            // Prompt for revision
            string revision = sitecoreVersion.Revision;

            // Prompt for type
            string type = sitecoreVersion.Type;

            // Prompt for role
            string role = sitecoreVersion.Role;

            string folderName = sitecoreVersion.Sitecore;

            // Find the folder in \ConfigComparison\Configuration
            string configFolderPath = $"{basePath}ConfigComparison\\Configuration\\{folderName}\\App_Config";
            string zipFilePath = $"{basePath}ConfigComparison\\Configuration\\{folderName}\\app_config.zip";

            // Check if the zip file exists
            if (File.Exists(zipFilePath))
            {
                // Uncompress the zip file
                ZipFile.ExtractToDirectory(zipFilePath, $"{basePath}ConfigComparison\\Configuration\\{folderName}");
            }
            else
            {
                Console.WriteLine("The specified Sitecore Vanilla App_Config folder does not exist.");
            }

            // Check if the folder exists after uncompressing
            if (!Directory.Exists(configFolderPath))
            {
                Console.WriteLine("The specified Sitecore Vanilla App_Config folder does not exist.");
                return;
            }

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

            // Compare the App_Config folders and generate the report
            var comparisonResults = CompareConfigFiles(appConfigPath, configFolderPath);

            // Send the report to the SQL table
            SendReportToSqlTable(configuration, comparisonResults);

            // Display the comparison results
            Console.WriteLine("\nComparison Report has been inserted in Database. \n\n");
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
                string truncateQuery = "TRUNCATE TABLE SitecoreConfigComparison";
                using (SqlCommand truncateCommand = new SqlCommand(truncateQuery, connection))
                {
                    truncateCommand.ExecuteNonQuery();
                }

                foreach (var item in report)
                {
                    string query = "INSERT INTO SitecoreConfigComparison (Filename, AvailableInSource, AvailableInDestination, ModifiedInDestination) VALUES (@Filename, @AvailableInSource, @AvailableInDestination, @ModifiedInDestination)";

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