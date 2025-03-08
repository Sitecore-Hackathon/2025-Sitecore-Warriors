/****** Object:  Table [dbo].[MediaItems]    Script Date: 3/8/2025 12:25:29 PM ******/
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
/****** Object:  Table [dbo].[SitecoreBrokenLinks]    Script Date: 3/8/2025 12:25:29 PM ******/
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
/****** Object:  Table [dbo].[SitecoreConfigComparison]    Script Date: 3/8/2025 12:25:29 PM ******/
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
/****** Object:  Table [dbo].[SitecoreLanguages]    Script Date: 3/8/2025 12:25:29 PM ******/
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
/****** Object:  Table [dbo].[SitecoreLayouts]    Script Date: 3/8/2025 12:25:29 PM ******/
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
/****** Object:  Table [dbo].[SitecoreMediaItems]    Script Date: 3/8/2025 12:25:29 PM ******/
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
/****** Object:  Table [dbo].[SitecoreModules]    Script Date: 3/8/2025 12:25:29 PM ******/
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
/****** Object:  Table [dbo].[SitecoreRenderings]    Script Date: 3/8/2025 12:25:29 PM ******/
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
/****** Object:  Table [dbo].[SitecoreRoles]    Script Date: 3/8/2025 12:25:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SitecoreRoles](
	[Name] [nvarchar](255) NULL,
	[Domain] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SitecoreSites]    Script Date: 3/8/2025 12:25:29 PM ******/
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
/****** Object:  Table [dbo].[SitecoreTemplates]    Script Date: 3/8/2025 12:25:29 PM ******/
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
/****** Object:  Table [dbo].[SitecoreUsers]    Script Date: 3/8/2025 12:25:29 PM ******/
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
/****** Object:  Table [dbo].[SitecoreVersion]    Script Date: 3/8/2025 12:25:29 PM ******/
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
/****** Object:  Table [dbo].[UnUsedMediaItems]    Script Date: 3/8/2025 12:25:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Usp_GenerateAuditReport]    Script Date: 3/8/2025 12:25:29 PM ******/
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
	SELECT 'Users' AS ThisTable, 'Number of Users' 'Number of Users', Count([Name]) [Count] FROM [dbo].[SitecoreUsers] UNION
	SELECT 'Users' AS ThisTable, 'Number of Admin Users' 'Number of Admin Users', Count([Name]) [Count] FROM [dbo].[SitecoreUsers] WHERE [IsAdministrator] = 1 UNION
	SELECT 'Users' AS ThisTable, 'Number of Disabled Users' 'Number of Disabled Users', Count([Name]) [Count] FROM [dbo].[SitecoreUsers] SU WHERE [IsEnabled] = 0 UNION
	SELECT 'Users' AS ThisTable, [Domain] 'Users by Domain', Count([Name]) [Count] FROM [dbo].[SitecoreUsers] SU GROUP BY SU.Domain Order By ThisTable DESC

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
	
	--Select count(*) from [SitecoreConfigComparison] where [ModifiedInDestination] = 1
	-- select [Filename] from [SitecoreConfigComparison] where [ModifiedInDestination] = 1
	-- Select count(*) as UnsedMediaCount from SitecoreMediaItems where InUse = 'False'
	-- Select top 10 Name,Size as UnsedMediaCount from SitecoreMediaItems order by Size desc

	SELECT 'Config Comparison' AS ThisTable, [Filename] [File Name], [AvailableInSource] [Available in Source], 
	[AvailableInDestination] [Available in Destination], [ModifiedInDestination] [Modified in Destination] FROM [dbo].[SitecoreConfigComparison] Where [ModifiedInDestination] = 1

END
GO
