![Hackathon Logo](docs/images/hackathon.png?raw=true "Hackathon Logo")
# Hackathon Submission Entry form

## Team name
Sitecore Warriors

## Category
Community Module

## Description
Many Sitecore clients are using outdated versions of Sitecore and are unsure whether to upgrade. Stakeholders often lack visibility into their current environment, including the amount of content, media items, and any unintended changes to configuration files. This tool helps them make informed decisions by auditing their system and providing detailed reports.

## Video link
⟹ Replace this Video link

## Pre-requisites and Dependencies
- Latest Sitecore PowerShell version installed
- On-prem Sitecore installation
- Access to the `App_Config` folder of the Sitecore application
- A SQL Server to host the audit report database

## Installation instructions
1. Install the package containing Sitecore items.
2. Create the new audit database using the provided schema.

### Configuration
- Add the connection string in the Sitecore connection string file and name it `Audit`.
- Update the connection string in `appsettings.json` located in `\src\SitecoreWarriorsAudit\dist\`.

## Usage instructions
Navigate to `\src\SitecoreWarriorsAudit\dist\` and run `SitecoreWarriorsAudit.exe`. You can choose from the following options:
1. Config Compare
2. Content Audit
3. Security Audit
4. Create Audit Report (HTML)
5. Exit

For Config Compare, select the Sitecore version, revision number, type, and role if applicable. Then provide the path to the current Sitecore `App_Config` folder. For Content Audit, the tool will generate a report from Sitecore and push it to the database. Similarly, for Security Audit. Finally, execute Create Audit Report to generate an HTML report, which will be saved in the `src\SitecoreWarriorsAudit\dist` folder.
