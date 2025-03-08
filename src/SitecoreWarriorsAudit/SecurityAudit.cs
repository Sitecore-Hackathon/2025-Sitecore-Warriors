using System;
using Microsoft.Extensions.Configuration;

namespace SitecoreWarriorsAudit
{
    public static class SecurityAudit
    {
        public static async Task Run(IConfiguration configuration, SitecoreVersion sitecoreVersion)
        {
            Console.WriteLine("Security Audit selected.");

            using var client = new HttpClient();
            string url = sitecoreVersion.SitecoreCmUrl;

            Console.WriteLine("\nSecurity Audit script is running....\n");

            var response = await client.GetAsync(url + "/_Audit/AuditHandler.ashx?action=security");

            var responseString = await response.Content.ReadAsStringAsync();

            Console.WriteLine($"{responseString}");

        }
    }
}