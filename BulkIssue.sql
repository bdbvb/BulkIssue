USE [master]
GO
/****** Object:  Database [BulkIssue]    Script Date: 5/26/2023 3:01:30 PM ******/
CREATE DATABASE [BulkIssue]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BulkIssue', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BulkIssue.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BulkIssue_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BulkIssue_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BulkIssue] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BulkIssue].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BulkIssue] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BulkIssue] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BulkIssue] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BulkIssue] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BulkIssue] SET ARITHABORT OFF 
GO
ALTER DATABASE [BulkIssue] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BulkIssue] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BulkIssue] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BulkIssue] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BulkIssue] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BulkIssue] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BulkIssue] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BulkIssue] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BulkIssue] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BulkIssue] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BulkIssue] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BulkIssue] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BulkIssue] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BulkIssue] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BulkIssue] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BulkIssue] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BulkIssue] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BulkIssue] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BulkIssue] SET  MULTI_USER 
GO
ALTER DATABASE [BulkIssue] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BulkIssue] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BulkIssue] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BulkIssue] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BulkIssue] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BulkIssue] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BulkIssue', N'ON'
GO
ALTER DATABASE [BulkIssue] SET QUERY_STORE = OFF
GO
USE [BulkIssue]
GO
/****** Object:  Table [dbo].[Test]    Script Date: 5/26/2023 3:01:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test](
	[Id] [uniqueidentifier] NOT NULL,
	[Value] [nvarchar](50) NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Test] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [BulkIssue] SET  READ_WRITE 
GO