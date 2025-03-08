using System;
using Microsoft.Extensions.Configuration;

namespace SitecoreWarriorsAudit
{
    public static class LayoutAudit
    {
        public static async Task Run(IConfiguration configuration, SitecoreVersion sitecoreVersion)
        {
            Console.WriteLine("Layout Audit selected.");

            using var client = new HttpClient();
            string url = sitecoreVersion.SitecoreCmUrl;

            Console.WriteLine("\nLayout Audit script is running....\n");

            var response = await client.GetAsync(url + "/_Audit/AuditHandler.ashx?action=layout");

            var responseString = await response.Content.ReadAsStringAsync();

            Console.WriteLine($"{responseString}");
        }
    }
}