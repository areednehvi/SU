USE [master]
GO
/****** Object:  Database [SchoolUniverse]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE DATABASE [SchoolUniverse]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SchoolUniverse', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\SchoolUniverse.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SchoolUniverse_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\SchoolUniverse_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SchoolUniverse] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SchoolUniverse].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SchoolUniverse] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SchoolUniverse] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SchoolUniverse] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SchoolUniverse] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SchoolUniverse] SET ARITHABORT OFF 
GO
ALTER DATABASE [SchoolUniverse] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SchoolUniverse] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SchoolUniverse] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SchoolUniverse] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SchoolUniverse] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SchoolUniverse] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SchoolUniverse] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SchoolUniverse] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SchoolUniverse] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SchoolUniverse] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SchoolUniverse] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SchoolUniverse] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SchoolUniverse] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SchoolUniverse] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SchoolUniverse] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SchoolUniverse] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SchoolUniverse] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SchoolUniverse] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SchoolUniverse] SET RECOVERY FULL 
GO
ALTER DATABASE [SchoolUniverse] SET  MULTI_USER 
GO
ALTER DATABASE [SchoolUniverse] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SchoolUniverse] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SchoolUniverse] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SchoolUniverse] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SchoolUniverse', N'ON'
GO
USE [SchoolUniverse]
GO
/****** Object:  UserDefinedTableType [dbo].[fee_categories]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[fee_categories] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[name] [varchar](45) NOT NULL,
	[recur] [varchar](10) NOT NULL,
	[is_transport] [int] NULL,
	[order] [bigint] NOT NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[FeeDueModel]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[FeeDueModel] AS TABLE(
	[id] [bigint] NOT NULL,
	[student_id] [bigint] NOT NULL,
	[student_balance] [float] NULL,
	[apply_from] [date] NOT NULL,
	[apply_to] [date] NOT NULL,
	[fine] [float] NULL,
	[concession_amount] [float] NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[fees]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[fees] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[fee_category_id] [bigint] NOT NULL,
	[session_id] [bigint] NOT NULL,
	[amount] [float] NOT NULL,
	[fee_cources] [varchar](max) NULL,
	[last_date] [date] NULL,
	[last_day] [int] NULL,
	[fine_per_day] [float] NULL,
	[is_allocated] [smallint] NOT NULL,
	[remarks] [varchar](max) NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [int] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[files]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[files] AS TABLE(
	[id] [bigint] NOT NULL,
	[name] [varchar](255) NULL,
	[extension] [varchar](45) NULL,
	[size] [int] NULL,
	[school_id] [int] NULL,
	[owner_user_id] [int] NULL,
	[created] [datetime2](0) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[grade_fees]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[grade_fees] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[fees_id] [bigint] NOT NULL,
	[grade_id] [bigint] NOT NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[grades]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[grades] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[block] [varchar](50) NULL,
	[name] [varchar](45) NOT NULL,
	[order] [bigint] NOT NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[parents]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[parents] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[f_first_name] [varchar](45) NOT NULL,
	[f_middle_name] [varchar](45) NULL,
	[f_last_name] [varchar](45) NOT NULL,
	[f_mobile] [varchar](15) NULL,
	[f_phone] [varchar](15) NULL,
	[f_office] [varchar](15) NULL,
	[f_email] [varchar](45) NULL,
	[m_first_name] [varchar](45) NULL,
	[m_middle_name] [varchar](45) NULL,
	[m_last_name] [varchar](45) NULL,
	[m_mobile] [varchar](15) NULL,
	[m_phone] [varchar](15) NULL,
	[m_office] [varchar](15) NULL,
	[m_email] [varchar](45) NULL,
	[g_fullname] [varchar](45) NULL,
	[g_mobile] [varchar](15) NULL,
	[g_email] [varchar](45) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[PaymentModel]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[PaymentModel] AS TABLE(
	[id_offline] [uniqueidentifier] NOT NULL,
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[student_fees_id] [bigint] NOT NULL,
	[amount] [float] NOT NULL,
	[fine] [float] NULL,
	[comment] [varchar](max) NULL,
	[recept_no] [varchar](45) NULL,
	[payment_mode] [varchar](50) NOT NULL,
	[payment_date] [datetime2](0) NOT NULL,
	[ip] [varchar](45) NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[route_stops]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[route_stops] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[route_id] [bigint] NOT NULL,
	[name] [varchar](max) NOT NULL,
	[latitude] [varchar](max) NULL,
	[longitude] [varchar](max) NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[route_vehicle_stops]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[route_vehicle_stops] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[route_vehicle_id] [bigint] NOT NULL,
	[route_stop_id] [bigint] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[route_vehicle_stops_fee_logs]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[route_vehicle_stops_fee_logs] AS TABLE(
	[id] [bigint] NOT NULL,
	[route_vehicle_stop_id] [bigint] NOT NULL,
	[fees_id] [bigint] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[route_vehicles]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[route_vehicles] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[vehicle_id] [bigint] NOT NULL,
	[route_id] [bigint] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[routes]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[routes] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[start_location] [varchar](max) NULL,
	[end_location] [varchar](max) NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[schools]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[schools] AS TABLE(
	[id] [bigint] NOT NULL,
	[database_id] [bigint] NOT NULL,
	[subdomain] [varchar](45) NOT NULL,
	[domain] [varchar](max) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[address] [varchar](max) NULL,
	[theme] [varchar](max) NULL,
	[created_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[sections]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[sections] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [int] NOT NULL,
	[name] [varchar](10) NOT NULL,
	[capacity] [int] NOT NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[sessions]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[sessions] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [int] NOT NULL,
	[name] [varchar](45) NOT NULL,
	[order] [int] NOT NULL,
	[from_date] [datetime2](0) NULL,
	[to_date] [datetime2](0) NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[student_fees]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[student_fees] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[grade_fees_id] [bigint] NULL,
	[student_id] [bigint] NOT NULL,
	[route_vehicle_stops_fee_log_id] [bigint] NULL,
	[apply_from] [date] NOT NULL,
	[apply_to] [date] NOT NULL,
	[fine] [float] NULL,
	[concession_amount] [float] NULL,
	[no_fine] [smallint] NOT NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[student_grade_session_log]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[student_grade_session_log] AS TABLE(
	[id] [varchar](10) NULL,
	[school_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
	[registration_id] [varchar](45) NOT NULL,
	[grade_id] [int] NOT NULL,
	[section_id] [int] NOT NULL,
	[roll_number] [int] NOT NULL,
	[exam_roll_number] [varchar](45) NULL,
	[session_id] [int] NOT NULL,
	[sgsl_status] [varchar](50) NOT NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [int] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[student_payments]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[student_payments] AS TABLE(
	[id_offline] [uniqueidentifier] NOT NULL,
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[student_fees_id] [bigint] NOT NULL,
	[amount] [float] NOT NULL,
	[fine] [float] NULL,
	[comment] [varchar](max) NULL,
	[recept_no] [varchar](45) NULL,
	[payment_mode] [varchar](50) NOT NULL,
	[payment_date] [datetime2](0) NOT NULL,
	[ip] [varchar](45) NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[students]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[students] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
	[parent_id] [bigint] NULL,
	[grade_id] [bigint] NOT NULL,
	[section_id] [bigint] NOT NULL,
	[session_id] [bigint] NOT NULL,
	[trip_stop_id] [bigint] NULL,
	[registration_id] [varchar](45) NOT NULL,
	[roll_number] [varchar](45) NULL,
	[exam_roll_number] [varchar](45) NULL,
	[enrollment_date] [date] NULL,
	[status] [varchar](50) NOT NULL,
	[dc_number] [int] NULL,
	[dc_date_of_issue] [date] NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[trip_stops]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[trip_stops] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[route_vehicle_stop_id] [int] NOT NULL,
	[trip] [varchar](50) NOT NULL,
	[pick] [time](7) NOT NULL,
	[drop] [time](7) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[user_avatar_files]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[user_avatar_files] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[user_id] [bigint] NULL,
	[applicant_id] [bigint] NULL,
	[file_id] [bigint] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[users]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[users] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[student_id] [bigint] NULL,
	[role_id] [bigint] NULL,
	[user_type] [varchar](50) NOT NULL,
	[username] [varchar](45) NULL,
	[email] [varchar](100) NULL,
	[phone] [varchar](20) NULL,
	[address_line_one] [text] NULL,
	[address_line_two] [text] NULL,
	[area] [varchar](45) NULL,
	[first_name] [varchar](100) NOT NULL,
	[middle_name] [varchar](100) NULL,
	[last_name] [varchar](100) NULL,
	[full_name] [varchar](300) NULL,
	[gender] [varchar](50) NOT NULL,
	[blood_group] [varchar](50) NULL,
	[password] [varchar](200) NULL,
	[birth_date] [date] NOT NULL,
	[other_phones] [text] NULL,
	[default_phone_number_id] [bigint] NULL,
	[adhaar_number] [bigint] NULL,
	[bank_name] [varchar](100) NULL,
	[bank_branch] [varchar](100) NULL,
	[bank_account_number] [varchar](100) NULL,
	[bank_ifsc_code] [varchar](100) NULL,
	[flags] [text] NULL,
	[last_login_time] [datetime] NULL,
	[user_avatar_file_id] [bigint] NULL,
	[status] [varchar](50) NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [bigint] NULL,
	[updated_on] [datetime] NULL,
	[updated_by] [bigint] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[vehicles]    Script Date: 1/9/2018 5:49:27 PM ******/
CREATE TYPE [dbo].[vehicles] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[tracker_id] [bigint] NULL,
	[registration_number] [varchar](50) NOT NULL,
	[bus_number] [varchar](15) NULL,
	[insurance_renew_date] [date] NULL,
	[staff_id] [bigint] NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  StoredProcedure [dbo].[AuthenticateUser]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Authenticate User>
-- =============================================
CREATE PROCEDURE [dbo].[AuthenticateUser] @Username nvarchar(50), @Password nvarchar(200)
AS
SELECT * 
FROM Users
WHERE username = @Username and password = @Password


