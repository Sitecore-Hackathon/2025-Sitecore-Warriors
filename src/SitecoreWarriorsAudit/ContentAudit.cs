using System;
using Microsoft.Extensions.Configuration;

namespace SitecoreWarriorsAudit
{
    public static class ContentAudit
    {
        public static async Task Run(IConfiguration configuration, SitecoreVersion sitecoreVersion)
        {
            Console.WriteLine("Content Audit selected.");

            using var client = new HttpClient();
            string url = sitecoreVersion.SitecoreCmUrl;

            Console.WriteLine("\nContent Audit script is running....\n");

            var response = await client.GetAsync(url + "/_Audit/AuditHandler.ashx?action=content");

            var responseString = await response.Content.ReadAsStringAsync();

            Console.WriteLine($"{responseString}");
        }
    }
}