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
- Sitecore PowerShell version 7 installed
- On-prem Sitecore installation
- Access to the `App_Config` folder of the Sitecore application
- A SQL Server to host the audit report database
- .NET 8.0 SDK installed

## Installation instructions
1. Install the package ([Sitecore Warriors 2025.zip](https://github.com/Sitecore-Hackathon/2025-Sitecore-Warriors/tree/main/Package)) containing Sitecore items and a handler.
2. Create the new audit database using the provided [schema](https://github.com/Sitecore-Hackathon/2025-Sitecore-Warriors/tree/main/DB%20Schema) and get the connection string to be used in the next step.

### Configuration
- Add the connection string in the Sitecore connection string config and name it `audit`.
- Update the connection string in `appsettings.json` located in `\src\SitecoreWarriorsAudit\dist\`.

## Usage instructions
Navigate to `\src\SitecoreWarriorsAudit\dist\` and run `SitecoreWarriorsAudit.exe`. You can choose from the following options:

1. Config Compare
	- This compares the vanilla Sitecore app_config with the provided local Sitecore app_config folder. 
2. Content Audit
	- This gets the Content report from Sitecore. 
3. Layout Audit
	- This gets the Layout report from Sitecore. 
4. Media Audit
	- This gets the Media report from Sitecore. 
5. Security Audit
	- This gets the Security report from Sitecore. 
6. Create Audit Report (HTML)
	- After everything is completed, this option will create a report as HTML and PDF.  It can be found in `\src\SitecoreWarriorsAudit\dist\` 
7. Exit

Recommendation is to run all the various audits and then create the Audit report. 
### Things which we can improve
1. Reduce the overall repository by compressing the files.
2. Creating additional report by querying data
3. Creating a fancy report