GO
/****** Object:  StoredProcedure [dbo].[DeleteRecord]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Delete Record>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteRecord] @key nvarchar(200),@value nvarchar(200), @tableName nvarchar(150)
AS
DECLARE @sqlCommand varchar(200)
BEGIN TRAN
	SET @sqlCommand = 'DELETE from ' + @tableName +' WHERE  '+ @key +'='+  @value 
	EXEC (@sqlCommand)
COMMIT


GO
/****** Object:  StoredProcedure [dbo].[GetList]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Get List>
-- =============================================
CREATE PROCEDURE [dbo].[GetList] @tableName nvarchar(100), @keyColumn nvarchar(100), @valueColumn nvarchar(100),@orderBy nvarchar(100)
AS
EXEC('select '+ @keyColumn +','+ @valueColumn +' from ' + @tableName +' order by ' + @orderBy)



GO
/****** Object:  StoredProcedure [dbo].[GetSchoolInfo]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Get School Info>
-- =============================================

Create PROCEDURE [dbo].[GetSchoolInfo]
AS
BEGIN
	Select top 1 * from Schools
END


GO
/****** Object:  StoredProcedure [dbo].[GetSettings]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Get Settings>
-- =============================================
CREATE PROCEDURE [dbo].[GetSettings]  @key nvarchar(100)
AS 
	SELECT * FROM Settings where [key] = @key


GO
/****** Object:  StoredProcedure [dbo].[GetStudentBalances]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<GetStudentBalances>
-- =============================================
CREATE PROCEDURE [dbo].[GetStudentBalances]  @StudentID nvarchar(200) = '%%', @receptNo nvarchar(200) = '%%',@studentFeeIds nvarchar(200) = '%%',@feesCategorieIds nvarchar(200) = '%%',@applyFrom nvarchar(200) = '01/01/2000',@applyTo nvarchar(200) = '01/01/3000'
AS
SELECT 
		MAX(sf.id) as id,
		MAX(sf.apply_from) as apply_from,
		MAX(f.last_day) as last_day,
		MAX(f.fine_per_day) as fine_per_day,
		MAX(fc.name) AS fees_category,
		MAX(sf.student_id) as student_id,
		MAX(f.id) AS fees_id,
		MAX(f.amount) AS fee_amount,
		MAX(sp.payment_mode) as payment_mode,
		MAX(sp.payment_date) as payment_date,
		MAX(sp.recept_no) as recept_no,
		MAX(sp.comment) as comment,
		MAX(sp.amount) AS payment_amount,
		MAX(sp.fine) AS payment_fine,
		MAX(sf.fine) as fine,
		--MAX(sf.concession_amount) as concession_amount,
		CASE WHEN MAX(sf.concession_amount) IS NULL THEN 0 ELSE MAX(sf.concession_amount) END AS concession_amount,
		CASE WHEN MAX(f.amount) IS NULL THEN 0 ELSE MAX(f.amount) END - CASE WHEN SUM(sp.amount) IS NULL THEN 0 ELSE MAX(sp.amount) END AS amount_to_pay,
		CASE WHEN MAX(sf.fine) IS NULL THEN 0 ELSE MAX(sf.fine) END AS fine_to_pay,
		SUM(sp.amount) AS paid_amount,
		CASE WHEN MAX(sp.fine) IS NULL THEN 0 ELSE MAX(sp.fine) END AS fine_paid,
		(CASE WHEN MAX(f.amount) IS NULL THEN 0 ELSE MAX(f.amount) END + CASE WHEN MAX(sf.fine) IS NULL THEN 0 ELSE MAX(sf.fine) END) - (CASE WHEN SUM(sp.amount) IS NULL THEN 0 ELSE MAX(sp.amount) END + CASE WHEN SUM(sp.fine) IS NULL THEN 0 ELSE MAX(sp.fine) END) - CASE WHEN MAX(sf.concession_amount) IS NULL THEN 0 ELSE MAX(sf.concession_amount) END AS balance_amount,				
		CASE WHEN FORMAT(MAX(sf.apply_from),'MMM yyyy') <> FORMAT(MAX(sf.apply_to),'MMM yyyy') THEN  CONCAT(FORMAT(MAX(sf.apply_from),'MMM yyyy'), ' To ' , FORMAT(MAX(sf.apply_to),'MMM yyyy')) ELSE  FORMAT(MAX(sf.apply_from),'MMM yyyy') END AS period
	FROM 
		student_fees AS sf
	LEFT JOIN grade_fees AS gf ON gf.id = sf.grade_fees_id
	LEFT JOIN route_vehicle_stops_fee_logs AS rvsfl ON rvsfl.id = sf.route_vehicle_stops_fee_log_id
	LEFT JOIN fees AS f ON f.id = gf.fees_id OR f.id = rvsfl.fees_id
	LEFT JOIN student_payments AS sp ON sf.id = sp.student_fees_id
	LEFT JOIN fee_categories AS fc ON fc.id = f.fee_category_id
	WHERE
		ISNULL(sf.student_id,'') like @studentId
	AND
		ISNULL(sp.recept_no,'') like @receptNo
	AND
		ISNULL(sf.id,'') like @studentFeeIds
	AND
		ISNULL(fc.id,'') like @feesCategorieIds
	AND
		sf.apply_from Between @applyFrom AND @applyTo
	GROUP BY 
		sf.id
	HAVING
		(CASE WHEN MAX(f.amount) IS NULL THEN 0 ELSE MAX(f.amount) END + CASE WHEN MAX(sf.fine) IS NULL THEN 0 ELSE MAX(sf.fine) END - CASE WHEN MAX(sf.concession_amount) IS NULL THEN 0 ELSE MAX(sf.concession_amount) END) - (CASE WHEN SUM(sp.amount) IS NULL THEN 1 ELSE SUM(sp.amount) END + CASE WHEN SUM(sp.fine) IS NULL THEN 0 ELSE SUM(sp.fine) END) > 0
	ORDER BY  
		--MAX(fc.[order]) ASC, 
		MAX(sf.apply_from) ASC;
		


GO
/****** Object:  StoredProcedure [dbo].[GetStudentFeeAllocatedList]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<GetStudentFeeAllocatedList>
--				Get Specific rows based on FromRowNo and ToRowNo
-- =============================================
CREATE PROCEDURE [dbo].[GetStudentFeeAllocatedList] @FromRowNo nvarchar(200), @ToRowNo nvarchar(200), @SectionID  nvarchar(200) = '%%', @GradeID  nvarchar(200) = '%%',@RollNumber nvarchar(50) = '%%',@RegistrationID  nvarchar(200) = '%%',@ConcessionAmount  nvarchar(200) = '%%'
AS
WITH StudentFeeAllocationTable AS 
        ( 
           SELECT 
            ROW_NUMBER() OVER(order by MAX(full_name)) AS 'RowNumber', 
			MAX(s.id) as id,
			MAX(s.school_id) as school_id,
			MAX(s.registration_id) as registration_id,
			MAX(sgsl.sgsl_status) AS status,
			MAX(uaf.file_id) AS file_id,
			MAX(sgsl.session_id) as session_id,
			CASE WHEN MAX(f.id) IS NULL THEN 0 ELSE NULL END AS fees_id,
			MAX(sf.grade_fees_id) as grade_fees_id,
			MAX(sf.apply_from) as apply_from,
			MAX(sf.apply_to) as apply_to,
			MAX(sf.concession_amount) as concession_amount,
			MAX(sf.fine) as fine,
			MAX(sgsl.grade_id) as grade_id,
			MAX(sgsl.section_id) as section_id,
			REPLACE(REPLACE(MAX(u.full_name),'<u>',''),'</u>','') as full_name,
			MAX(sgsl.roll_number) as roll_number,
			MAX(g.name) AS grade_name,
			MAX(sc.name) AS section_name,
			MAX(g.[order]) as [order],
			CONCAT(MAX(g.name), ' - ', MAX(sc.name)) AS grade_section,
			COUNT(sf.id) AS allocated_fee_cource_count,
			--CONCAT('<abbr title="Fathers Name">F:</abbr> ',MAX(p.f_first_name), ' ', MAX(p.f_middle_name), ' ', MAX(p.f_last_name),'<br> <abbr title="Mothers Name">M:</abbr> ',MAX(p.m_first_name), ' ', MAX(p.m_middle_name), ' ', MAX(p.m_last_name)) AS parentage
			CONCAT('F: ',MAX(p.f_first_name), ' ', MAX(p.f_middle_name), ' ', MAX(p.f_last_name),' - M: ',MAX(p.m_first_name), ' ', MAX(p.m_middle_name), ' ', MAX(p.m_last_name)) AS parentage
		FROM 
			students AS s
		LEFT JOIN users AS u ON u.id = s.user_id
		LEFT JOIN student_fees AS sf ON s.id = sf.student_id
		LEFT JOIN grade_fees AS gf ON gf.id = sf.grade_fees_id
		LEFT JOIN fees AS f ON f.id = gf.fees_id
		LEFT JOIN student_grade_session_log AS sgsl ON s.id = sgsl.student_id
		LEFT JOIN grades AS g ON sgsl.grade_id = g.id
		LEFT JOIN sections AS sc ON sc.id = sgsl.section_id
		LEFT JOIN user_avatar_files uaf ON uaf.id = u.user_avatar_file_id
		LEFT JOIN parents AS p ON p.id = s.parent_id
		GROUP BY
			s.id,sgsl.session_id
			having MAX(ISNULL(sc.id,0)) like @SectionID 
			AND MAX(ISNULL(g.id,0)) like @GradeID 
			AND MAX(ISNULL(sgsl.roll_number,0)) like @RollNumber
			AND MAX(ISNULL(s.registration_id,0)) like @RegistrationID
			AND MAX(ISNULL(sf.concession_amount,0)) like @ConcessionAmount
				) 
				SELECT 
					*
				FROM StudentFeeAllocationTable 
				WHERE RowNumber BETWEEN @FromRowNo AND @ToRowNo







GO
/****** Object:  StoredProcedure [dbo].[GetStudentFeeDue]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<GetStudentFeeDue>
-- =============================================
CREATE PROCEDURE [dbo].[GetStudentFeeDue] @FromRowNo nvarchar(200), @ToRowNo nvarchar(200), @StudentID nvarchar(200) = '%%', @FeeCategoryID nvarchar(200) = '%%'
AS
WITH StudentFeeDue AS 
        ( 
           SELECT
				ROW_NUMBER() OVER(order by sp.updated_on DESC) AS 'RowNumber', 
				sf.id,
				s.school_id,
				uaf.file_id AS file_id,
				sgsl.session_id,
				CASE WHEN f.id IS NULL THEN 0 ELSE NULL END AS fees_id,
				s.id AS student_id,
				sf.grade_fees_id,
				f.last_day,
				f.amount,	
				rvsfl.route_vehicle_stop_id,
				sf.apply_from,
				sf.apply_to,
				sf.concession_amount,
				ROUND(100/f.amount*sf.concession_amount,2) AS concession_percentage,
				sf.fine,
				sgsl.grade_id,
				sgsl.section_id,
				sgsl.registration_id,
				u.full_name,
				u.first_name,
				u.middle_name,
				u.last_name,
				u.address_line_one,
				CONCAT(p.f_first_name, ' ', p.f_middle_name, ' ', p.f_last_name) AS parentage,
				p.f_mobile,
				sgsl.roll_number,
				g.name AS grade_name,
				g.[order],
				fc.id AS fee_category_id,
				fc.name AS category_name,
				f.amount + CASE WHEN sf.fine IS NULL THEN  0 ELSE sf.fine END - CASE WHEN sf.concession_amount IS NULL THEN  0 ELSE sf.concession_amount END - CASE WHEN sp.amount IS NULL THEN  0 ELSE sp.amount END + CASE WHEN sp.fine IS NULL THEN  0 ELSE sp.fine END AS student_balance,
				sf.created_by AS created_by,
				sf.created_on AS created_on,
				sf.updated_by AS updated_by,
				sf.updated_on AS updated_on
			FROM 
				students AS s
			LEFT JOIN users AS u ON u.id = s.user_id
			LEFT JOIN parents AS p ON p.id = s.parent_id
			LEFT JOIN student_fees AS sf ON s.id = sf.student_id
			LEFT JOIN grade_fees AS gf ON gf.id = sf.grade_fees_id
			LEFT JOIN route_vehicle_stops_fee_logs AS rvsfl ON rvsfl.id = sf.route_vehicle_stops_fee_log_id
			LEFT JOIN fees AS f ON f.id = gf.fees_id OR f.id = rvsfl.fees_id
			LEFT JOIN fee_categories AS fc ON fc.id = f.fee_category_id
			LEFT JOIN student_grade_session_log AS sgsl ON s.id = sgsl.student_id
			LEFT JOIN grades AS g ON sgsl.grade_id = g.id
			LEFT JOIN user_avatar_files uaf ON uaf.id = u.user_avatar_file_id
			LEFT JOIN student_payments AS sp ON sf.id = sp.student_fees_id	
			WHERE
				s.id like @StudentID AND
				fc.id like @FeeCategoryID
		) 
		SELECT 
			*
		FROM StudentFeeDue 
		WHERE RowNumber BETWEEN @FromRowNo AND @ToRowNo









GO
/****** Object:  StoredProcedure [dbo].[GetStudentPaymentHistory]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<GetStudentPaymentHistory>
-- =============================================
CREATE PROCEDURE [dbo].[GetStudentPaymentHistory] @FromRowNo nvarchar(200), @ToRowNo nvarchar(200), @StudentID nvarchar(200) = '%%'
AS
WITH StudentPaymentHistory AS 
        ( 
           SELECT
				ROW_NUMBER() OVER(order by sp.updated_on DESC) AS 'RowNumber', 
				sp.*,
				u.full_name AS [student_name],
				f.id AS [fees_id],
				sf.student_id,
				sf.grade_fees_id,
				sf.concession_amount,
				rvsfl.route_vehicle_stop_id, 
				Convert(char(3), sf.apply_from, 0) as [month],
				sf.apply_from,
				sf.apply_to,
				f.amount AS [fee_amount],
				f.fee_category_id,
				fc.name AS [category_name]
			FROM
				student_payments AS sp
			LEFT JOIN student_fees AS sf ON sf.id = sp.student_fees_id
			LEFT JOIN students AS s ON s.id = sf.student_id
			LEFT JOIN users AS u ON u.id = s.user_id
			LEFT JOIN grade_fees AS gf ON gf.id = sf.grade_fees_id
			LEFT JOIN route_vehicle_stops_fee_logs AS rvsfl ON rvsfl.id = sf.route_vehicle_stops_fee_log_id
			LEFT JOIN route_vehicle_stops AS rvs ON rvs.id = rvsfl.route_vehicle_stop_id
			LEFT JOIN fees AS f ON f.id = gf.fees_id OR f.id = rvsfl.fees_id
			LEFT JOIN fee_categories AS fc ON fc.id = f.fee_category_id		
			WHERE s.id like @StudentID		
				) 
				SELECT 
					*
				FROM StudentPaymentHistory 
				WHERE RowNumber BETWEEN @FromRowNo AND @ToRowNo



GO
/****** Object:  StoredProcedure [dbo].[GetSyncTableInfo]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Get SyncTableInfo>
-- =============================================
CREATE PROCEDURE [dbo].[GetSyncTableInfo]
AS 
	SELECT * FROM SyncTableInfo



GO
/****** Object:  StoredProcedure [dbo].[IsSchoolSetup]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Check School is Setup>
-- =============================================
CREATE PROCEDURE [dbo].[IsSchoolSetup]
AS
SELECT * 
FROM schools


GO
/****** Object:  StoredProcedure [dbo].[MakePayment]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Make Payment>
-- =============================================
CREATE PROCEDURE [dbo].[MakePayment] @PaymentTable PaymentModel READONLY
AS
BEGIN TRAN
		INSERT INTO [dbo].[student_payments]
           ([id]
           ,[school_id]
           ,[student_fees_id]
           ,[amount]
           ,[fine]
           ,[comment]
           ,[recept_no]
           ,[payment_mode]
           ,[payment_date]
           ,[ip]
           ,[created_by]
           ,[created_on]
           ,[updated_by]
           ,[updated_on])
     SELECT
            objPayment.id,
		    objPayment.school_id,
			objPayment.student_fees_id,
			objPayment.amount,
			objPayment.fine,
			objPayment.comment,
			objPayment.recept_no,
			objPayment.payment_mode,
			objPayment.payment_date,
			objPayment.ip,
			objPayment.created_by,
			objPayment.created_on,
			objPayment.updated_by,
			objPayment.updated_on
	FROM
		 @PaymentTable As objPayment

COMMIT






GO
/****** Object:  StoredProcedure [dbo].[SaveSettings]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Save Settings>
-- =============================================
CREATE PROCEDURE [dbo].[SaveSettings]  @key nvarchar(100), @value nvarchar(100)
AS
BEGIN TRAN
		if(exists (select 1 from Settings where [key]=@key))
			UPDATE Settings Set value = @value WHERE [key] = @key
		ELSE
			INSERT INTO Settings
			   (
					[key]
					,[value]
			   )
			VALUES
			(
				@key,
				@value
			)    
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SetSchoolInfo]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<SetSchoolInfo>
-- =============================================
CREATE PROCEDURE [dbo].[SetSchoolInfo]  @Model schools READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from schools where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE schools
				SET
					[database_id] = obj.database_id,
					[subdomain] = obj.subdomain,
					[domain] = obj.domain,
					[name] = obj.name,
					[address] = obj.address,
					[theme] = obj.theme,
					[created_on] = obj.created_on
				FROM
					@Model AS obj
				WHERE
					schools.id = obj.id
		 ELSE
			INSERT INTO [dbo].[schools]
			   ([id]
			   ,[database_id]
			   ,[subdomain]
			   ,[domain]
			   ,[name]
			   ,[address]
			   ,[theme]
			   ,[created_on])
			 SELECT
					obj.id,
					obj.database_id,
					obj.subdomain,
					obj.domain,
					obj.name,
					obj.address,
					obj.theme,
					obj.created_on
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncFee_categories]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncFee_categories]  @Model fee_categories READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from fee_categories where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE fee_categories
				SET
					[id]			= obj.id,						
					[school_id]		= obj.school_id,
					[name]			= obj.name,
					[recur]			= obj.recur,
					[is_transport]	= obj.is_transport,
					[order]			= obj.[order],
					[created_by]	= obj.created_by,
					[created_on]	= obj.created_on,
					[updated_by]	= obj.updated_by,
					[updated_on]	= obj.updated_on
				FROM
					@Model AS obj
				WHERE
					fee_categories.id = obj.id
		 ELSE
			INSERT INTO [dbo].[fee_categories]
			   ([id]
			   ,[school_id]
			   ,[name]
			   ,[recur]
			   ,[is_transport]
			   ,[order]
			   ,[created_by]
			   ,[created_on]
			   ,[updated_by]
			   ,[updated_on])
			 SELECT
					obj.id,
					obj.school_id,
					obj.name,
					obj.recur,
					obj.is_transport,
					obj.[order],
					obj.created_by,
					obj.created_on,
					obj.updated_by,
					obj.updated_on
			FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncFees]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncFees]  @Model fees READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from fees where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE fees
				SET
					[school_id] = obj.school_id,
					[fee_category_id] = obj.fee_category_id,
					[session_id] = obj.session_id,
					[amount] = obj.amount,
					[fee_cources] = obj.fee_cources,
					[last_date] = obj.last_date,
					[last_day] = obj.last_day,
					[fine_per_day] = obj.fine_per_day,
					[is_allocated] = obj.is_allocated,
					[remarks] = obj.remarks,
					[created_by] = obj.created_by,
					[created_on] = obj.created_on,
					[updated_by] = obj.updated_by,
					[updated_on] = obj.updated_on
				FROM
					@Model AS obj
				WHERE
					fees.id = obj.id
		 ELSE
			INSERT INTO [dbo].[fees]
				   ([id]
				   ,[school_id]
				   ,[fee_category_id]
				   ,[session_id]
				   ,[amount]
				   ,[fee_cources]
				   ,[last_date]
				   ,[last_day]
				   ,[fine_per_day]
				   ,[is_allocated]
				   ,[remarks]
				   ,[created_by]
				   ,[created_on]
				   ,[updated_by]
				   ,[updated_on])
			 SELECT
				   obj.id, 
				   obj.school_id, 
				   obj.fee_category_id, 
				   obj.session_id, 
				   obj.amount, 
				   obj.fee_cources,
				   obj.last_date, 
				   obj.last_day, 
				   obj.fine_per_day, 
				   obj.is_allocated, 
				   obj.remarks, 
				   obj.created_by, 
				   obj.created_on, 
				   obj.updated_by,
				   obj.updated_on
			FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncFiles]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncFiles]  @Model files READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from files where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE files
				SET
					[name] = obj.name,
					[extension] = obj.extension,
					[size] = obj.size,
					[school_id] = obj.school_id,
					[owner_user_id] = obj.owner_user_id,
					[created] = obj.created
				FROM
					@Model AS obj
				WHERE
					files.id = obj.id
		 ELSE
			INSERT INTO [dbo].[files]
				   ([id]
				   ,[name]
				   ,[extension]
				   ,[size]
				   ,[school_id]
				   ,[owner_user_id]
				   ,[created])
			 SELECT
					obj.id,
					obj.name,
					obj.extension,
					obj.size,
					obj.school_id,
					obj.owner_user_id,
					obj.created
			FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncGrade_fees]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncGrade_fees]  @Model grade_fees READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from grade_fees where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE grade_fees
				SET
					[school_id] = obj.school_id,
					[fees_id] = obj.fees_id,
					[grade_id] = obj.grade_id,
					[created_by] = obj.created_by,
					[created_on] = obj.created_on,
					[updated_by] = obj.updated_by,
					[updated_on] = obj.updated_on
				FROM
					@Model AS obj
				WHERE
					grade_fees.id = obj.id
		 ELSE
			INSERT INTO [dbo].[grade_fees]
			   ([id]
			   ,[school_id]
			   ,[fees_id]
			   ,[grade_id]
			   ,[created_by]
			   ,[created_on]
			   ,[updated_by]
			   ,[updated_on])
			 SELECT
					obj.id,
					obj.school_id,
					obj.fees_id,
					obj.grade_id,
					obj.created_by,
					obj.created_on,
					obj.updated_by,
					obj.updated_on
			FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncGrades]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncGrades]  @Model grades READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from grades where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE grades
				SET
					[school_id] = obj.school_id,
					[block] = obj.block,
					[name] = obj.name,
					[order] = obj.[order],
					[created_by] = obj.created_by,
					[created_on] = obj.created_on,
					[updated_by] = obj.updated_by,
					[updated_on] = obj.updated_on
				FROM
					@Model AS obj
				WHERE
					grades.id = obj.id
		 ELSE
			INSERT INTO [dbo].[grades]
			   ([id]
			   ,[school_id]
			   ,[block]
			   ,[name]
			   ,[order]
			   ,[created_by]
			   ,[created_on]
			   ,[updated_by]
			   ,[updated_on])
			 SELECT
					obj.id,
					obj.school_id,
					obj.block,
					obj.name,
					obj.[order],
					obj.created_by,
					obj.created_on,
					obj.updated_by,
					obj.updated_on
			FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncParents]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncParents]  @Model parents READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from parents where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE parents
				SET
					[school_id] = obj.school_id,
					[f_first_name] = obj.f_first_name,
					[f_middle_name] = obj.f_middle_name,
					[f_last_name] = obj.f_last_name,
					[f_mobile] = obj.f_mobile,
					[f_phone] = obj.f_phone,
					[f_office] = obj.f_office,
					[f_email] = obj.f_email,
					[m_first_name] = obj.m_first_name,
					[m_middle_name] = obj.m_middle_name,
					[m_last_name] = obj.m_last_name,
					[m_mobile] = obj.m_mobile,
					[m_phone] = obj.m_phone,
					[m_office] = obj.m_office,
					[m_email] = obj.m_email,
					[g_fullname] = obj.g_fullname,
					[g_mobile] = obj.g_mobile,
					[g_email] = obj.g_email
				FROM
					@Model AS obj
				WHERE
					parents.id = obj.id
		 ELSE
			INSERT INTO [dbo].[parents]
			   ([id]
			   ,[school_id]
			   ,[f_first_name]
			   ,[f_middle_name]
			   ,[f_last_name]
			   ,[f_mobile]
			   ,[f_phone]
			   ,[f_office]
			   ,[f_email]
			   ,[m_first_name]
			   ,[m_middle_name]
			   ,[m_last_name]
			   ,[m_mobile]
			   ,[m_phone]
			   ,[m_office]
			   ,[m_email]
			   ,[g_fullname]
			   ,[g_mobile]
			   ,[g_email])
			 SELECT
					obj.id,
					obj.school_id,
					obj.f_first_name,
					obj.f_middle_name,
					obj.f_last_name,
					obj.f_mobile,
					obj.f_phone,
					obj.f_office,
					obj.f_email,
					obj.m_first_name,
					obj.m_middle_name,
					obj.m_last_name,
					obj.m_mobile,
					obj.m_phone,
					obj.m_office,
					obj.m_email,
					obj.g_fullname,
					obj.g_mobile,
					obj.g_email
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncRoute_stops]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncRoute_stops]  @Model route_stops READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from route_stops where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE route_stops
				SET
					[school_id] = obj.school_id,
					[route_id] = obj.route_id,
					[name] = obj.name,
					[latitude] = obj.latitude,
					[longitude] = obj.longitude,
					[created_by] = obj.created_by,
					[created_on] = obj.created_on,
					[updated_by] = obj.updated_by,
					[updated_on] = obj.updated_on
				FROM
					@Model AS obj
				WHERE
					route_stops.id = obj.id
		 ELSE
			INSERT INTO [dbo].[route_stops]
			   ([id]
			   ,[school_id]
			   ,[route_id]
			   ,[name]
			   ,[latitude]
			   ,[longitude]
			   ,[created_by]
			   ,[created_on]
			   ,[updated_by]
			   ,[updated_on])
			 SELECT
					obj.id,
					obj.school_id,
					obj.route_id,
					obj.name,
					obj.latitude,
					obj.longitude,
					obj.created_by,
					obj.created_on,
					obj.updated_by,
					obj.updated_on
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncRoute_vehicle_stops]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncRoute_vehicle_stops]  @Model route_vehicle_stops READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from route_vehicle_stops where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE route_vehicle_stops
				SET
					[school_id] = obj.school_id,
					[route_vehicle_id] = obj.route_vehicle_id,
					[route_stop_id] = obj.route_stop_id
				FROM
					@Model AS obj
				WHERE
					route_vehicle_stops.id = obj.id
		 ELSE
			INSERT INTO [dbo].[route_vehicle_stops]
			   ([id]
			   ,[school_id]
			   ,[route_vehicle_id]
			   ,[route_stop_id])
			 SELECT
					obj.id,
					obj.school_id,
					obj.route_vehicle_id,
					obj.route_stop_id
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncRoute_vehicle_stops_fee_logs]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncRoute_vehicle_stops_fee_logs]  @Model route_vehicle_stops_fee_logs READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from route_vehicle_stops_fee_logs where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE route_vehicle_stops_fee_logs
				SET
					[route_vehicle_stop_id] = obj.route_vehicle_stop_id,
					[fees_id] = obj.fees_id
				FROM
					@Model AS obj
				WHERE
					route_vehicle_stops_fee_logs.id = obj.id
		 ELSE
			INSERT INTO [dbo].[route_vehicle_stops_fee_logs]
			   ([id]
			   ,[route_vehicle_stop_id]
			   ,[fees_id])
			 SELECT
					obj.id,
					obj.route_vehicle_stop_id,
					obj.fees_id
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncRoute_vehicles]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncRoute_vehicles]  @Model route_vehicles READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from route_vehicles where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE route_vehicles
				SET
					[school_id] = obj.school_id,
					[vehicle_id] = obj.vehicle_id,
					[route_id] = obj.route_id
				FROM
					@Model AS obj
				WHERE
					route_vehicles.id = obj.id
		 ELSE
			INSERT INTO [dbo].[route_vehicles]
			   ([id]
			   ,[school_id]
			   ,[vehicle_id]
			   ,[route_id])
			 SELECT
					obj.id,
					obj.school_id,
					obj.vehicle_id,
					obj.route_id
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncRoutes]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncRoutes]  @Model routes READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from routes where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE routes
				SET
					[school_id] = obj.school_id,
					[name] = obj.name,
					[start_location] = obj.start_location,
					[end_location] = obj.end_location,
					[created_by] = obj.created_by,
					[created_on] = obj.created_on,
					[updated_by] = obj.updated_by,
					[updated_on] = obj.updated_on
				FROM
					@Model AS obj
				WHERE
					routes.id = obj.id
		 ELSE
			INSERT INTO [dbo].[routes]
			   ([id]
			   ,[school_id]
			   ,[name]
			   ,[start_location]
			   ,[end_location]
			   ,[created_by]
			   ,[created_on]
			   ,[updated_by]
			   ,[updated_on])
			 SELECT
					obj.id,
					obj.school_id,
					obj.name,
					obj.start_location,
					obj.end_location,
					obj.created_by,
					obj.created_on,
					obj.updated_by,
					obj.updated_on
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncSections]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncSections]  @Model sections READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from sections where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE sections
				SET
					[school_id] = obj.school_id,
					[name] = obj.name,
					[capacity] = obj.capacity,
					[created_by] = obj.created_by,
					[created_on] = obj.created_on
				FROM
					@Model AS obj
				WHERE
					sections.id = obj.id
		 ELSE
			INSERT INTO [dbo].[sections]
			   ([id]
			   ,[school_id]
			   ,[name]
			   ,[capacity]
			   ,[created_by]
			   ,[created_on])
			 SELECT
					obj.id,
					obj.school_id,
					obj.name,
					obj.capacity,
					obj.created_by,
					obj.created_on
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncSessions]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncSessions]  @Model sessions READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from sessions where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE sessions
				SET
					[school_id] = obj.school_id,
					[name] = obj.name,
					[order] = obj.[order],
					[from_date] = obj.from_date,
					[to_date] = obj.to_date,
					[created_by] = obj.created_by,
					[created_on] = obj.created_on
				FROM
					@Model AS obj
				WHERE
					sessions.id = obj.id
		 ELSE
			INSERT INTO [dbo].[sessions]
			   ([id]
			   ,[school_id]
			   ,[name]
			   ,[order]
			   ,[from_date]
			   ,[to_date]
			   ,[created_by]
			   ,[created_on])
			 SELECT
					obj.id,
					obj.school_id,
					obj.name,
					obj.[order],
					obj.from_date,
					obj.to_date,
					obj.created_by,
					obj.created_on
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncStudent_fees]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncStudent_fees]  @Model student_fees READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from student_fees where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE student_fees
				SET
					[school_id] = obj.school_id,
					[grade_fees_id] = obj.grade_fees_id,
					[student_id] = obj.student_id,
					[route_vehicle_stops_fee_log_id] = obj.route_vehicle_stops_fee_log_id,
					[apply_from] = obj.apply_from,
					[apply_to] = obj.apply_to,
					[fine] = obj.fine,
					[concession_amount] = obj.concession_amount,
					[no_fine] = obj.no_fine,
					[created_by] = obj.created_by,
					[created_on] = obj.created_on,
					[updated_by] = obj.updated_by,
					[updated_on] = obj.updated_on
				FROM
					@Model AS obj
				WHERE
					student_fees.id = obj.id
		 ELSE
			INSERT INTO [dbo].[student_fees]
			   ([id]
			   ,[school_id]
			   ,[grade_fees_id]
			   ,[student_id]
			   ,[route_vehicle_stops_fee_log_id]
			   ,[apply_from]
			   ,[apply_to]
			   ,[fine]
			   ,[concession_amount]
			   ,[no_fine]
			   ,[created_by]
			   ,[created_on]
			   ,[updated_by]
			   ,[updated_on])
			 SELECT
					obj.id,
					obj.school_id,
					obj.grade_fees_id,
					obj.student_id,
					obj.route_vehicle_stops_fee_log_id,
					obj.apply_from,
					obj.apply_to,
					obj.fine,
					obj.concession_amount,
					obj.no_fine,
					obj.created_by,
					obj.created_on,
					obj.updated_by,
					obj.updated_on
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncStudent_grade_session_log]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncStudent_grade_session_log]  @Model student_grade_session_log READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from student_grade_session_log where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE student_grade_session_log
				SET
					[school_id] = obj.school_id,
					[student_id] = obj.student_id,
					[registration_id] = obj.registration_id,
					[grade_id] = obj.grade_id,
					[section_id] = obj.section_id,
					[roll_number] = obj.roll_number,
					[exam_roll_number] = obj.exam_roll_number,
					[session_id] = obj.session_id,
					[sgsl_status] = obj.sgsl_status,
					[created_by] = obj.created_by,
					[created_on] = obj.created_on,
					[updated_by] = obj.updated_by,
					[updated_on] = obj.updated_on
				FROM
					@Model AS obj
				WHERE
					student_grade_session_log.id = obj.id
		 ELSE
			INSERT INTO [dbo].[student_grade_session_log]
			   ([id]
			   ,[school_id]
			   ,[student_id]
			   ,[registration_id]
			   ,[grade_id]
			   ,[section_id]
			   ,[roll_number]
			   ,[exam_roll_number]
			   ,[session_id]
			   ,[sgsl_status]
			   ,[created_by]
			   ,[created_on]
			   ,[updated_by]
			   ,[updated_on])
			 SELECT
					obj.id,
					obj.school_id,
					obj.student_id,
					obj.registration_id,
					obj.grade_id,
					obj.section_id,
					obj.roll_number,
					obj.exam_roll_number,
					obj.session_id,
					obj.sgsl_status,
					obj.created_by,
					obj.created_on,
					obj.updated_by,
					obj.updated_on
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncStudent_payments]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncStudent_payments]  @Model student_payments READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from student_payments where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE student_payments
				SET
					school_id = obj.school_id,
					student_fees_id = obj.student_fees_id,
					amount = obj.amount,
					fine = obj.fine,
					comment = obj.comment,
					recept_no = obj.recept_no,
					payment_mode = obj.payment_mode,
					payment_date = obj.payment_date,
					ip = obj.ip,
					created_by = obj.created_by,
					created_on = obj.created_on,
					updated_by = obj.updated_by,
					updated_on = obj.updated_on
				FROM
					@Model AS obj
				WHERE
					student_payments.id = obj.id
		 ELSE
			INSERT INTO [dbo].[student_payments]
				   ([id]
				   ,[school_id]
				   ,[student_fees_id]
				   ,[amount]
				   ,[fine]
				   ,[comment]
				   ,[recept_no]
				   ,[payment_mode]
				   ,[payment_date]
				   ,[ip]
				   ,[created_by]
				   ,[created_on]
				   ,[updated_by]
				   ,[updated_on])
			 SELECT
					obj.id,
					obj.school_id,
					obj.student_fees_id,
					obj.amount,
					obj.fine,
					obj.comment,
					obj.recept_no,
					obj.payment_mode,
					obj.payment_date,
					obj.ip,
					obj.created_by,
					obj.created_on,
					obj.updated_by,
					obj.updated_on
			FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncStudents]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncStudents]  @Model students READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from students where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE students
				SET
					[school_id] = obj.school_id,
					[user_id] = obj.user_id,
					[parent_id] = obj.parent_id,
					[grade_id] = obj.grade_id,
					[section_id] = obj.section_id,
					[session_id] = obj.session_id,
					[trip_stop_id] = obj.trip_stop_id,
					[registration_id] = obj.registration_id,
					[roll_number] = obj.roll_number,
					[exam_roll_number] = obj.exam_roll_number,
					[enrollment_date] = obj.enrollment_date,
					[status] = obj.status,
					[dc_number] = obj.dc_number,
					[dc_date_of_issue] = obj.dc_date_of_issue,
					[created_by] = obj.created_by,
					[created_on] = obj.created_on,
					[updated_by] = obj.updated_by,
					[updated_on] = obj.updated_on
				FROM
					@Model AS obj
				WHERE
					students.id = obj.id
		 ELSE
			INSERT INTO [dbo].[students]
			   ([id]
			   ,[school_id]
			   ,[user_id]
			   ,[parent_id]
			   ,[grade_id]
			   ,[section_id]
			   ,[session_id]
			   ,[trip_stop_id]
			   ,[registration_id]
			   ,[roll_number]
			   ,[exam_roll_number]
			   ,[enrollment_date]
			   ,[status]
			   ,[dc_number]
			   ,[dc_date_of_issue]
			   ,[created_by]
			   ,[created_on]
			   ,[updated_by]
			   ,[updated_on])
			 SELECT
					obj.id,
					obj.school_id,
					obj.user_id,
					obj.parent_id,
					obj.grade_id,
					obj.section_id,
					obj.session_id,
					obj.trip_stop_id,
					obj.registration_id,
					obj.roll_number,
					obj.exam_roll_number,
					obj.enrollment_date,
					obj.status,
					obj.dc_number,
					obj.dc_date_of_issue,
					obj.created_by,
					obj.created_on,
					obj.updated_by,
					obj.updated_on
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncTrip_stops]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncTrip_stops]  @Model trip_stops READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from trip_stops where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE trip_stops
				SET
					[school_id] = obj.school_id,
					[route_vehicle_stop_id] = obj.route_vehicle_stop_id,
					[trip] = obj.trip,
					[pick] = obj.pick,
					[drop] = obj.[drop]
				FROM
					@Model AS obj
				WHERE
					trip_stops.id = obj.id
		 ELSE
			INSERT INTO [dbo].[trip_stops]
			   ([id]
			   ,[school_id]
			   ,[route_vehicle_stop_id]
			   ,[trip]
			   ,[pick]
			   ,[drop])
			 SELECT
					obj.id,
					obj.school_id,
					obj.route_vehicle_stop_id,
					obj.trip,
					obj.pick,
					obj.[drop]
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncUser_avatar_files]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncUser_avatar_files]  @Model user_avatar_files READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from user_avatar_files where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE user_avatar_files
				SET
					[school_id] = obj.school_id,
					[user_id] = obj.user_id,
					[applicant_id] = obj.applicant_id,
					[file_id] = obj.file_id
				FROM
					@Model AS obj
				WHERE
					user_avatar_files.id = obj.id
		 ELSE
			INSERT INTO [dbo].[user_avatar_files]
			   ([id]
			   ,[school_id]
			   ,[user_id]
			   ,[applicant_id]
			   ,[file_id])
			 SELECT
					obj.id,
					obj.school_id,
					obj.user_id,
					obj.applicant_id,
					obj.file_id
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncUsers]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncUsers]  @Model users READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from users where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE users
				SET
					[school_id] = obj.school_id,
					[student_id] = obj.student_id,
					[role_id] = obj.role_id,
					[user_type] = obj.user_type,
					[username] = obj.username,
					[email] = obj.email,
					[phone] = obj.phone,
					[address_line_one] = obj.address_line_one,
					[address_line_two] = obj.address_line_two,
					[area] = obj.area,
					[first_name] = obj.first_name,
					[middle_name] = obj.middle_name,
					[last_name] = obj.last_name,
					[full_name] = obj.full_name,
					[gender] = obj.gender,
					[blood_group] = obj.blood_group,
					[password] = obj.password,
					[birth_date] = obj.birth_date,
					[other_phones] = obj.other_phones,
					[default_phone_number_id] = obj.default_phone_number_id,
					[adhaar_number] = obj.adhaar_number,
					[bank_name] = obj.bank_name,
					[bank_branch] = obj.bank_branch,
					[bank_account_number] = obj.bank_account_number,
					[bank_ifsc_code] = obj.bank_ifsc_code,
					[flags] = obj.flags,
					[last_login_time] = obj.last_login_time,
					[user_avatar_file_id] = obj.user_avatar_file_id,
					[status] = obj.status,
					[created_on] = obj.created_on,
					[created_by] = obj.created_by,
					[updated_on] = obj.updated_on,
					[updated_by] = obj.updated_by
				FROM
					@Model AS obj
				WHERE
					users.id = obj.id
		 ELSE
			INSERT INTO [dbo].[users]
			   ([id]
			   ,[school_id]
			   ,[student_id]
			   ,[role_id]
			   ,[user_type]
			   ,[username]
			   ,[email]
			   ,[phone]
			   ,[address_line_one]
			   ,[address_line_two]
			   ,[area]
			   ,[first_name]
			   ,[middle_name]
			   ,[last_name]
			   ,[full_name]
			   ,[gender]
			   ,[blood_group]
			   ,[password]
			   ,[birth_date]
			   ,[other_phones]
			   ,[default_phone_number_id]
			   ,[adhaar_number]
			   ,[bank_name]
			   ,[bank_branch]
			   ,[bank_account_number]
			   ,[bank_ifsc_code]
			   ,[flags]
			   ,[last_login_time]
			   ,[user_avatar_file_id]
			   ,[status]
			   ,[created_on]
			   ,[created_by]
			   ,[updated_on]
			   ,[updated_by])
			 SELECT
					obj.id,
					obj.school_id,
					obj.student_id,
					obj.role_id,
					obj.user_type,
					obj.username,
					obj.email,
					obj.phone,
					obj.address_line_one,
					obj.address_line_two,
					obj.area,
					obj.first_name,
					obj.middle_name,
					obj.last_name,
					obj.full_name,
					obj.gender,
					obj.blood_group,
					obj.password,
					obj.birth_date,
					obj.other_phones,
					obj.default_phone_number_id,
					obj.adhaar_number,
					obj.bank_name,
					obj.bank_branch,
					obj.bank_account_number,
					obj.bank_ifsc_code,
					obj.flags,
					obj.last_login_time,
					obj.user_avatar_file_id,
					obj.status,
					obj.created_on,
					obj.created_by,
					obj.updated_on,
					obj.updated_by
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SyncVehicles]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Sync>
-- =============================================
CREATE PROCEDURE [dbo].[SyncVehicles]  @Model vehicles READONLY
AS
BEGIN TRAN
		IF(exists (select 1 from vehicles where id=(SELECT obj.id FROM @Model As obj)))
			UPDATE vehicles
				SET
					[school_id] = obj.school_id,
					[tracker_id] = obj.tracker_id,
					[registration_number] = obj.registration_number,
					[bus_number] = obj.bus_number,
					[insurance_renew_date] = obj.insurance_renew_date,
					[staff_id] = obj.staff_id,
					[created_by] = obj.created_by,
					[created_on] = obj.created_on,
					[updated_by] = obj.updated_by,
					[updated_on] = obj.updated_on
				FROM
					@Model AS obj
				WHERE
					vehicles.id = obj.id
		 ELSE
			INSERT INTO [dbo].[vehicles]
			   ([id]
			   ,[school_id]
			   ,[tracker_id]
			   ,[registration_number]
			   ,[bus_number]
			   ,[insurance_renew_date]
			   ,[staff_id]
			   ,[created_by]
			   ,[created_on]
			   ,[updated_by]
			   ,[updated_on])
			 SELECT
					obj.id,
					obj.school_id,
					obj.tracker_id,
					obj.registration_number,
					obj.bus_number,
					obj.insurance_renew_date,
					obj.staff_id,
					obj.created_by,
					obj.created_on,
					obj.updated_by,
					obj.updated_on
			  FROM
				 @Model As obj
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[UpdateFeeDue]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Update Fee Due>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateFeeDue] @StudentFeesTable FeeDueModel READONLY
AS
BEGIN
	UPDATE student_fees
		SET
			fine = objFeeDue.fine,
			concession_amount = objFeeDue.concession_amount,
			updated_by = objFeeDue.updated_by,
			updated_on = objFeeDue.updated_on
		FROM
			@StudentFeesTable AS objFeeDue
		WHERE
			student_fees.id = objFeeDue.id

END






GO
/****** Object:  StoredProcedure [dbo].[UpdatePayment]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Update Payment>
-- =============================================
CREATE PROCEDURE [dbo].[UpdatePayment] @PaymentTable PaymentModel READONLY
AS
BEGIN TRAN
	UPDATE student_payments
		SET
			recept_no = objPayment.recept_no,
			fine = objPayment.fine,
			amount = objPayment.amount,
			comment = objPayment.comment,
			updated_by = objPayment.updated_by,
			updated_on = objPayment.updated_on
		FROM
			@PaymentTable AS objPayment
		WHERE
			student_payments.id_offline = objPayment.id_offline

COMMIT




GO
/****** Object:  StoredProcedure [dbo].[UpdateSyncTableInfo]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Arif Nazir>
-- Create date: <Create Date,,>
-- Description:	<Update SyncTableInfo>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateSyncTableInfo] @ID uniqueidentifier , @LastSyncedOn datetime 
AS
BEGIN
	UPDATE SyncTableInfo
		SET
			LastSyncedOn =  @LastSyncedOn
		WHERE
			id_Offline = @ID

END






GO
/****** Object:  Table [dbo].[fee_categories]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fee_categories](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[name] [varchar](45) NOT NULL,
	[recur] [varchar](10) NOT NULL,
	[is_transport] [int] NULL,
	[order] [bigint] NOT NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[fees]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fees](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[fee_category_id] [bigint] NOT NULL,
	[session_id] [bigint] NOT NULL,
	[amount] [float] NOT NULL,
	[fee_cources] [varchar](max) NULL,
	[last_date] [date] NULL,
	[last_day] [int] NULL,
	[fine_per_day] [float] NULL,
	[is_allocated] [smallint] NOT NULL,
	[remarks] [varchar](max) NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [int] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[files]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[files](
	[id] [bigint] NOT NULL,
	[name] [varchar](255) NULL,
	[extension] [varchar](45) NULL,
	[size] [int] NULL,
	[school_id] [int] NULL,
	[owner_user_id] [int] NULL,
	[created] [datetime2](0) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[grade_fees]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[grade_fees](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[fees_id] [bigint] NOT NULL,
	[grade_id] [bigint] NOT NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[grades]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[grades](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[block] [varchar](50) NULL,
	[name] [varchar](45) NOT NULL,
	[order] [bigint] NOT NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[parents]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[parents](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[f_first_name] [varchar](45) NOT NULL,
	[f_middle_name] [varchar](45) NULL,
	[f_last_name] [varchar](45) NOT NULL,
	[f_mobile] [varchar](15) NULL,
	[f_phone] [varchar](15) NULL,
	[f_office] [varchar](15) NULL,
	[f_email] [varchar](45) NULL,
	[m_first_name] [varchar](45) NULL,
	[m_middle_name] [varchar](45) NULL,
	[m_last_name] [varchar](45) NULL,
	[m_mobile] [varchar](15) NULL,
	[m_phone] [varchar](15) NULL,
	[m_office] [varchar](15) NULL,
	[m_email] [varchar](45) NULL,
	[g_fullname] [varchar](45) NULL,
	[g_mobile] [varchar](15) NULL,
	[g_email] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[route_stops]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[route_stops](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[route_id] [bigint] NOT NULL,
	[name] [varchar](max) NOT NULL,
	[latitude] [varchar](max) NULL,
	[longitude] [varchar](max) NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[route_vehicle_stops]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[route_vehicle_stops](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[route_vehicle_id] [bigint] NOT NULL,
	[route_stop_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[route_vehicle_stops_fee_logs]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[route_vehicle_stops_fee_logs](
	[id] [bigint] NOT NULL,
	[route_vehicle_stop_id] [bigint] NOT NULL,
	[fees_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[route_vehicles]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[route_vehicles](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[vehicle_id] [bigint] NOT NULL,
	[route_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[routes]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[routes](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[start_location] [varchar](max) NULL,
	[end_location] [varchar](max) NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[schools]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[schools](
	[id] [bigint] NOT NULL,
	[database_id] [bigint] NOT NULL,
	[subdomain] [varchar](45) NOT NULL,
	[domain] [varchar](max) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[address] [varchar](max) NULL,
	[theme] [varchar](max) NULL,
	[created_on] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sections]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[sections](
	[id] [bigint] NOT NULL,
	[school_id] [int] NOT NULL,
	[name] [varchar](10) NOT NULL,
	[capacity] [int] NOT NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sessions]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[sessions](
	[id] [bigint] NOT NULL,
	[school_id] [int] NOT NULL,
	[name] [varchar](45) NOT NULL,
	[order] [int] NOT NULL,
	[from_date] [datetime2](0) NULL,
	[to_date] [datetime2](0) NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_sessions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[id] [uniqueidentifier] NOT NULL,
	[key] [nvarchar](100) NOT NULL,
	[value] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[student_fees]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_fees](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[grade_fees_id] [bigint] NULL,
	[student_id] [bigint] NOT NULL,
	[route_vehicle_stops_fee_log_id] [bigint] NULL,
	[apply_from] [date] NOT NULL,
	[apply_to] [date] NOT NULL,
	[fine] [float] NULL,
	[concession_amount] [float] NULL,
	[no_fine] [smallint] NOT NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[student_grade_session_log]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[student_grade_session_log](
	[id] [varchar](10) NULL,
	[school_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
	[registration_id] [varchar](45) NOT NULL,
	[grade_id] [int] NOT NULL,
	[section_id] [int] NOT NULL,
	[roll_number] [int] NOT NULL,
	[exam_roll_number] [varchar](45) NULL,
	[session_id] [int] NOT NULL,
	[sgsl_status] [varchar](50) NOT NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [int] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[student_payments]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[student_payments](
	[id_offline] [uniqueidentifier] NOT NULL,
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[student_fees_id] [bigint] NOT NULL,
	[amount] [float] NOT NULL,
	[fine] [float] NULL,
	[comment] [varchar](max) NULL,
	[recept_no] [varchar](45) NULL,
	[payment_mode] [varchar](50) NOT NULL,
	[payment_date] [datetime2](0) NOT NULL,
	[ip] [varchar](45) NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_offline] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[students]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[students](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
	[parent_id] [bigint] NULL,
	[grade_id] [bigint] NOT NULL,
	[section_id] [bigint] NOT NULL,
	[session_id] [bigint] NOT NULL,
	[trip_stop_id] [bigint] NULL,
	[registration_id] [varchar](45) NOT NULL,
	[roll_number] [varchar](45) NULL,
	[exam_roll_number] [varchar](45) NULL,
	[enrollment_date] [date] NULL,
	[status] [varchar](50) NOT NULL,
	[dc_number] [int] NULL,
	[dc_date_of_issue] [date] NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SyncTableInfo]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SyncTableInfo](
	[id_offline] [uniqueidentifier] NOT NULL,
	[TableName] [nvarchar](100) NOT NULL,
	[LastSyncedOn] [datetime] NULL,
 CONSTRAINT [PK_Sync] PRIMARY KEY CLUSTERED 
(
	[id_offline] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[trip_stops]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[trip_stops](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[route_vehicle_stop_id] [int] NOT NULL,
	[trip] [varchar](50) NOT NULL,
	[pick] [time](7) NOT NULL,
	[drop] [time](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[user_avatar_files]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_avatar_files](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[user_id] [bigint] NULL,
	[applicant_id] [bigint] NULL,
	[file_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[users](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[student_id] [bigint] NULL,
	[role_id] [bigint] NULL,
	[user_type] [varchar](50) NOT NULL,
	[username] [varchar](45) NULL,
	[email] [varchar](100) NULL,
	[phone] [varchar](20) NULL,
	[address_line_one] [text] NULL,
	[address_line_two] [text] NULL,
	[area] [varchar](45) NULL,
	[first_name] [varchar](100) NOT NULL,
	[middle_name] [varchar](100) NULL,
	[last_name] [varchar](100) NULL,
	[full_name] [varchar](300) NULL,
	[gender] [varchar](50) NOT NULL,
	[blood_group] [varchar](50) NULL,
	[password] [varchar](200) NULL,
	[birth_date] [date] NOT NULL,
	[other_phones] [text] NULL,
	[default_phone_number_id] [bigint] NULL,
	[adhaar_number] [bigint] NULL,
	[bank_name] [varchar](100) NULL,
	[bank_branch] [varchar](100) NULL,
	[bank_account_number] [varchar](100) NULL,
	[bank_ifsc_code] [varchar](100) NULL,
	[flags] [text] NULL,
	[last_login_time] [datetime] NULL,
	[user_avatar_file_id] [bigint] NULL,
	[status] [varchar](50) NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [bigint] NULL,
	[updated_on] [datetime] NULL,
	[updated_by] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[vehicles]    Script Date: 1/9/2018 5:49:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vehicles](
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[tracker_id] [bigint] NULL,
	[registration_number] [varchar](50) NOT NULL,
	[bus_number] [varchar](15) NULL,
	[insurance_renew_date] [date] NULL,
	[staff_id] [bigint] NULL,
	[created_by] [bigint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[updated_by] [bigint] NOT NULL,
	[updated_on] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[schools] ([id], [database_id], [subdomain], [domain], [name], [address], [theme], [created_on]) VALUES (5, 0, N'subdomain', N'http://volcanix.schooluniverse.in', N'name', N'address', N'theme', CAST(0x000000004C320B0000 AS DateTime2))
INSERT [dbo].[sessions] ([id], [school_id], [name], [order], [from_date], [to_date], [created_by], [created_on]) VALUES (1, 5, N'2015-2016', 1, CAST(0x000000009E3A0B0000 AS DateTime2), CAST(0x000000000B3C0B0000 AS DateTime2), 1, CAST(0x00527A00633B0B0000 AS DateTime2))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'9b7a4a9e-1373-441e-ad41-083ba834bead', N'student_payments', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'4845a1fd-2add-460e-8b21-0b8090cf20eb', N'student_grade_session_log', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'3fc056ab-28b0-4187-bfa8-12d2e8f7cbcb', N'route_vehicles', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'43a9f8ba-5e44-4d08-8ea1-3c6e3ee636f9', N'fees', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'0fc8179a-4b18-4566-81c0-4119bc7564ed', N'fee_categories', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'c3df8977-cbce-42c0-9700-4b5c11a82009', N'sessions', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'ef4bda62-5800-4e4f-95ae-4f1e2fd17ee0', N'students', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'3ee5c718-bc0c-4d6a-a492-554cea7db789', N'user_avatar_files', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'e10df2a3-626e-49ed-8a03-5e1109e8c568', N'users', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'08171725-c6e9-4394-8bf7-5ed8cb7dd39f', N'route_stops', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'432acca0-5f2b-4e6d-b98f-61fb32e5bd76', N'routes', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'1a73db0f-fd6a-4776-8225-624c62dae687', N'student_fees', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'3146e2ef-90ab-4f48-8ac1-812e392450f1', N'grades', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'2c35a274-3144-49f3-a66c-ab07f12b20ef', N'route_vehicle_stops_fee_logs', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'61cb58cb-883d-4862-9773-b606abbe5775', N'grade_fees', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'5a6ed1a1-d6ec-49dc-854e-c1ef40a29ccf', N'parents', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'ba0ebbe8-9bc4-4905-ac51-dc9414549588', N'sections', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'a376667a-85e0-4121-93c4-e9fc43e489ff', N'vehicles', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'f188df99-4602-4884-b160-ec13b91b9432', N'route_vehicle_stops', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'a658ca68-6efe-49c0-8fd9-ede9c8a03e79', N'trip_stops', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[SyncTableInfo] ([id_offline], [TableName], [LastSyncedOn]) VALUES (N'24e91168-b43d-4def-ac50-fd9f46644eb9', N'files', CAST(0xFFFF2E4600000000 AS DateTime))
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (0, 0, NULL, NULL, N'staff', N'suadmin', NULL, NULL, NULL, NULL, NULL, N'SU', NULL, N'ADMIN', NULL, N'male', N'', N'suadmin', CAST(0x7C130B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', CAST(0x0000A80E00000000 AS DateTime), NULL, CAST(0x0000A80E00000000 AS DateTime), NULL)
ALTER TABLE [dbo].[fee_categories] ADD  DEFAULT ('0') FOR [recur]
GO
ALTER TABLE [dbo].[fee_categories] ADD  DEFAULT (NULL) FOR [is_transport]
GO
ALTER TABLE [dbo].[fees] ADD  DEFAULT (NULL) FOR [last_date]
GO
ALTER TABLE [dbo].[fees] ADD  DEFAULT (NULL) FOR [last_day]
GO
ALTER TABLE [dbo].[fees] ADD  DEFAULT (NULL) FOR [fine_per_day]
GO
ALTER TABLE [dbo].[fees] ADD  DEFAULT ('0') FOR [is_allocated]
GO
ALTER TABLE [dbo].[files] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[files] ADD  DEFAULT (NULL) FOR [extension]
GO
ALTER TABLE [dbo].[files] ADD  DEFAULT (NULL) FOR [size]
GO
ALTER TABLE [dbo].[files] ADD  DEFAULT (NULL) FOR [school_id]
GO
ALTER TABLE [dbo].[files] ADD  DEFAULT (NULL) FOR [owner_user_id]
GO
ALTER TABLE [dbo].[files] ADD  DEFAULT (NULL) FOR [created]
GO
ALTER TABLE [dbo].[grades] ADD  DEFAULT (NULL) FOR [block]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [f_middle_name]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [f_mobile]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [f_phone]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [f_office]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [f_email]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [m_first_name]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [m_middle_name]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [m_last_name]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [m_mobile]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [m_phone]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [m_office]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [m_email]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [g_fullname]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [g_mobile]
GO
ALTER TABLE [dbo].[parents] ADD  DEFAULT (NULL) FOR [g_email]
GO
ALTER TABLE [dbo].[sessions] ADD  DEFAULT (NULL) FOR [from_date]
GO
ALTER TABLE [dbo].[sessions] ADD  DEFAULT (NULL) FOR [to_date]
GO
ALTER TABLE [dbo].[Settings] ADD  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[student_fees] ADD  DEFAULT (NULL) FOR [grade_fees_id]
GO
ALTER TABLE [dbo].[student_fees] ADD  DEFAULT (NULL) FOR [route_vehicle_stops_fee_log_id]
GO
ALTER TABLE [dbo].[student_fees] ADD  DEFAULT ('0') FOR [fine]
GO
ALTER TABLE [dbo].[student_fees] ADD  DEFAULT ('0') FOR [concession_amount]
GO
ALTER TABLE [dbo].[student_fees] ADD  DEFAULT ('0') FOR [no_fine]
GO
ALTER TABLE [dbo].[student_grade_session_log] ADD  DEFAULT (NULL) FOR [id]
GO
ALTER TABLE [dbo].[student_grade_session_log] ADD  DEFAULT (NULL) FOR [exam_roll_number]
GO
ALTER TABLE [dbo].[student_grade_session_log] ADD  DEFAULT ('active') FOR [sgsl_status]
GO
ALTER TABLE [dbo].[student_payments] ADD  DEFAULT (newid()) FOR [id_offline]
GO
ALTER TABLE [dbo].[student_payments] ADD  DEFAULT (NULL) FOR [fine]
GO
ALTER TABLE [dbo].[student_payments] ADD  DEFAULT (NULL) FOR [recept_no]
GO
ALTER TABLE [dbo].[student_payments] ADD  DEFAULT (NULL) FOR [ip]
GO
ALTER TABLE [dbo].[students] ADD  DEFAULT (NULL) FOR [parent_id]
GO
ALTER TABLE [dbo].[students] ADD  DEFAULT (NULL) FOR [trip_stop_id]
GO
ALTER TABLE [dbo].[students] ADD  DEFAULT (NULL) FOR [roll_number]
GO
ALTER TABLE [dbo].[students] ADD  DEFAULT (NULL) FOR [exam_roll_number]
GO
ALTER TABLE [dbo].[students] ADD  DEFAULT (NULL) FOR [enrollment_date]
GO
ALTER TABLE [dbo].[students] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[students] ADD  DEFAULT (NULL) FOR [dc_number]
GO
ALTER TABLE [dbo].[students] ADD  DEFAULT (NULL) FOR [dc_date_of_issue]
GO
ALTER TABLE [dbo].[SyncTableInfo] ADD  DEFAULT (newid()) FOR [id_offline]
GO
ALTER TABLE [dbo].[user_avatar_files] ADD  DEFAULT (NULL) FOR [user_id]
GO
ALTER TABLE [dbo].[user_avatar_files] ADD  DEFAULT (NULL) FOR [applicant_id]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [student_id]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [role_id]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [username]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [email]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [phone]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [area]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [middle_name]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [last_name]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [full_name]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [blood_group]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [default_phone_number_id]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [adhaar_number]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [bank_name]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [bank_branch]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [bank_account_number]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [bank_ifsc_code]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [last_login_time]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [user_avatar_file_id]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [created_by]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [updated_on]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [updated_by]
GO
ALTER TABLE [dbo].[vehicles] ADD  DEFAULT (NULL) FOR [tracker_id]
GO
ALTER TABLE [dbo].[vehicles] ADD  DEFAULT (NULL) FOR [bus_number]
GO
ALTER TABLE [dbo].[vehicles] ADD  DEFAULT (NULL) FOR [insurance_renew_date]
GO
ALTER TABLE [dbo].[vehicles] ADD  DEFAULT (NULL) FOR [staff_id]
GO
ALTER TABLE [dbo].[fee_categories]  WITH CHECK ADD CHECK  (([recur]='12' OR [recur]='11' OR [recur]='10' OR [recur]='9' OR [recur]='8' OR [recur]='7' OR [recur]='6' OR [recur]='5' OR [recur]='4' OR [recur]='3' OR [recur]='2' OR [recur]='1' OR [recur]='0'))
GO
ALTER TABLE [dbo].[fee_categories]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[fee_categories]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[fees]  WITH CHECK ADD CHECK  (([created_by]>=(0)))
GO
ALTER TABLE [dbo].[fees]  WITH CHECK ADD CHECK  (([fee_category_id]>=(0)))
GO
ALTER TABLE [dbo].[fees]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[fees]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[fees]  WITH CHECK ADD CHECK  (([session_id]>=(0)))
GO
ALTER TABLE [dbo].[fees]  WITH CHECK ADD CHECK  (([updated_by]>=(0)))
GO
ALTER TABLE [dbo].[files]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[files]  WITH CHECK ADD CHECK  (([owner_user_id]>=(0)))
GO
ALTER TABLE [dbo].[files]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[files]  WITH CHECK ADD CHECK  (([size]>=(0)))
GO
ALTER TABLE [dbo].[grade_fees]  WITH CHECK ADD CHECK  (([created_by]>=(0)))
GO
ALTER TABLE [dbo].[grade_fees]  WITH CHECK ADD CHECK  (([fees_id]>=(0)))
GO
ALTER TABLE [dbo].[grade_fees]  WITH CHECK ADD CHECK  (([grade_id]>=(0)))
GO
ALTER TABLE [dbo].[grade_fees]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[grade_fees]  WITH CHECK ADD CHECK  (([updated_by]>=(0)))
GO
ALTER TABLE [dbo].[grade_fees]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[grades]  WITH CHECK ADD CHECK  (([block]='highersecondary' OR [block]='higher' OR [block]='middle' OR [block]='primary' OR [block]='kindergarten'))
GO
ALTER TABLE [dbo].[grades]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[grades]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[parents]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[parents]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[route_stops]  WITH CHECK ADD CHECK  (([created_by]>=(0)))
GO
ALTER TABLE [dbo].[route_stops]  WITH CHECK ADD CHECK  (([route_id]>=(0)))
GO
ALTER TABLE [dbo].[route_stops]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[route_stops]  WITH CHECK ADD CHECK  (([updated_by]>=(0)))
GO
ALTER TABLE [dbo].[route_stops]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[route_vehicle_stops]  WITH CHECK ADD CHECK  (([route_vehicle_id]>=(0)))
GO
ALTER TABLE [dbo].[route_vehicle_stops]  WITH CHECK ADD CHECK  (([route_stop_id]>=(0)))
GO
ALTER TABLE [dbo].[route_vehicle_stops]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[route_vehicle_stops]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[route_vehicle_stops_fee_logs]  WITH CHECK ADD CHECK  (([fees_id]>=(0)))
GO
ALTER TABLE [dbo].[route_vehicle_stops_fee_logs]  WITH CHECK ADD CHECK  (([route_vehicle_stop_id]>=(0)))
GO
ALTER TABLE [dbo].[route_vehicle_stops_fee_logs]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[route_vehicles]  WITH CHECK ADD CHECK  (([route_id]>=(0)))
GO
ALTER TABLE [dbo].[route_vehicles]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[route_vehicles]  WITH CHECK ADD CHECK  (([vehicle_id]>=(0)))
GO
ALTER TABLE [dbo].[route_vehicles]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[routes]  WITH CHECK ADD CHECK  (([created_by]>=(0)))
GO
ALTER TABLE [dbo].[routes]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[routes]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[routes]  WITH CHECK ADD CHECK  (([updated_by]>=(0)))
GO
ALTER TABLE [dbo].[schools]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[sections]  WITH CHECK ADD CHECK  (([capacity]>(0)))
GO
ALTER TABLE [dbo].[sections]  WITH CHECK ADD CHECK  (([created_by]>(0)))
GO
ALTER TABLE [dbo].[sections]  WITH CHECK ADD CHECK  (([school_id]>(0)))
GO
ALTER TABLE [dbo].[sessions]  WITH CHECK ADD CHECK  (([created_by]>(0)))
GO
ALTER TABLE [dbo].[sessions]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[sessions]  WITH CHECK ADD CHECK  (([order]>=(0)))
GO
ALTER TABLE [dbo].[sessions]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[student_fees]  WITH CHECK ADD CHECK  (([concession_amount]>=(0)))
GO
ALTER TABLE [dbo].[student_fees]  WITH CHECK ADD CHECK  (([grade_fees_id]>=(0)))
GO
ALTER TABLE [dbo].[student_fees]  WITH CHECK ADD CHECK  (([route_vehicle_stops_fee_log_id]>=(0)))
GO
ALTER TABLE [dbo].[student_fees]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[student_fees]  WITH CHECK ADD CHECK  (([student_id]>=(0)))
GO
ALTER TABLE [dbo].[student_fees]  WITH CHECK ADD CHECK  (([fine]>=(0)))
GO
ALTER TABLE [dbo].[student_fees]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[student_grade_session_log]  WITH CHECK ADD CHECK  (([created_by]>=(0)))
GO
ALTER TABLE [dbo].[student_grade_session_log]  WITH CHECK ADD CHECK  (([grade_id]>=(0)))
GO
ALTER TABLE [dbo].[student_grade_session_log]  WITH CHECK ADD CHECK  (([roll_number]>=(0)))
GO
ALTER TABLE [dbo].[student_grade_session_log]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[student_grade_session_log]  WITH CHECK ADD CHECK  (([section_id]>=(0)))
GO
ALTER TABLE [dbo].[student_grade_session_log]  WITH CHECK ADD CHECK  (([session_id]>=(0)))
GO
ALTER TABLE [dbo].[student_grade_session_log]  WITH CHECK ADD CHECK  (([sgsl_status]='new_admission' OR [sgsl_status]='in_active' OR [sgsl_status]='pass_out' OR [sgsl_status]='active'))
GO
ALTER TABLE [dbo].[student_grade_session_log]  WITH CHECK ADD CHECK  (([student_id]>=(0)))
GO
ALTER TABLE [dbo].[student_grade_session_log]  WITH CHECK ADD CHECK  (([updated_by]>=(0)))
GO
ALTER TABLE [dbo].[student_payments]  WITH CHECK ADD CHECK  (([created_by]>=(0)))
GO
ALTER TABLE [dbo].[student_payments]  WITH CHECK ADD CHECK  (([payment_mode]='online' OR [payment_mode]='challan' OR [payment_mode]='cheque' OR [payment_mode]='cash'))
GO
ALTER TABLE [dbo].[student_payments]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[student_payments]  WITH CHECK ADD CHECK  (([student_fees_id]>=(0)))
GO
ALTER TABLE [dbo].[student_payments]  WITH CHECK ADD CHECK  (([updated_by]>=(0)))
GO
ALTER TABLE [dbo].[student_payments]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD CHECK  (([created_by]>=(0)))
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD CHECK  (([grade_id]>=(0)))
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD CHECK  (([parent_id]>=(0)))
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD CHECK  (([section_id]>=(0)))
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD CHECK  (([session_id]>=(0)))
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD CHECK  (([status]='new_admission' OR [status]='in_active' OR [status]='pass_out' OR [status]='active'))
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD CHECK  (([trip_stop_id]>=(0)))
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD CHECK  (([updated_by]>=(0)))
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD CHECK  (([user_id]>=(0)))
GO
ALTER TABLE [dbo].[trip_stops]  WITH CHECK ADD CHECK  (([route_vehicle_stop_id]>=(0)))
GO
ALTER TABLE [dbo].[trip_stops]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[trip_stops]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[trip_stops]  WITH CHECK ADD CHECK  (([trip]='3' OR [trip]='2' OR [trip]='1'))
GO
ALTER TABLE [dbo].[user_avatar_files]  WITH CHECK ADD CHECK  (([applicant_id]>=(0)))
GO
ALTER TABLE [dbo].[user_avatar_files]  WITH CHECK ADD CHECK  (([file_id]>=(0)))
GO
ALTER TABLE [dbo].[user_avatar_files]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[user_avatar_files]  WITH CHECK ADD CHECK  (([user_id]>=(0)))
GO
ALTER TABLE [dbo].[user_avatar_files]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([blood_group]='AB-' OR [blood_group]='AB+' OR [blood_group]='B-' OR [blood_group]='B+' OR [blood_group]='A-' OR [blood_group]='A+' OR [blood_group]='O-' OR [blood_group]='O+' OR [blood_group]=''))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([gender]='female' OR [gender]='male'))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([role_id]>=(0)))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [CK__users__status__4AD81681] CHECK  (([status]='' OR [status]='deleted' OR [status]='inactive' OR [status]='active'))
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [CK__users__status__4AD81681]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([user_type]='patent' OR [user_type]='student' OR [user_type]='staff'))
GO
ALTER TABLE [dbo].[vehicles]  WITH CHECK ADD CHECK  (([created_by]>=(0)))
GO
ALTER TABLE [dbo].[vehicles]  WITH CHECK ADD CHECK  (([id]>=(0)))
GO
ALTER TABLE [dbo].[vehicles]  WITH CHECK ADD CHECK  (([school_id]>=(0)))
GO
ALTER TABLE [dbo].[vehicles]  WITH CHECK ADD CHECK  (([staff_id]>=(0)))
GO
ALTER TABLE [dbo].[vehicles]  WITH CHECK ADD CHECK  (([tracker_id]>=(0)))
GO
ALTER TABLE [dbo].[vehicles]  WITH CHECK ADD CHECK  (([updated_by]>=(0)))
GO
USE [master]
GO
ALTER DATABASE [SchoolUniverse] SET  READ_WRITE 
GO
