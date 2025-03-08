using System;
using Microsoft.Extensions.Configuration;

namespace SitecoreWarriorsAudit
{
    public static class MediaAudit
    {
        public static async Task Run(IConfiguration configuration, SitecoreVersion sitecoreVersion)
        {
            Console.WriteLine("Media Audit selected.");

            using var client = new HttpClient();
            string url = sitecoreVersion.SitecoreCmUrl;

            Console.WriteLine("\nMedia Audit script is running....\n");

            var response = await client.GetAsync(url + "/_Audit/AuditHandler.ashx?action=media");

            var responseString = await response.Content.ReadAsStringAsync();

            Console.WriteLine($"{responseString}");

        }
    }
}