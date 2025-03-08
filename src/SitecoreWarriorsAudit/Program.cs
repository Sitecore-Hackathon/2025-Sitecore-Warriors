using System;
using Microsoft.Extensions.Configuration;

namespace SitecoreWarriorsAudit
{
    class Program
    {
        static void Main(string[] args)
        {
            // Load configuration
            var configuration = new ConfigurationBuilder()
                .SetBasePath(AppDomain.CurrentDomain.BaseDirectory)
                .AddJsonFile("appsettings.json")
                .Build();

            while (true)
            {
                // Display the stylish banner
                Console.WriteLine("****************************************");
                Console.WriteLine("*                                      *");
                Console.WriteLine("*          Sitecore Warriors           *");
                Console.WriteLine("*                                      *");
                Console.WriteLine("****************************************");

                Console.WriteLine("Select an option:");
                Console.WriteLine("1. Config Compare");
                Console.WriteLine("2. Content Audit");
                Console.WriteLine("3. Security Audit");
                Console.WriteLine("4. Create Audit Report (HTML)");
                Console.WriteLine("5. Exit\n");

                Console.Write("Choose the option: ");
                var option = Console.ReadLine();

                switch (option)
                {
                    case "1":
                        ConfigCompare.Run(configuration);
                        break;
                    case "2":
                        ContentAudit.Run();
                        break;
                    case "3":
                        SecurityAudit.Run();
                        break;
                    case "4":
                        CreateAuditReport.Run();
                        break;
                    case "5":
                        Console.WriteLine("Exiting the program. Goodbye!");
                        return;
                    default:
                        Console.WriteLine("Invalid option. Please select a valid option.");
                        break;
                }
            }
        }
    }
}