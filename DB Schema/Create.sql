/****** Object:  Database [audit]    Script Date: 3/8/2025 2:23:14 PM ******/
CREATE DATABASE [audit]  (EDITION = 'GeneralPurpose', SERVICE_OBJECTIVE = 'GP_S_Gen5_1', MAXSIZE = 32 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS, LEDGER = OFF;
GO
ALTER DATABASE [audit] SET COMPATIBILITY_LEVEL = 160
GO
ALTER DATABASE [audit] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [audit] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [audit] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [audit] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [audit] SET ARITHABORT OFF 
GO
ALTER DATABASE [audit] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [audit] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [audit] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [audit] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [audit] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [audit] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [audit] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [audit] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [audit] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [audit] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [audit] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [audit] SET  MULTI_USER 
GO
ALTER DATABASE [audit] SET ENCRYPTION ON
GO
ALTER DATABASE [audit] SET QUERY_STORE = ON
GO
ALTER DATABASE [audit] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/*** The scripts of database scoped configurations in Azure should be executed inside the target database connection. ***/
GO
-- ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
/****** Object:  Table [dbo].[MediaItems]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MediaItems](
	[Name] [varchar](500) NOT NULL,
	[ID] [varchar](50) NOT NULL,
	[ItemPath] [varchar](500) NOT NULL,
	[TemplateName] [varchar](300) NOT NULL,
	[Extension] [varchar](50) NOT NULL,
	[Size] [varchar](50) NULL,
	[InUse] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SitecoreBrokenLinks]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SitecoreBrokenLinks](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SitecoreConfigComparison]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SitecoreConfigComparison](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Filename] [nvarchar](255) NOT NULL,
	[AvailableInSource] [bit] NOT NULL,
	[AvailableInDestination] [bit] NOT NULL,
	[ModifiedInDestination] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SitecoreLanguages]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SitecoreLanguages](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CultureInfo] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SitecoreLayouts]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SitecoreLayouts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[ItemId] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SitecoreMediaItems]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SitecoreMediaItems](
	[Name] [varchar](500) NOT NULL,
	[ID] [varchar](50) NOT NULL,
	[ItemPath] [varchar](500) NOT NULL,
	[TemplateName] [varchar](300) NOT NULL,
	[Extension] [varchar](50) NOT NULL,
	[Size] [varchar](50) NULL,
	[InUse] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SitecoreModules]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SitecoreModules](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[ModuleType] [nvarchar](50) NULL,
	[Version] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SitecoreRenderings]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SitecoreRenderings](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[ItemId] [nvarchar](50) NULL,
	[TemplateName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SitecoreRoles]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SitecoreRoles](
	[Name] [nvarchar](255) NULL,
	[Domain] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SitecoreSites]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SitecoreSites](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SiteName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SitecoreTemplates]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SitecoreTemplates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ItemId] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SitecoreUsers]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SitecoreUsers](
	[Name] [nvarchar](255) NULL,
	[Domain] [nvarchar](255) NULL,
	[IsAdministrator] [bit] NULL,
	[IsEnabled] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SitecoreVersion]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SitecoreVersion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Version] [nvarchar](50) NULL,
	[Revision] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
	[Role] [nvarchar](50) NULL,
	[Sitecore] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnUsedMediaItems]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnUsedMediaItems](
	[Name] [varchar](500) NOT NULL,
	[ID] [varchar](50) NOT NULL,
	[ItemPath] [varchar](500) NOT NULL,
	[TemplateName] [varchar](300) NOT NULL,
	[Extension] [varchar](50) NOT NULL,
	[Size] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Usp_GenerateAuditReport]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[Usp_GenerateAuditReport] 
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
    /****** Script for SelectTopNRows command from SSMS  ******/
	SELECT 'SitecoreVersion' AS ThisTable, [Version], [Revision], [Type], [Role], [Sitecore] FROM [dbo].[SitecoreVersion]
  
  /****** Script for SitecoreSites command from SSMS  ******/
	SELECT 'Sites' AS ThisTable, [SiteName] [Site Name] FROM [dbo].[SitecoreSites]

	SELECT 'Languages' AS ThisTable, [Name], [CultureInfo] [Culture Info] FROM [dbo].[SitecoreLanguages]

	/****** Script for SelectTopNRows command from SSMS  ******/
	SELECT 'Users' AS ThisTable, [Name], [Domain], [IsAdministrator], [IsEnabled] FROM [dbo].[SitecoreUsers]

	/****** Script for SitecoreRoles command from SSMS  ******/
	SELECT 'Roles' AS ThisTable, [Name], [Domain] FROM [dbo].[SitecoreRoles]

	SELECT 'Broken Links' AS ThisTable, [ItemId] [Item Id] FROM [dbo].[SitecoreBrokenLinks]

	SELECT 'Layouts' AS ThisTable, [Name] FROM [dbo].[SitecoreLayouts]

	SELECT 'Renderings' AS ThisTable, [Name] FROM [dbo].[SitecoreRenderings]

	/****** Script for SitecoreTemplates command from SSMS  ******/
	SELECT 'Templates' AS ThisTable, [Name] FROM [dbo].[SitecoreTemplates]

	SELECT 'Modules' AS ThisTable, [Name], [ModuleType] [Type], [Version] FROM [dbo].[SitecoreModules]

	SELECT 'Media Items' AS ThisTable, [Name], [ID], [ItemPath] [Item Path], [TemplateName] [Template Name], [Extension], [Size], [InUse] [In Use] FROM [dbo].[SitecoreMediaItems]

	/****** Script for SelectTopNRows command from SSMS  ******/
	SELECT 'UnUsed Media Items' AS ThisTable, [Name], [ID], [ItemPath] [Item Path], [TemplateName] [Template Name], [Extension], [Size] FROM [dbo].[UnUsedMediaItems]

	SELECT 'Config Comparison' AS ThisTable, [Filename] [File Name], [AvailableInSource] [Available in Source], [AvailableInDestination] [Available in Destination], [ModifiedInDestination] [Modified in Destination] FROM [dbo].[SitecoreConfigComparison]

END
GO
/****** Object:  StoredProcedure [dbo].[Usp_GetSitecoreBrokenLinks]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[Usp_GetSitecoreBrokenLinks]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
    /****** Script for SelectTopNRows command from SSMS  ******/
	SELECT [ItemId] FROM [dbo].[SitecoreBrokenLinks]

END
GO
/****** Object:  StoredProcedure [dbo].[Usp_GetSitecoreConfigComparison]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[Usp_GetSitecoreConfigComparison]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
    /****** Script for SelectTopNRows command from SSMS  ******/
	SELECT [Filename], [AvailableInSource]
      ,[AvailableInDestination]
      ,[ModifiedInDestination]
	FROM [dbo].[SitecoreConfigComparison]

END
GO
/****** Object:  StoredProcedure [dbo].[Usp_GetSitecoreLayouts]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[Usp_GetSitecoreLayouts]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
    /****** Script for SelectTopNRows command from SSMS  ******/

	SELECT [Name], [ItemId] FROM [dbo].[SitecoreLayouts]

END
GO
/****** Object:  StoredProcedure [dbo].[Usp_GetSitecoreMediaItems]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[Usp_GetSitecoreMediaItems]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
    /****** Script for SelectTopNRows command from SSMS  ******/

	SELECT [Name]
      ,[ID]
      ,[ItemPath]
      ,[TemplateName]
      ,[Extension]
      ,[Size]
      ,[InUse]
  FROM [dbo].[SitecoreMediaItems]

END
GO
/****** Object:  StoredProcedure [dbo].[Usp_GetSitecoreModules]    Script Date: 3/8/2025 2:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[Usp_GetSitecoreModules]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
    /****** Script for SelectTopNRows command from SSMS  ******/

	SELECT [Name]
      ,[ModuleType]
      ,[Version]
  FROM [dbo].[SitecoreModules]

END
GO
ALTER DATABASE [audit] SET  READ_WRITE 
GO
