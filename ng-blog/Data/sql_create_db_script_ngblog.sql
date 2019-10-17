USE [master]
GO

/****** Object:  Database [ngBlog]    Script Date: 10/16/2019 12:31:20 PM ******/
DROP DATABASE if EXISTS [ngBlog]
GO

/****** Object:  Database [ngBlog]    Script Date: 10/16/2019 12:31:20 PM ******/
CREATE DATABASE [ngBlog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ngBlog', FILENAME = N'C:\Users\Administrator\ngBlog.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ngBlog_log', FILENAME = N'C:\Users\Administrator\ngBlog_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ngBlog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [ngBlog] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [ngBlog] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [ngBlog] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [ngBlog] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [ngBlog] SET ARITHABORT OFF 
GO

ALTER DATABASE [ngBlog] SET AUTO_CLOSE ON 
GO

ALTER DATABASE [ngBlog] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [ngBlog] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [ngBlog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [ngBlog] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [ngBlog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [ngBlog] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [ngBlog] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [ngBlog] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [ngBlog] SET  DISABLE_BROKER 
GO

ALTER DATABASE [ngBlog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [ngBlog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [ngBlog] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [ngBlog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [ngBlog] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [ngBlog] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [ngBlog] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [ngBlog] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [ngBlog] SET  MULTI_USER 
GO

ALTER DATABASE [ngBlog] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [ngBlog] SET DB_CHAINING OFF 
GO

ALTER DATABASE [ngBlog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [ngBlog] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [ngBlog] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [ngBlog] SET QUERY_STORE = OFF
GO

USE [ngBlog]
GO

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

ALTER DATABASE [ngBlog] SET  READ_WRITE 
GO


