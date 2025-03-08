using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using PuppeteerSharp;
using System;
using System.Xml.Linq;
using System.Linq;
using System.IO;
using System.Collections.Generic;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Text;

namespace SitecoreWarriorsAudit
{
    public static class CreateAuditReport
    {
        public static async Task Run(IConfiguration configuration)
        {
            Console.WriteLine("Create Audit Report selected.");
            string report = await GenerateReport(configuration);
            Console.WriteLine(report);
        }

        private static async Task<string> GenerateReport(IConfiguration configuration)
        {
            var connectionString = configuration.GetConnectionString("DefaultConnection");

            // Step 1: Query the SQL Table using Stored Procedure
            var dataTables = GetDataFromStoredProcedure(connectionString);

            // Step 2: Load the HTML Template
            string htmlTemplate = File.ReadAllText("report-template.html");
            string populatedHtml = PopulateHtmlTemplate(htmlTemplate, dataTables);

            // Step 3: Generate HTML and PDF
            string htmlOutputPath = "Sitecore_Audit.html";
            string pdfOutputPath = "Sitecore_Audit.pdf";

            File.WriteAllText(htmlOutputPath, populatedHtml);
            await ConvertHtmlToPdf(populatedHtml, pdfOutputPath);

            return "Report generated successfully!";
        }

        private static List<DataTable> GetDataFromStoredProcedure(string connectionString)
        {
            List<DataTable> dataTables = new List<DataTable>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("Usp_GenerateAuditReport", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        DataSet dataSet = new DataSet();
                        adapter.Fill(dataSet);

                        foreach (DataTable table in dataSet.Tables)
                        {
                            dataTables.Add(table);
                        }
                    }
                }
            }

            return dataTables;
        }

        private static string PopulateHtmlTemplate(string template, List<DataTable> dataTables)
        {
            template = template.Replace("{Date}", $"{DateTime.Now.ToString("dddd, MMMM d, yyyy, h:mm tt")}");
            StringBuilder stringBuilder = new StringBuilder();
            string token = "{Tables}";
            foreach (var table in dataTables)
            {
                if (table.Rows.Count > 0)
                {
                    string tableName = table.Rows[0]["ThisTable"].ToString();
                    if (tableName == "SitecoreVersion")
                    {
                        template = template.Replace("{SitecoreVersion}", table.Rows[0]["Sitecore"].ToString());
                    }
                    else if (tableName != "SitecoreVersion")
                    {
                        stringBuilder.Append(ConvertDataTableToHtml(table));
                    }
                }
            }

            template = template.Replace(token, stringBuilder.ToString());

            return template;
        }

        private static string ConvertDataTableToHtml(DataTable table)
        {
            StringWriter sw = new StringWriter();

            sw.WriteLine("\n\n");
            sw.WriteLine($"<h2>{table.Rows[0]["ThisTable"].ToString()}</h2>");
            sw.WriteLine("\n\n");


            sw.WriteLine("<table border='0' cellspacing='0' cellpadding='0' summary='Header layout table' width='100%'>");

            // Write the header row
            sw.WriteLine("<tr>");
            foreach (DataColumn column in table.Columns)
            {
                if (column.ColumnName != "ThisTable")
                {
                    sw.WriteLine($"<th>{column.ColumnName}</th>");
                }
            }
            sw.WriteLine("</tr>");

            // Write the data rows
            foreach (DataRow row in table.Rows)
            {
                sw.WriteLine("<tr>");
                foreach (DataColumn column in table.Columns)
                {
                    if (column.ColumnName != "ThisTable")
                    {
                        sw.WriteLine($"<td>{row[column]}</td>");
                    }
                }
                sw.WriteLine("</tr>");
            }

            sw.WriteLine("</table>");

            sw.WriteLine("\n\n");
            return sw.ToString();
        }


        private static async Task ConvertHtmlToPdf(string htmlContent, string outputPath)
        {
            await new BrowserFetcher().DownloadAsync();
            using var browser = await Puppeteer.LaunchAsync(new LaunchOptions { Headless = true });
            var page = await browser.NewPageAsync();
            await page.SetContentAsync(htmlContent);
            await page.PdfAsync(outputPath);
        }
    }
}