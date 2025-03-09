using System;
using System.Xml.Linq;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace SitecoreWarriorsAudit
{
    class Program
    {
        static async Task Main(string[] args)
        {
            // Load configuration
            var configuration = new ConfigurationBuilder()
                .SetBasePath(AppDomain.CurrentDomain.BaseDirectory)
                .AddJsonFile("appsettings.json")
                .Build();


            // Display the stylish banner
            Console.WriteLine("****************************************");
            Console.WriteLine("*                                      *");
            Console.WriteLine("*          Sitecore Warriors           *");
            Console.WriteLine("*                                      *");
            Console.WriteLine("****************************************");

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

            string sitecoreCMUrl;
            do
            {
                Console.Write("Please enter the Sitecore CM Url (e.g., https://sc104cm.dev.local): ");
                sitecoreCMUrl = Console.ReadLine();

                // Validate and extract the base URL
                if (Uri.TryCreate(sitecoreCMUrl, UriKind.Absolute, out Uri uriResult) &&
                    (uriResult.Scheme == Uri.UriSchemeHttp || uriResult.Scheme == Uri.UriSchemeHttps) &&
                    string.IsNullOrEmpty(uriResult.AbsolutePath.Trim('/')))
                {
                    Console.WriteLine("Valid URL entered.");
                    break;
                }
                else
                {
                    Console.WriteLine("Invalid URL. Please enter a valid http or https URL without any path.");
                }
            } while (true);


            while (true)
            {
                Console.WriteLine($"\nSelected Sitecore Version: {folderName}");

                InsertSitecoreVersion(configuration, version, revision, type, role, folderName);

                // Pass the values to ConfigCompare.Run
                var sitecoreVersion = new SitecoreVersion
                {
                    Version = version,
                    Revision = revision,
                    Type = type,
                    Role = role,
                    Sitecore = folderName,
                    SitecoreCmUrl = sitecoreCMUrl
                };

                Console.WriteLine("\nSelect an option:");
                Console.WriteLine("1. Config Compare");
                Console.WriteLine("2. Content Audit");
                Console.WriteLine("3. Layout Audit");
                Console.WriteLine("4. Media Audit");
                Console.WriteLine("5. Security Audit");
                Console.WriteLine("6. Create Audit Report (PDF)");
                Console.WriteLine("7. Exit\n");

                Console.Write("Choose the option: ");
                var option = Console.ReadLine();

                switch (option)
                {
                    case "1":
                        ConfigCompare.Run(configuration, sitecoreVersion);
                        break;
                    case "2":
                        await ContentAudit.Run(configuration, sitecoreVersion);
                        break;
                    case "3":
                        await LayoutAudit.Run(configuration, sitecoreVersion);
                        break;
                    case "4":
                        await MediaAudit.Run(configuration, sitecoreVersion);
                        break;
                    case "5":
                        await SecurityAudit.Run(configuration, sitecoreVersion);
                        break;
                    case "6":
                        await CreateAuditReport.Run(configuration);
                        break;
                    case "7":
                        Console.WriteLine("Exiting the program. Goodbye!");
                        return;
                    default:
                        Console.WriteLine("Invalid option. Please select a valid option.");
                        break;
                }
            }
        }

        private static void InsertSitecoreVersion(IConfigurationRoot configuration, string version, string revision, string type, string role, string? folderName)
        {
            // Store the selected data in the database
            string connectionString = configuration.GetConnectionString("DefaultConnection");
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Truncate the table
                string truncateQuery = "TRUNCATE TABLE SitecoreVersion";
                using (SqlCommand truncateCommand = new SqlCommand(truncateQuery, connection))
                {
                    truncateCommand.ExecuteNonQuery();
                }

                string query = "INSERT INTO SitecoreVersion (Version, Revision, Type, Role, Sitecore) VALUES (@Version, @Revision, @Type, @Role, @Sitecore)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Version", version);
                    command.Parameters.AddWithValue("@Revision", revision);
                    command.Parameters.AddWithValue("@Type", type);
                    command.Parameters.AddWithValue("@Role", role);
                    command.Parameters.AddWithValue("@Sitecore", folderName);

                    command.ExecuteNonQuery();
                }
            }
        }

        static string GetValidUserInput(string property, List<string> options)
        {
            string input = null;
            while (input == null || !options.Contains(input))
            {
                Console.WriteLine($"\nSelect {property}:");
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

    }
}