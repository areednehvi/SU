USE [master]
GO
/****** Object:  Database [SchoolUniverse]    Script Date: 11/8/2017 5:06:08 PM ******/
CREATE DATABASE [SchoolUniverse]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SchoolUniverse', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\SchoolUniverse.mdf' , SIZE = 9216KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SchoolUniverse_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\SchoolUniverse_log.ldf' , SIZE = 22144KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  UserDefinedTableType [dbo].[fee_categories]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[FeeDueModel]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[fees]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[files]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[grade_fees]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[grades]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[parents]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[PaymentModel]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[route_stops]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[route_vehicle_stops]    Script Date: 11/8/2017 5:06:08 PM ******/
CREATE TYPE [dbo].[route_vehicle_stops] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[route_vehicle_id] [bigint] NOT NULL,
	[route_stop_id] [bigint] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[route_vehicle_stops_fee_logs]    Script Date: 11/8/2017 5:06:08 PM ******/
CREATE TYPE [dbo].[route_vehicle_stops_fee_logs] AS TABLE(
	[id] [bigint] NOT NULL,
	[route_vehicle_stop_id] [bigint] NOT NULL,
	[fees_id] [bigint] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[route_vehicles]    Script Date: 11/8/2017 5:06:08 PM ******/
CREATE TYPE [dbo].[route_vehicles] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[vehicle_id] [bigint] NOT NULL,
	[route_id] [bigint] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[routes]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[schools]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[sections]    Script Date: 11/8/2017 5:06:08 PM ******/
CREATE TYPE [dbo].[sections] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [int] NOT NULL,
	[name] [varchar](10) NOT NULL,
	[capacity] [int] NOT NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime2](0) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[sessions]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[student_fees]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[student_grade_session_log]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[student_payments]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[students]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[trip_stops]    Script Date: 11/8/2017 5:06:08 PM ******/
CREATE TYPE [dbo].[trip_stops] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[route_vehicle_stop_id] [int] NOT NULL,
	[trip] [varchar](50) NOT NULL,
	[pick] [time](7) NOT NULL,
	[drop] [time](7) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[user_avatar_files]    Script Date: 11/8/2017 5:06:08 PM ******/
CREATE TYPE [dbo].[user_avatar_files] AS TABLE(
	[id] [bigint] NOT NULL,
	[school_id] [bigint] NOT NULL,
	[user_id] [bigint] NULL,
	[applicant_id] [bigint] NULL,
	[file_id] [bigint] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[users]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[vehicles]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[AuthenticateUser]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteRecord]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetList]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetSchoolInfo]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetSettings]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetStudentBalances]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetStudentFeeAllocatedList]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetStudentFeeDue]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetStudentPaymentHistory]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetSyncTableInfo]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[IsSchoolSetup]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MakePayment]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SaveSettings]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SetSchoolInfo]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncFee_categories]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncFees]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncFiles]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncGrade_fees]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncGrades]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncParents]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncRoute_stops]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncRoute_vehicle_stops]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncRoute_vehicle_stops_fee_logs]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncRoute_vehicles]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncRoutes]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncSections]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncSessions]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncStudent_fees]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncStudent_grade_session_log]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncStudent_payments]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncStudents]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncTrip_stops]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncUser_avatar_files]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncUsers]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncVehicles]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateFeeDue]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdatePayment]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateSyncTableInfo]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[fee_categories]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[fees]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[files]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[grade_fees]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[grades]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[parents]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[route_stops]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[route_vehicle_stops]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[route_vehicle_stops_fee_logs]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[route_vehicles]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[routes]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[schools]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[sections]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[sessions]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[Settings]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[student_fees]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[student_grade_session_log]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[student_payments]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[students]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[SyncTableInfo]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[trip_stops]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[user_avatar_files]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 11/8/2017 5:06:08 PM ******/
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
/****** Object:  Table [dbo].[vehicles]    Script Date: 11/8/2017 5:06:08 PM ******/
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
INSERT [dbo].[fee_categories] ([id], [school_id], [name], [recur], [is_transport], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1, 18, N'Tution Fee', N'1', 1, 0, 1, CAST(0x0000A6230121A40C AS DateTime), 1, CAST(0x0000A80300A56504 AS DateTime))
INSERT [dbo].[fee_categories] ([id], [school_id], [name], [recur], [is_transport], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (2, 18, N'Computer Fee', N'1', 2, 0, 1, CAST(0x0000A80300A540B0 AS DateTime), 1, CAST(0x0000A80300A540B0 AS DateTime))
INSERT [dbo].[fee_categories] ([id], [school_id], [name], [recur], [is_transport], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (3, 18, N'Transport Fee', N'1', 3, 1, 1, CAST(0x0000A80300A555C8 AS DateTime), 1, CAST(0x0000A80300A571E8 AS DateTime))
INSERT [dbo].[fee_categories] ([id], [school_id], [name], [recur], [is_transport], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (4, 18, N'Printing Charges', N'6', 4, 0, 1, CAST(0x0000A80400D17900 AS DateTime), 1, CAST(0x0000A80400D17900 AS DateTime))
INSERT [dbo].[fees] ([id], [school_id], [fee_category_id], [session_id], [amount], [fee_cources], [last_date], [last_day], [fine_per_day], [is_allocated], [remarks], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1, 18, 1, 1, 5000, N'2015-11-01:2015-11-30,2015-12-01:2015-12-31,2016-01-01:2016-01-31,2016-02-01:2016-02-29,2016-03-01:2016-03-31,2016-04-01:2016-04-30,2016-05-01:2016-05-31,2016-06-01:2016-06-30,2016-07-01:2016-07-31,2016-08-01:2016-08-31,2016-09-01:2016-09-30,2016-10-01:2016-10-31', NULL, 30, 10, 1, N'yes', 1, CAST(0x009D31013B3D0B0000 AS DateTime2), 1, CAST(0x009A8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[fees] ([id], [school_id], [fee_category_id], [session_id], [amount], [fee_cources], [last_date], [last_day], [fine_per_day], [is_allocated], [remarks], [created_by], [created_on], [updated_by], [updated_on]) VALUES (2, 18, 1, 1, 200, N'2015-11-01:2015-11-30,2015-12-01:2015-12-31,2016-01-01:2016-01-31,2016-02-01:2016-02-29,2016-03-01:2016-03-31,2016-04-01:2016-04-30,2016-05-01:2016-05-31,2016-06-01:2016-06-30,2016-07-01:2016-07-31,2016-08-01:2016-08-31,2016-09-01:2016-09-30,2016-10-01:2016-10-31', NULL, 30, 10, 1, N'1', 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00AC8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[fees] ([id], [school_id], [fee_category_id], [session_id], [amount], [fee_cources], [last_date], [last_day], [fine_per_day], [is_allocated], [remarks], [created_by], [created_on], [updated_by], [updated_on]) VALUES (3, 18, 2, 1, 50, N'2015-11-01:2015-11-30,2015-12-01:2015-12-31,2016-01-01:2016-01-31,2016-02-01:2016-02-29,2016-03-01:2016-03-31,2016-04-01:2016-04-30,2016-05-01:2016-05-31,2016-06-01:2016-06-30,2016-07-01:2016-07-31,2016-08-01:2016-08-31,2016-09-01:2016-09-30,2016-10-01:2016-10-31', NULL, NULL, NULL, 1, N'yes', 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[fees] ([id], [school_id], [fee_category_id], [session_id], [amount], [fee_cources], [last_date], [last_day], [fine_per_day], [is_allocated], [remarks], [created_by], [created_on], [updated_by], [updated_on]) VALUES (4, 18, 3, 1, 100, N'2015-11-01:2015-11-30,2015-12-01:2015-12-31,2016-01-01:2016-01-31,2016-02-01:2016-02-29,2016-03-01:2016-03-31,2016-04-01:2016-04-30,2016-05-01:2016-05-31,2016-06-01:2016-06-30,2016-07-01:2016-07-31,2016-08-01:2016-08-31,2016-09-01:2016-09-30,2016-10-01:2016-10-31', NULL, NULL, NULL, 1, N'transport', 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1, 18, 1, 1, 1, CAST(0x009D31013B3D0B0000 AS DateTime2), 1, CAST(0x009A8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (2, 18, 2, 1, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00AC8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (3, 18, 2, 2, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (4, 18, 2, 3, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (5, 18, 2, 4, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (6, 18, 2, 5, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (7, 18, 2, 6, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (8, 18, 2, 7, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (9, 18, 2, 8, 1, CAST(0x00A4DF00403D0B0000 AS DateTime2), 1, CAST(0x00A4DF00403D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (10, 18, 2, 9, 1, CAST(0x00A4DF00403D0B0000 AS DateTime2), 1, CAST(0x00A4DF00403D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (11, 18, 2, 10, 1, CAST(0x00A4DF00403D0B0000 AS DateTime2), 1, CAST(0x00A4DF00403D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (12, 18, 3, 1, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (13, 18, 3, 2, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (14, 18, 3, 3, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (15, 18, 3, 4, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (16, 18, 3, 5, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (17, 18, 3, 6, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (18, 18, 3, 7, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (19, 18, 3, 8, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (20, 18, 3, 9, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (21, 18, 3, 10, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (22, 18, 4, 1, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (23, 18, 4, 2, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (24, 18, 4, 3, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (25, 18, 4, 4, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (26, 18, 4, 5, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (27, 18, 4, 6, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (28, 18, 4, 7, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (29, 18, 4, 8, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (30, 18, 4, 9, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[grade_fees] ([id], [school_id], [fees_id], [grade_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (31, 18, 4, 10, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[grades] ([id], [school_id], [block], [name], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1, 18, NULL, N'Nursery', 1, 1, CAST(0x0000A608008E8E88 AS DateTime), 1, CAST(0x0000A608008E8E88 AS DateTime))
INSERT [dbo].[grades] ([id], [school_id], [block], [name], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (2, 18, NULL, N'LKG', 2, 1, CAST(0x0000A608008E9A40 AS DateTime), 1, CAST(0x0000A608008E9A40 AS DateTime))
INSERT [dbo].[grades] ([id], [school_id], [block], [name], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (3, 18, NULL, N'UKG', 3, 1, CAST(0x0000A608008EA4CC AS DateTime), 1, CAST(0x0000A608008EA4CC AS DateTime))
INSERT [dbo].[grades] ([id], [school_id], [block], [name], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (4, 18, NULL, N'1st', 4, 1, CAST(0x0000A608008EB084 AS DateTime), 1, CAST(0x0000A608008EB084 AS DateTime))
INSERT [dbo].[grades] ([id], [school_id], [block], [name], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (5, 18, NULL, N'2nd', 5, 1, CAST(0x0000A608008EC59C AS DateTime), 1, CAST(0x0000A608008EC59C AS DateTime))
INSERT [dbo].[grades] ([id], [school_id], [block], [name], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (6, 18, NULL, N'3rd', 6, 1, CAST(0x0000A608008ED028 AS DateTime), 1, CAST(0x0000A608008ED028 AS DateTime))
INSERT [dbo].[grades] ([id], [school_id], [block], [name], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (7, 18, NULL, N'4th', 7, 1, CAST(0x0000A608008ED988 AS DateTime), 1, CAST(0x0000A608008ED988 AS DateTime))
INSERT [dbo].[grades] ([id], [school_id], [block], [name], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (8, 18, NULL, N'5th', 8, 1, CAST(0x0000A608008EE2E8 AS DateTime), 1, CAST(0x0000A608008EE2E8 AS DateTime))
INSERT [dbo].[grades] ([id], [school_id], [block], [name], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (9, 18, NULL, N'6th', 9, 1, CAST(0x0000A608008EEC48 AS DateTime), 1, CAST(0x0000A608008EEC48 AS DateTime))
INSERT [dbo].[grades] ([id], [school_id], [block], [name], [order], [created_by], [created_on], [updated_by], [updated_on]) VALUES (10, 18, NULL, N'7th', 10, 1, CAST(0x0000A608008EF47C AS DateTime), 1, CAST(0x0000A608008EF47C AS DateTime))
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (1, 18, N'Ghulam', N'Hassan', N'Magray', N'', NULL, NULL, NULL, N'Haseena', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (2, 18, N'Reyaz', N'Ahmad', N'Tantray', N'', NULL, NULL, NULL, N'Saheena', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (3, 18, N'Sajad', N'', N'Parvaiz', N'', NULL, NULL, NULL, N'Posha', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (4, 18, N'Abdul', N'Majeed', N'Teli', N'', NULL, NULL, NULL, N'Shahzada', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (5, 18, N'Mansoor', N'Ahmad', N'Naikoo', N'', NULL, NULL, NULL, N'Hareefa', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (6, 18, N'Gulzar', N'Ahmad', N'Lone', N'', NULL, NULL, NULL, N'Dilshada', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (7, 18, N'Mushtaq', N'Ahmad', N'Dar', N'', NULL, NULL, NULL, N'Zareefa', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (8, 18, N'Manzoor', N'Ahmad', N'Bhat', N'', NULL, NULL, NULL, N'Saleema', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (9, 18, N'Nisar', N'Ahmad', N'Yatoo', N'', NULL, NULL, NULL, N'Naseema', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (10, 18, N'Zahoor', N'Ahmad', N'Dar', N'', NULL, NULL, NULL, N'Parveena', N'', N'Bano', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (11, 18, N'Altaf', N'Hussain', N'Dar', N'', NULL, NULL, NULL, N'Sabrina', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (12, 18, N'Nazir', N'Ahmad', N'War', N'', NULL, NULL, NULL, N'Rubeena', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (13, 18, N'Showkat', N'Ahmad', N'Dar', N'', NULL, NULL, NULL, N'Ayena', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (14, 18, N'Ishfaq', N'Ahmad', N'Dar', N'', NULL, NULL, NULL, N'Nahida', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (15, 18, N'Rayaz', N'Ahmad', N'Tantray', N'', NULL, NULL, NULL, N'Shaheena', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (16, 18, N'Suhail', N'Ahmad', N'Dar', N'', NULL, NULL, NULL, N'Shamshada', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (17, 18, N'Marouf', N'Ahmad', N'Dar', N'', NULL, NULL, NULL, N'Mubeena', N'', N'Mubeena', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (18, 18, N'Parvez', N'Ahmad', N'Bhat', N'', NULL, NULL, NULL, N'Firdousa', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (19, 18, N'Mohammad', N'Ashraf', N'Wani', N'', NULL, NULL, NULL, N'Shakeela', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (20, 18, N'Manzoor', N'Ahmad', N'Dar', N'', NULL, NULL, NULL, N'Posha', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (21, 18, N'Mohmad', N'Yousuf', N'Lone', N'', NULL, NULL, NULL, N'Mehmooda', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (22, 18, N'Tariq', N'Ahmad', N'Kanna', N'', NULL, NULL, NULL, N'Jahan', N'', N'Ara', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (23, 18, N'Farooq', N'Ahmad', N'Shah', N'', NULL, NULL, NULL, N'Mubeena', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (24, 18, N'Abdul', N'Ahad', N'Lone', N'', NULL, NULL, NULL, N'Zoonah', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (25, 18, N'Abdul', N'Ahad', N'Dar', N'', NULL, NULL, NULL, N'Arsha', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (26, 18, N'Abdul', N'Ahad', N'Dar', N'', NULL, NULL, NULL, N'Arsha', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (27, 18, N'Ghulam', N'Ahmad', N'Gojri', N'', NULL, NULL, NULL, N'Rafiqa', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (28, 18, N'Mushtaq', N'Ahmad', N'Dar', N'', NULL, NULL, NULL, N'Shakeela', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (29, 18, N'Abdul', N'Gani', N'Yatoo', N'', NULL, NULL, NULL, N'Rafiqa', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (30, 18, N'Irshad', N'Ahmad', N'Lone', N'', NULL, NULL, NULL, N'Barjis', N'', N'Barjis', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (31, 18, N'Irshad', N'Ahmad', N'Dar', N'', NULL, NULL, NULL, N'Gulshana', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (32, 18, N'Mohammad', N'Dilawar', N'Dar', N'', NULL, NULL, NULL, N'Syeda', N'', N'Baighum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (33, 18, N'Abdul', N'Rashid', N'Bhat', N'', NULL, NULL, NULL, N'Naseema', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (34, 18, N'Mohammad', N'Ramzan', N'Dar', N'', NULL, NULL, NULL, N'Shareefa', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (35, 18, N'Sajad', N'Parvaiz', N'Sheikh', N'', NULL, NULL, NULL, N'Posha', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (36, 18, N'Fayaz', N'Ahmad', N'Hajam', N'', NULL, NULL, NULL, N'Mehfooza', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (37, 18, N'Mohmad', N'Maqbool', N'Bhat', N'', NULL, NULL, NULL, N'Hajra', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (38, 18, N'Mohammad', N'Ashraf', N'Kachroo', N'', NULL, NULL, NULL, N'Ameena', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (39, 18, N'Farooq', N'Ahmad', N'Shah', N'', NULL, NULL, NULL, N'Aisha', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (40, 18, N'Tariq', N'Ahmad', N'Dar', N'', NULL, NULL, NULL, N'Saleema', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (41, 18, N'Ghulam', N'Nabi', N'War', N'', NULL, NULL, NULL, N'Bakhti', N'', N'Begum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[parents] ([id], [school_id], [f_first_name], [f_middle_name], [f_last_name], [f_mobile], [f_phone], [f_office], [f_email], [m_first_name], [m_middle_name], [m_last_name], [m_mobile], [m_phone], [m_office], [m_email], [g_fullname], [g_mobile], [g_email]) VALUES (42, 18, N'Riyaz', N'Ahmad', N'Yatoo', N'', NULL, NULL, NULL, N'Haseena', N'', N'Baighum', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[schools] ([id], [database_id], [subdomain], [domain], [name], [address], [theme], [created_on]) VALUES (18, 0, N'subdomain', N'domain', N'name', N'address', N'theme', CAST(0x000000004C320B0000 AS DateTime2))
INSERT [dbo].[sections] ([id], [school_id], [name], [capacity], [created_by], [created_on]) VALUES (1, 18, N'A', 30, 1, CAST(0x000F7A00633B0B0000 AS DateTime2))
INSERT [dbo].[sections] ([id], [school_id], [name], [capacity], [created_by], [created_on]) VALUES (2, 18, N'B', 30, 1, CAST(0x00187A00633B0B0000 AS DateTime2))
INSERT [dbo].[sections] ([id], [school_id], [name], [capacity], [created_by], [created_on]) VALUES (3, 18, N'C', 30, 1, CAST(0x00217A00633B0B0000 AS DateTime2))
INSERT [dbo].[sections] ([id], [school_id], [name], [capacity], [created_by], [created_on]) VALUES (4, 18, N'D', 30, 1, CAST(0x002A7A00633B0B0000 AS DateTime2))
INSERT [dbo].[sessions] ([id], [school_id], [name], [order], [from_date], [to_date], [created_by], [created_on]) VALUES (1, 18, N'2015-2016', 1, CAST(0x000000009E3A0B0000 AS DateTime2), CAST(0x000000000B3C0B0000 AS DateTime2), 1, CAST(0x00527A00633B0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1, 18, 1, 6, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, 0, 0, 1, CAST(0x00E931013B3D0B0000 AS DateTime2), 1, CAST(0x00E931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (2, 18, 1, 6, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, 0, 0, 1, CAST(0x00E931013B3D0B0000 AS DateTime2), 1, CAST(0x00E931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (3, 18, 1, 6, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, 0, 0, 1, CAST(0x00E931013B3D0B0000 AS DateTime2), 1, CAST(0x00E931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (4, 18, 1, 6, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, 0, 0, 1, CAST(0x00E931013B3D0B0000 AS DateTime2), 1, CAST(0x00E931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (5, 18, 1, 6, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, 0, 0, 1, CAST(0x00E931013B3D0B0000 AS DateTime2), 1, CAST(0x00E931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (6, 18, 1, 6, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, 0, 0, 1, CAST(0x00E931013B3D0B0000 AS DateTime2), 1, CAST(0x00E931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (7, 18, 1, 6, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, 0, 0, 1, CAST(0x00E931013B3D0B0000 AS DateTime2), 1, CAST(0x00E931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (8, 18, 1, 6, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, 0, 0, 1, CAST(0x00E931013B3D0B0000 AS DateTime2), 1, CAST(0x00E931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (9, 18, 1, 6, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, 0, 0, 1, CAST(0x00E931013B3D0B0000 AS DateTime2), 1, CAST(0x00E931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (10, 18, 1, 6, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, 0, 0, 1, CAST(0x00E931013B3D0B0000 AS DateTime2), 1, CAST(0x00E931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (11, 18, 1, 6, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, 0, 0, 1, CAST(0x00E931013B3D0B0000 AS DateTime2), 1, CAST(0x00E931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (12, 18, 1, 6, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, 0, 0, 1, CAST(0x00E931013B3D0B0000 AS DateTime2), 1, CAST(0x00E931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (13, 18, 1, 5, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00F931013B3D0B0000 AS DateTime2), 1, CAST(0x00F931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (14, 18, 1, 5, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00F931013B3D0B0000 AS DateTime2), 1, CAST(0x00F931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (15, 18, 1, 5, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00F931013B3D0B0000 AS DateTime2), 1, CAST(0x00F931013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (16, 18, 1, 5, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00FA31013B3D0B0000 AS DateTime2), 1, CAST(0x00FA31013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (17, 18, 1, 5, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00FA31013B3D0B0000 AS DateTime2), 1, CAST(0x00FA31013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (18, 18, 1, 5, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00FA31013B3D0B0000 AS DateTime2), 1, CAST(0x00FA31013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (19, 18, 1, 5, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00FA31013B3D0B0000 AS DateTime2), 1, CAST(0x00FA31013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (20, 18, 1, 5, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00FA31013B3D0B0000 AS DateTime2), 1, CAST(0x00FA31013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (21, 18, 1, 5, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00FA31013B3D0B0000 AS DateTime2), 1, CAST(0x00FA31013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (22, 18, 1, 5, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00FA31013B3D0B0000 AS DateTime2), 1, CAST(0x00FA31013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (23, 18, 1, 5, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00FA31013B3D0B0000 AS DateTime2), 1, CAST(0x00FA31013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (24, 18, 1, 5, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00FA31013B3D0B0000 AS DateTime2), 1, CAST(0x00FA31013B3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (25, 18, 2, 1, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), 10, 5, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (26, 18, 2, 1, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), 10, 5, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (27, 18, 2, 1, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), 10, 5, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (28, 18, 2, 1, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), 10, 5, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (29, 18, 2, 1, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), 10, 5, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (30, 18, 2, 1, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), 10, 5, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (31, 18, 2, 1, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), 10, 5, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (32, 18, 2, 1, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), 10, 5, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (33, 18, 2, 1, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), 10, 5, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (34, 18, 2, 1, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), 10, 5, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (35, 18, 2, 1, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), 10, 5, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (36, 18, 2, 1, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), 10, 5, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (37, 18, 2, 2, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (38, 18, 2, 2, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (39, 18, 2, 2, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (40, 18, 2, 2, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (41, 18, 2, 2, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (42, 18, 2, 2, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (43, 18, 2, 2, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (44, 18, 2, 2, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (45, 18, 2, 2, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (46, 18, 2, 2, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (47, 18, 2, 2, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (48, 18, 2, 2, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (49, 18, 2, 3, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (50, 18, 2, 3, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (51, 18, 2, 3, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (52, 18, 2, 3, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (53, 18, 2, 3, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (54, 18, 2, 3, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (55, 18, 2, 3, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (56, 18, 2, 3, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (57, 18, 2, 3, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (58, 18, 2, 3, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (59, 18, 2, 3, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (60, 18, 2, 3, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (61, 18, 2, 4, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (62, 18, 2, 4, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (63, 18, 2, 4, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (64, 18, 2, 4, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (65, 18, 2, 4, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (66, 18, 2, 4, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (67, 18, 2, 4, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (68, 18, 2, 4, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (69, 18, 2, 4, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (70, 18, 2, 4, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (71, 18, 2, 4, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (72, 18, 2, 4, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (73, 18, 2, 5, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (74, 18, 2, 5, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (75, 18, 2, 5, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (76, 18, 2, 5, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (77, 18, 2, 5, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (78, 18, 2, 5, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (79, 18, 2, 5, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (80, 18, 2, 5, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (81, 18, 2, 5, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (82, 18, 2, 5, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (83, 18, 2, 5, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (84, 18, 2, 5, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (85, 18, 2, 6, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (86, 18, 2, 6, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (87, 18, 2, 6, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (88, 18, 2, 6, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (89, 18, 2, 6, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (90, 18, 2, 6, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (91, 18, 2, 6, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (92, 18, 2, 6, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (93, 18, 2, 6, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (94, 18, 2, 6, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (95, 18, 2, 6, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (96, 18, 2, 6, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (97, 18, 3, 7, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (98, 18, 3, 7, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (99, 18, 3, 7, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (100, 18, 3, 7, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (101, 18, 3, 7, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (102, 18, 3, 7, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (103, 18, 3, 7, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (104, 18, 3, 7, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (105, 18, 3, 7, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (106, 18, 3, 7, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (107, 18, 3, 7, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (108, 18, 3, 7, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (109, 18, 3, 8, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (110, 18, 3, 8, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (111, 18, 3, 8, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (112, 18, 3, 8, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (113, 18, 3, 8, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (114, 18, 3, 8, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (115, 18, 3, 8, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (116, 18, 3, 8, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (117, 18, 3, 8, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (118, 18, 3, 8, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (119, 18, 3, 8, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (120, 18, 3, 8, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (121, 18, 3, 9, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (122, 18, 3, 9, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (123, 18, 3, 9, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (124, 18, 3, 9, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (125, 18, 3, 9, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (126, 18, 3, 9, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (127, 18, 3, 9, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (128, 18, 3, 9, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (129, 18, 3, 9, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (130, 18, 3, 9, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (131, 18, 3, 9, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (132, 18, 3, 9, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (133, 18, 3, 10, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (134, 18, 3, 10, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (135, 18, 3, 10, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (136, 18, 3, 10, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (137, 18, 3, 10, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (138, 18, 3, 10, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (139, 18, 3, 10, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (140, 18, 3, 10, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (141, 18, 3, 10, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (142, 18, 3, 10, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (143, 18, 3, 10, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (144, 18, 3, 10, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (145, 18, 3, 11, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (146, 18, 3, 11, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (147, 18, 3, 11, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (148, 18, 3, 11, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (149, 18, 3, 11, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (150, 18, 3, 11, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (151, 18, 3, 11, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (152, 18, 3, 11, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (153, 18, 3, 11, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (154, 18, 3, 11, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (155, 18, 3, 11, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (156, 18, 3, 11, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (157, 18, 3, 12, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (158, 18, 3, 12, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (159, 18, 3, 12, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (160, 18, 3, 12, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (161, 18, 3, 12, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (162, 18, 3, 12, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (163, 18, 3, 12, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (164, 18, 3, 12, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (165, 18, 3, 12, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (166, 18, 3, 12, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (167, 18, 3, 12, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (168, 18, 3, 12, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (169, 18, 3, 13, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (170, 18, 3, 13, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (171, 18, 3, 13, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (172, 18, 3, 13, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (173, 18, 3, 13, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (174, 18, 3, 13, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (175, 18, 3, 13, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (176, 18, 3, 13, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (177, 18, 3, 13, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (178, 18, 3, 13, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (179, 18, 3, 13, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (180, 18, 3, 13, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (181, 18, 3, 14, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, 50, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (182, 18, 3, 14, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (183, 18, 3, 14, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (184, 18, 3, 14, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (185, 18, 3, 14, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (186, 18, 3, 14, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (187, 18, 3, 14, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (188, 18, 3, 14, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (189, 18, 3, 14, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (190, 18, 3, 14, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (191, 18, 3, 14, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (192, 18, 3, 14, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (193, 18, 3, 15, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (194, 18, 3, 15, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (195, 18, 3, 15, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (196, 18, 3, 15, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (197, 18, 3, 15, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (198, 18, 3, 15, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (199, 18, 3, 15, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (200, 18, 3, 15, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (201, 18, 3, 15, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (202, 18, 3, 15, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (203, 18, 3, 15, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (204, 18, 3, 15, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (205, 18, 4, 16, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (206, 18, 4, 16, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (207, 18, 4, 16, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (208, 18, 4, 16, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (209, 18, 4, 16, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (210, 18, 4, 16, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (211, 18, 4, 16, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (212, 18, 4, 16, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (213, 18, 4, 16, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (214, 18, 4, 16, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (215, 18, 4, 16, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (216, 18, 4, 16, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (217, 18, 4, 17, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (218, 18, 4, 17, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (219, 18, 4, 17, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (220, 18, 4, 17, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (221, 18, 4, 17, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (222, 18, 4, 17, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (223, 18, 4, 17, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (224, 18, 4, 17, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (225, 18, 4, 17, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (226, 18, 4, 17, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (227, 18, 4, 17, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (228, 18, 4, 17, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (229, 18, 4, 18, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (230, 18, 4, 18, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (231, 18, 4, 18, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (232, 18, 4, 18, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (233, 18, 4, 18, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (234, 18, 4, 18, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (235, 18, 4, 18, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (236, 18, 4, 18, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (237, 18, 4, 18, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (238, 18, 4, 18, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (239, 18, 4, 18, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (240, 18, 4, 18, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (241, 18, 4, 19, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (242, 18, 4, 19, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (243, 18, 4, 19, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (244, 18, 4, 19, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (245, 18, 4, 19, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (246, 18, 4, 19, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (247, 18, 4, 19, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (248, 18, 4, 19, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (249, 18, 4, 19, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (250, 18, 4, 19, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (251, 18, 4, 19, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (252, 18, 4, 19, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (253, 18, 4, 20, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (254, 18, 4, 20, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (255, 18, 4, 20, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (256, 18, 4, 20, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (257, 18, 4, 20, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (258, 18, 4, 20, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (259, 18, 4, 20, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (260, 18, 4, 20, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (261, 18, 4, 20, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (262, 18, 4, 20, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (263, 18, 4, 20, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (264, 18, 4, 20, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (265, 18, 4, 21, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (266, 18, 4, 21, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (267, 18, 4, 21, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (268, 18, 4, 21, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (269, 18, 4, 21, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (270, 18, 4, 21, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (271, 18, 4, 21, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (272, 18, 4, 21, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (273, 18, 4, 21, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (274, 18, 4, 21, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (275, 18, 4, 21, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (276, 18, 4, 21, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (277, 18, 4, 22, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (278, 18, 4, 22, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (279, 18, 4, 22, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (280, 18, 4, 22, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (281, 18, 4, 22, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (282, 18, 4, 22, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (283, 18, 4, 22, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (284, 18, 4, 22, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (285, 18, 4, 22, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (286, 18, 4, 22, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (287, 18, 4, 22, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (288, 18, 4, 22, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (289, 18, 4, 23, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (290, 18, 4, 23, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (291, 18, 4, 23, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (292, 18, 4, 23, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (293, 18, 4, 23, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (294, 18, 4, 23, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (295, 18, 4, 23, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (296, 18, 4, 23, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (297, 18, 4, 23, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (298, 18, 4, 23, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (299, 18, 4, 23, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (300, 18, 4, 23, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (301, 18, 5, 24, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (302, 18, 5, 24, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (303, 18, 5, 24, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (304, 18, 5, 24, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (305, 18, 5, 24, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (306, 18, 5, 24, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (307, 18, 5, 24, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (308, 18, 5, 24, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (309, 18, 5, 24, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (310, 18, 5, 24, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (311, 18, 5, 24, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (312, 18, 5, 24, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (313, 18, 5, 25, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (314, 18, 5, 25, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (315, 18, 5, 25, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (316, 18, 5, 25, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (317, 18, 5, 25, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (318, 18, 5, 25, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (319, 18, 5, 25, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (320, 18, 5, 25, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (321, 18, 5, 25, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (322, 18, 5, 25, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (323, 18, 5, 25, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (324, 18, 5, 25, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (325, 18, 5, 26, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (326, 18, 5, 26, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (327, 18, 5, 26, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (328, 18, 5, 26, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (329, 18, 5, 26, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (330, 18, 5, 26, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (331, 18, 5, 26, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (332, 18, 5, 26, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (333, 18, 5, 26, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (334, 18, 5, 26, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (335, 18, 5, 26, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (336, 18, 5, 26, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (337, 18, 5, 27, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (338, 18, 5, 27, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (339, 18, 5, 27, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (340, 18, 5, 27, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (341, 18, 5, 27, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (342, 18, 5, 27, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (343, 18, 5, 27, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (344, 18, 5, 27, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (345, 18, 5, 27, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (346, 18, 5, 27, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (347, 18, 5, 27, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (348, 18, 5, 27, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (349, 18, 5, 28, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (350, 18, 5, 28, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (351, 18, 5, 28, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (352, 18, 5, 28, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (353, 18, 5, 28, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (354, 18, 5, 28, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (355, 18, 5, 28, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (356, 18, 5, 28, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (357, 18, 5, 28, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (358, 18, 5, 28, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (359, 18, 5, 28, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (360, 18, 5, 28, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (361, 18, 5, 29, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (362, 18, 5, 29, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (363, 18, 5, 29, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (364, 18, 5, 29, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (365, 18, 5, 29, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (366, 18, 5, 29, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (367, 18, 5, 29, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (368, 18, 5, 29, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (369, 18, 5, 29, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (370, 18, 5, 29, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (371, 18, 5, 29, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (372, 18, 5, 29, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (373, 18, 5, 30, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (374, 18, 5, 30, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (375, 18, 5, 30, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (376, 18, 5, 30, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (377, 18, 5, 30, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (378, 18, 5, 30, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (379, 18, 5, 30, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (380, 18, 5, 30, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (381, 18, 5, 30, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (382, 18, 5, 30, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (383, 18, 5, 30, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (384, 18, 5, 30, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (385, 18, 5, 31, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (386, 18, 5, 31, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (387, 18, 5, 31, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (388, 18, 5, 31, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (389, 18, 5, 31, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (390, 18, 5, 31, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (391, 18, 5, 31, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (392, 18, 5, 31, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (393, 18, 5, 31, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (394, 18, 5, 31, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (395, 18, 5, 31, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (396, 18, 5, 31, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (397, 18, 5, 32, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (398, 18, 5, 32, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (399, 18, 5, 32, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (400, 18, 5, 32, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (401, 18, 5, 32, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (402, 18, 5, 32, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (403, 18, 5, 32, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (404, 18, 5, 32, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (405, 18, 5, 32, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (406, 18, 5, 32, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (407, 18, 5, 32, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (408, 18, 5, 32, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (409, 18, 5, 33, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (410, 18, 5, 33, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (411, 18, 5, 33, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (412, 18, 5, 33, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (413, 18, 5, 33, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (414, 18, 5, 33, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (415, 18, 5, 33, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (416, 18, 5, 33, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (417, 18, 5, 33, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (418, 18, 5, 33, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (419, 18, 5, 33, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (420, 18, 5, 33, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (421, 18, 5, 34, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (422, 18, 5, 34, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (423, 18, 5, 34, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (424, 18, 5, 34, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (425, 18, 5, 34, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (426, 18, 5, 34, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (427, 18, 5, 34, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (428, 18, 5, 34, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (429, 18, 5, 34, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (430, 18, 5, 34, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (431, 18, 5, 34, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (432, 18, 5, 34, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (433, 18, 6, 35, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (434, 18, 6, 35, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (435, 18, 6, 35, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (436, 18, 6, 35, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (437, 18, 6, 35, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (438, 18, 6, 35, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (439, 18, 6, 35, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (440, 18, 6, 35, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (441, 18, 6, 35, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (442, 18, 6, 35, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (443, 18, 6, 35, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (444, 18, 6, 35, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (445, 18, 6, 36, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (446, 18, 6, 36, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (447, 18, 6, 36, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (448, 18, 6, 36, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (449, 18, 6, 36, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (450, 18, 6, 36, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (451, 18, 6, 36, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (452, 18, 6, 36, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (453, 18, 6, 36, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (454, 18, 6, 36, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (455, 18, 6, 36, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (456, 18, 6, 36, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (457, 18, 6, 37, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (458, 18, 6, 37, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (459, 18, 6, 37, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (460, 18, 6, 37, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (461, 18, 6, 37, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (462, 18, 6, 37, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (463, 18, 6, 37, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (464, 18, 6, 37, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (465, 18, 6, 37, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (466, 18, 6, 37, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (467, 18, 6, 37, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (468, 18, 6, 37, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (469, 18, 6, 38, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (470, 18, 6, 38, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (471, 18, 6, 38, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (472, 18, 6, 38, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (473, 18, 6, 38, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (474, 18, 6, 38, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (475, 18, 6, 38, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (476, 18, 6, 38, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (477, 18, 6, 38, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (478, 18, 6, 38, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (479, 18, 6, 38, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (480, 18, 6, 38, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (481, 18, 6, 39, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (482, 18, 6, 39, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (483, 18, 6, 39, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (484, 18, 6, 39, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (485, 18, 6, 39, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (486, 18, 6, 39, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (487, 18, 6, 39, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (488, 18, 6, 39, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (489, 18, 6, 39, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (490, 18, 6, 39, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (491, 18, 6, 39, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (492, 18, 6, 39, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (493, 18, 6, 40, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (494, 18, 6, 40, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (495, 18, 6, 40, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (496, 18, 6, 40, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (497, 18, 6, 40, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (498, 18, 6, 40, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (499, 18, 6, 40, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (500, 18, 6, 40, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (501, 18, 6, 40, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (502, 18, 6, 40, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (503, 18, 6, 40, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (504, 18, 6, 40, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (505, 18, 6, 41, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (506, 18, 6, 41, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (507, 18, 6, 41, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (508, 18, 6, 41, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (509, 18, 6, 41, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (510, 18, 6, 41, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (511, 18, 6, 41, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (512, 18, 6, 41, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (513, 18, 6, 41, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (514, 18, 6, 41, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (515, 18, 6, 41, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (516, 18, 6, 41, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (517, 18, 6, 42, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (518, 18, 6, 42, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (519, 18, 6, 42, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (520, 18, 6, 42, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (521, 18, 6, 42, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (522, 18, 6, 42, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (523, 18, 6, 42, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (524, 18, 6, 42, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (525, 18, 6, 42, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (526, 18, 6, 42, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (527, 18, 6, 42, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (528, 18, 6, 42, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00A3DF00403D0B0000 AS DateTime2), 1, CAST(0x00A3DF00403D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (745, 18, 12, 1, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), 10, 5, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (746, 18, 12, 1, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), 10, 5, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (747, 18, 12, 1, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), 10, 5, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (748, 18, 12, 1, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), 10, 5, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (749, 18, 12, 1, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), 10, 5, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (750, 18, 12, 1, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), 10, 5, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (751, 18, 12, 1, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), 10, 5, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (752, 18, 12, 1, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), 10, 5, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (753, 18, 12, 1, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), 10, 5, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (754, 18, 12, 1, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), 10, 5, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (755, 18, 12, 1, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), 10, 5, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (756, 18, 12, 1, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), 10, 5, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (757, 18, 12, 2, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (758, 18, 12, 2, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (759, 18, 12, 2, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (760, 18, 12, 2, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (761, 18, 12, 2, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (762, 18, 12, 2, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (763, 18, 12, 2, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (764, 18, 12, 2, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (765, 18, 12, 2, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (766, 18, 12, 2, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (767, 18, 12, 2, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (768, 18, 12, 2, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (769, 18, 12, 3, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (770, 18, 12, 3, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (771, 18, 12, 3, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (772, 18, 12, 3, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (773, 18, 12, 3, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (774, 18, 12, 3, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (775, 18, 12, 3, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (776, 18, 12, 3, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (777, 18, 12, 3, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (778, 18, 12, 3, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (779, 18, 12, 3, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (780, 18, 12, 3, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (781, 18, 12, 4, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (782, 18, 12, 4, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (783, 18, 12, 4, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (784, 18, 12, 4, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (785, 18, 12, 4, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (786, 18, 12, 4, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (787, 18, 12, 4, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (788, 18, 12, 4, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (789, 18, 12, 4, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (790, 18, 12, 4, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (791, 18, 12, 4, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (792, 18, 12, 4, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (793, 18, 12, 5, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (794, 18, 12, 5, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (795, 18, 12, 5, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (796, 18, 12, 5, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (797, 18, 12, 5, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (798, 18, 12, 5, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (799, 18, 12, 5, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (800, 18, 12, 5, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (801, 18, 12, 5, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (802, 18, 12, 5, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (803, 18, 12, 5, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (804, 18, 12, 5, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (805, 18, 12, 6, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (806, 18, 12, 6, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (807, 18, 12, 6, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (808, 18, 12, 6, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (809, 18, 12, 6, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (810, 18, 12, 6, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (811, 18, 12, 6, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (812, 18, 12, 6, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (813, 18, 12, 6, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (814, 18, 12, 6, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (815, 18, 12, 6, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (816, 18, 12, 6, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (817, 18, 13, 7, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (818, 18, 13, 7, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (819, 18, 13, 7, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (820, 18, 13, 7, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (821, 18, 13, 7, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (822, 18, 13, 7, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (823, 18, 13, 7, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (824, 18, 13, 7, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (825, 18, 13, 7, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (826, 18, 13, 7, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (827, 18, 13, 7, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (828, 18, 13, 7, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (829, 18, 13, 8, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (830, 18, 13, 8, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (831, 18, 13, 8, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (832, 18, 13, 8, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (833, 18, 13, 8, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (834, 18, 13, 8, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (835, 18, 13, 8, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (836, 18, 13, 8, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (837, 18, 13, 8, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (838, 18, 13, 8, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (839, 18, 13, 8, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (840, 18, 13, 8, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (841, 18, 13, 9, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (842, 18, 13, 9, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (843, 18, 13, 9, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (844, 18, 13, 9, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (845, 18, 13, 9, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (846, 18, 13, 9, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (847, 18, 13, 9, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (848, 18, 13, 9, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (849, 18, 13, 9, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (850, 18, 13, 9, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (851, 18, 13, 9, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (852, 18, 13, 9, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (853, 18, 13, 10, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (854, 18, 13, 10, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (855, 18, 13, 10, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (856, 18, 13, 10, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (857, 18, 13, 10, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (858, 18, 13, 10, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (859, 18, 13, 10, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (860, 18, 13, 10, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (861, 18, 13, 10, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (862, 18, 13, 10, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (863, 18, 13, 10, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (864, 18, 13, 10, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (865, 18, 13, 11, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (866, 18, 13, 11, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (867, 18, 13, 11, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (868, 18, 13, 11, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (869, 18, 13, 11, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (870, 18, 13, 11, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (871, 18, 13, 11, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (872, 18, 13, 11, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (873, 18, 13, 11, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (874, 18, 13, 11, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (875, 18, 13, 11, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (876, 18, 13, 11, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (877, 18, 13, 12, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (878, 18, 13, 12, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (879, 18, 13, 12, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (880, 18, 13, 12, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (881, 18, 13, 12, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (882, 18, 13, 12, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (883, 18, 13, 12, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (884, 18, 13, 12, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (885, 18, 13, 12, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (886, 18, 13, 12, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (887, 18, 13, 12, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (888, 18, 13, 12, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (889, 18, 13, 13, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (890, 18, 13, 13, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (891, 18, 13, 13, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (892, 18, 13, 13, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (893, 18, 13, 13, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (894, 18, 13, 13, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (895, 18, 13, 13, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (896, 18, 13, 13, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (897, 18, 13, 13, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (898, 18, 13, 13, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (899, 18, 13, 13, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (900, 18, 13, 13, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (901, 18, 13, 14, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (902, 18, 13, 14, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (903, 18, 13, 14, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (904, 18, 13, 14, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (905, 18, 13, 14, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (906, 18, 13, 14, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (907, 18, 13, 14, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (908, 18, 13, 14, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (909, 18, 13, 14, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (910, 18, 13, 14, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (911, 18, 13, 14, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (912, 18, 13, 14, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (913, 18, 13, 15, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (914, 18, 13, 15, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (915, 18, 13, 15, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (916, 18, 13, 15, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (917, 18, 13, 15, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (918, 18, 13, 15, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (919, 18, 13, 15, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (920, 18, 13, 15, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (921, 18, 13, 15, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (922, 18, 13, 15, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (923, 18, 13, 15, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (924, 18, 13, 15, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (925, 18, 14, 16, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (926, 18, 14, 16, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (927, 18, 14, 16, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (928, 18, 14, 16, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (929, 18, 14, 16, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (930, 18, 14, 16, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (931, 18, 14, 16, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (932, 18, 14, 16, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (933, 18, 14, 16, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (934, 18, 14, 16, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (935, 18, 14, 16, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DD8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (936, 18, 14, 16, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (937, 18, 14, 17, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (938, 18, 14, 17, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (939, 18, 14, 17, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (940, 18, 14, 17, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (941, 18, 14, 17, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (942, 18, 14, 17, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (943, 18, 14, 17, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (944, 18, 14, 17, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (945, 18, 14, 17, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (946, 18, 14, 17, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (947, 18, 14, 17, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (948, 18, 14, 17, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (949, 18, 14, 18, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (950, 18, 14, 18, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (951, 18, 14, 18, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (952, 18, 14, 18, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (953, 18, 14, 18, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (954, 18, 14, 18, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (955, 18, 14, 18, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (956, 18, 14, 18, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (957, 18, 14, 18, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (958, 18, 14, 18, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (959, 18, 14, 18, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (960, 18, 14, 18, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (961, 18, 14, 19, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (962, 18, 14, 19, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (963, 18, 14, 19, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (964, 18, 14, 19, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (965, 18, 14, 19, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (966, 18, 14, 19, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (967, 18, 14, 19, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (968, 18, 14, 19, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (969, 18, 14, 19, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (970, 18, 14, 19, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (971, 18, 14, 19, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (972, 18, 14, 19, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (973, 18, 14, 20, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (974, 18, 14, 20, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (975, 18, 14, 20, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (976, 18, 14, 20, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (977, 18, 14, 20, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (978, 18, 14, 20, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (979, 18, 14, 20, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (980, 18, 14, 20, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (981, 18, 14, 20, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (982, 18, 14, 20, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (983, 18, 14, 20, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (984, 18, 14, 20, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (985, 18, 14, 21, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (986, 18, 14, 21, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (987, 18, 14, 21, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (988, 18, 14, 21, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (989, 18, 14, 21, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (990, 18, 14, 21, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (991, 18, 14, 21, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (992, 18, 14, 21, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (993, 18, 14, 21, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (994, 18, 14, 21, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (995, 18, 14, 21, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (996, 18, 14, 21, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (997, 18, 14, 22, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (998, 18, 14, 22, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (999, 18, 14, 22, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1000, 18, 14, 22, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1001, 18, 14, 22, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1002, 18, 14, 22, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1003, 18, 14, 22, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1004, 18, 14, 22, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1005, 18, 14, 22, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1006, 18, 14, 22, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1007, 18, 14, 22, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1008, 18, 14, 22, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1009, 18, 14, 23, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1010, 18, 14, 23, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1011, 18, 14, 23, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1012, 18, 14, 23, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1013, 18, 14, 23, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1014, 18, 14, 23, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1015, 18, 14, 23, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1016, 18, 14, 23, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1017, 18, 14, 23, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1018, 18, 14, 23, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1019, 18, 14, 23, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1020, 18, 14, 23, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1021, 18, 15, 24, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1022, 18, 15, 24, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1023, 18, 15, 24, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1024, 18, 15, 24, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1025, 18, 15, 24, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1026, 18, 15, 24, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1027, 18, 15, 24, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1028, 18, 15, 24, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1029, 18, 15, 24, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1030, 18, 15, 24, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1031, 18, 15, 24, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1032, 18, 15, 24, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1033, 18, 15, 25, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1034, 18, 15, 25, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1035, 18, 15, 25, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1036, 18, 15, 25, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1037, 18, 15, 25, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1038, 18, 15, 25, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1039, 18, 15, 25, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1040, 18, 15, 25, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1041, 18, 15, 25, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1042, 18, 15, 25, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1043, 18, 15, 25, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1044, 18, 15, 25, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1045, 18, 15, 26, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1046, 18, 15, 26, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1047, 18, 15, 26, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1048, 18, 15, 26, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1049, 18, 15, 26, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1050, 18, 15, 26, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1051, 18, 15, 26, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1052, 18, 15, 26, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1053, 18, 15, 26, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1054, 18, 15, 26, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1055, 18, 15, 26, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1056, 18, 15, 26, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1057, 18, 15, 27, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1058, 18, 15, 27, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1059, 18, 15, 27, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1060, 18, 15, 27, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1061, 18, 15, 27, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1062, 18, 15, 27, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1063, 18, 15, 27, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1064, 18, 15, 27, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1065, 18, 15, 27, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1066, 18, 15, 27, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1067, 18, 15, 27, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1068, 18, 15, 27, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1069, 18, 15, 28, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1070, 18, 15, 28, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1071, 18, 15, 28, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1072, 18, 15, 28, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1073, 18, 15, 28, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1074, 18, 15, 28, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1075, 18, 15, 28, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1076, 18, 15, 28, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1077, 18, 15, 28, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1078, 18, 15, 28, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1079, 18, 15, 28, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1080, 18, 15, 28, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1081, 18, 15, 29, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1082, 18, 15, 29, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1083, 18, 15, 29, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1084, 18, 15, 29, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1085, 18, 15, 29, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1086, 18, 15, 29, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1087, 18, 15, 29, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1088, 18, 15, 29, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1089, 18, 15, 29, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1090, 18, 15, 29, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1091, 18, 15, 29, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1092, 18, 15, 29, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1093, 18, 15, 30, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1094, 18, 15, 30, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1095, 18, 15, 30, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1096, 18, 15, 30, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1097, 18, 15, 30, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1098, 18, 15, 30, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1099, 18, 15, 30, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1100, 18, 15, 30, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1101, 18, 15, 30, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1102, 18, 15, 30, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1103, 18, 15, 30, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1104, 18, 15, 30, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1105, 18, 15, 31, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1106, 18, 15, 31, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1107, 18, 15, 31, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1108, 18, 15, 31, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1109, 18, 15, 31, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1110, 18, 15, 31, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1111, 18, 15, 31, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1112, 18, 15, 31, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1113, 18, 15, 31, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1114, 18, 15, 31, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1115, 18, 15, 31, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1116, 18, 15, 31, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1117, 18, 15, 32, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1118, 18, 15, 32, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1119, 18, 15, 32, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1120, 18, 15, 32, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1121, 18, 15, 32, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1122, 18, 15, 32, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1123, 18, 15, 32, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1124, 18, 15, 32, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1125, 18, 15, 32, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1126, 18, 15, 32, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1127, 18, 15, 32, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1128, 18, 15, 32, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1129, 18, 15, 33, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1130, 18, 15, 33, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1131, 18, 15, 33, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1132, 18, 15, 33, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1133, 18, 15, 33, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1134, 18, 15, 33, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1135, 18, 15, 33, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1136, 18, 15, 33, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1137, 18, 15, 33, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1138, 18, 15, 33, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1139, 18, 15, 33, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1140, 18, 15, 33, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1141, 18, 15, 34, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1142, 18, 15, 34, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1143, 18, 15, 34, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1144, 18, 15, 34, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1145, 18, 15, 34, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1146, 18, 15, 34, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1147, 18, 15, 34, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1148, 18, 15, 34, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1149, 18, 15, 34, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1150, 18, 15, 34, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1151, 18, 15, 34, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1152, 18, 15, 34, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1153, 18, 16, 35, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1154, 18, 16, 35, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1155, 18, 16, 35, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1156, 18, 16, 35, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1157, 18, 16, 35, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1158, 18, 16, 35, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1159, 18, 16, 35, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1160, 18, 16, 35, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1161, 18, 16, 35, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1162, 18, 16, 35, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1163, 18, 16, 35, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1164, 18, 16, 35, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1165, 18, 16, 36, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1166, 18, 16, 36, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1167, 18, 16, 36, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1168, 18, 16, 36, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1169, 18, 16, 36, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1170, 18, 16, 36, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1171, 18, 16, 36, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1172, 18, 16, 36, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1173, 18, 16, 36, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1174, 18, 16, 36, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1175, 18, 16, 36, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1176, 18, 16, 36, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1177, 18, 16, 37, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1178, 18, 16, 37, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1179, 18, 16, 37, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1180, 18, 16, 37, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1181, 18, 16, 37, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1182, 18, 16, 37, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1183, 18, 16, 37, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1184, 18, 16, 37, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1185, 18, 16, 37, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1186, 18, 16, 37, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1187, 18, 16, 37, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1188, 18, 16, 37, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1189, 18, 16, 38, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1190, 18, 16, 38, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1191, 18, 16, 38, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1192, 18, 16, 38, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1193, 18, 16, 38, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1194, 18, 16, 38, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1195, 18, 16, 38, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1196, 18, 16, 38, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1197, 18, 16, 38, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1198, 18, 16, 38, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1199, 18, 16, 38, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1200, 18, 16, 38, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1201, 18, 16, 39, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1202, 18, 16, 39, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1203, 18, 16, 39, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1204, 18, 16, 39, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1205, 18, 16, 39, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1206, 18, 16, 39, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1207, 18, 16, 39, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1208, 18, 16, 39, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1209, 18, 16, 39, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1210, 18, 16, 39, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1211, 18, 16, 39, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1212, 18, 16, 39, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1213, 18, 16, 40, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1214, 18, 16, 40, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1215, 18, 16, 40, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1216, 18, 16, 40, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1217, 18, 16, 40, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1218, 18, 16, 40, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1219, 18, 16, 40, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1220, 18, 16, 40, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1221, 18, 16, 40, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1222, 18, 16, 40, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1223, 18, 16, 40, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1224, 18, 16, 40, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1225, 18, 16, 41, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1226, 18, 16, 41, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1227, 18, 16, 41, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1228, 18, 16, 41, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1229, 18, 16, 41, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1230, 18, 16, 41, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1231, 18, 16, 41, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1232, 18, 16, 41, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1233, 18, 16, 41, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1234, 18, 16, 41, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1235, 18, 16, 41, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1236, 18, 16, 41, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1237, 18, 16, 42, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1238, 18, 16, 42, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1239, 18, 16, 42, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1240, 18, 16, 42, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1241, 18, 16, 42, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1242, 18, 16, 42, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1243, 18, 16, 42, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1244, 18, 16, 42, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1245, 18, 16, 42, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1246, 18, 16, 42, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1247, 18, 16, 42, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1248, 18, 16, 42, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2), 1, CAST(0x00DE8D005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1249, 18, 22, 1, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), 10, 5, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1250, 18, 22, 1, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), 10, 5, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1251, 18, 22, 1, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), 10, 5, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1252, 18, 22, 1, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), 10, 5, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1253, 18, 22, 1, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), 10, 5, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1254, 18, 22, 1, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), 10, 5, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1255, 18, 22, 1, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), 10, 5, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1256, 18, 22, 1, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), 10, 5, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1257, 18, 22, 1, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), 10, 5, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1258, 18, 22, 1, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), 10, 5, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1259, 18, 22, 1, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), 10, 5, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1260, 18, 22, 1, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), 10, 5, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1261, 18, 22, 2, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1262, 18, 22, 2, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1263, 18, 22, 2, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1264, 18, 22, 2, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1265, 18, 22, 2, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1266, 18, 22, 2, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1267, 18, 22, 2, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1268, 18, 22, 2, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1269, 18, 22, 2, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1270, 18, 22, 2, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1271, 18, 22, 2, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1272, 18, 22, 2, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1273, 18, 22, 3, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1274, 18, 22, 3, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1275, 18, 22, 3, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1276, 18, 22, 3, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1277, 18, 22, 3, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1278, 18, 22, 3, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1279, 18, 22, 3, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1280, 18, 22, 3, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1281, 18, 22, 3, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1282, 18, 22, 3, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1283, 18, 22, 3, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1284, 18, 22, 3, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1285, 18, 22, 4, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1286, 18, 22, 4, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1287, 18, 22, 4, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1288, 18, 22, 4, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1289, 18, 22, 4, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1290, 18, 22, 4, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1291, 18, 22, 4, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1292, 18, 22, 4, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1293, 18, 22, 4, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1294, 18, 22, 4, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1295, 18, 22, 4, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1296, 18, 22, 4, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1297, 18, 22, 5, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1298, 18, 22, 5, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1299, 18, 22, 5, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1300, 18, 22, 5, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1301, 18, 22, 5, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1302, 18, 22, 5, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1303, 18, 22, 5, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1304, 18, 22, 5, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1305, 18, 22, 5, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1306, 18, 22, 5, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1307, 18, 22, 5, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1308, 18, 22, 5, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1309, 18, 22, 6, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1310, 18, 22, 6, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1311, 18, 22, 6, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1312, 18, 22, 6, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1313, 18, 22, 6, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1314, 18, 22, 6, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1315, 18, 22, 6, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1316, 18, 22, 6, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1317, 18, 22, 6, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1318, 18, 22, 6, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1319, 18, 22, 6, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1320, 18, 22, 6, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1321, 18, 23, 7, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1322, 18, 23, 7, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1323, 18, 23, 7, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1324, 18, 23, 7, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1325, 18, 23, 7, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1326, 18, 23, 7, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1327, 18, 23, 7, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1328, 18, 23, 7, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1329, 18, 23, 7, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1330, 18, 23, 7, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1331, 18, 23, 7, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1332, 18, 23, 7, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1333, 18, 23, 8, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1334, 18, 23, 8, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1335, 18, 23, 8, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1336, 18, 23, 8, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1337, 18, 23, 8, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1338, 18, 23, 8, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1339, 18, 23, 8, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1340, 18, 23, 8, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1341, 18, 23, 8, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1342, 18, 23, 8, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1343, 18, 23, 8, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1344, 18, 23, 8, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1345, 18, 23, 9, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1346, 18, 23, 9, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1347, 18, 23, 9, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1348, 18, 23, 9, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1349, 18, 23, 9, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1350, 18, 23, 9, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1351, 18, 23, 9, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1352, 18, 23, 9, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1353, 18, 23, 9, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1354, 18, 23, 9, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1355, 18, 23, 9, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1356, 18, 23, 9, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1357, 18, 23, 10, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1358, 18, 23, 10, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1359, 18, 23, 10, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1360, 18, 23, 10, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1361, 18, 23, 10, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1362, 18, 23, 10, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1363, 18, 23, 10, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1364, 18, 23, 10, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1365, 18, 23, 10, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1366, 18, 23, 10, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1367, 18, 23, 10, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1368, 18, 23, 10, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1369, 18, 23, 11, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1370, 18, 23, 11, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1371, 18, 23, 11, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1372, 18, 23, 11, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1373, 18, 23, 11, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1374, 18, 23, 11, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1375, 18, 23, 11, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1376, 18, 23, 11, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1377, 18, 23, 11, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1378, 18, 23, 11, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1379, 18, 23, 11, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1380, 18, 23, 11, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1381, 18, 23, 12, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1382, 18, 23, 12, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1383, 18, 23, 12, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1384, 18, 23, 12, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1385, 18, 23, 12, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1386, 18, 23, 12, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1387, 18, 23, 12, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1388, 18, 23, 12, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1389, 18, 23, 12, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1390, 18, 23, 12, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1391, 18, 23, 12, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1392, 18, 23, 12, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1393, 18, 23, 13, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1394, 18, 23, 13, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1395, 18, 23, 13, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1396, 18, 23, 13, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1397, 18, 23, 13, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1398, 18, 23, 13, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1399, 18, 23, 13, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1400, 18, 23, 13, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1401, 18, 23, 13, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1402, 18, 23, 13, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1403, 18, 23, 13, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1404, 18, 23, 13, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1405, 18, 23, 14, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1406, 18, 23, 14, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1407, 18, 23, 14, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1408, 18, 23, 14, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1409, 18, 23, 14, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1410, 18, 23, 14, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1411, 18, 23, 14, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1412, 18, 23, 14, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1413, 18, 23, 14, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1414, 18, 23, 14, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1415, 18, 23, 14, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1416, 18, 23, 14, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1417, 18, 23, 15, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1418, 18, 23, 15, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1419, 18, 23, 15, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1420, 18, 23, 15, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1421, 18, 23, 15, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1422, 18, 23, 15, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1423, 18, 23, 15, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1424, 18, 23, 15, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1425, 18, 23, 15, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1426, 18, 23, 15, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1427, 18, 23, 15, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1428, 18, 23, 15, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1429, 18, 24, 16, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1430, 18, 24, 16, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1431, 18, 24, 16, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1432, 18, 24, 16, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1433, 18, 24, 16, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1434, 18, 24, 16, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1435, 18, 24, 16, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1436, 18, 24, 16, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1437, 18, 24, 16, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1438, 18, 24, 16, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1439, 18, 24, 16, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1440, 18, 24, 16, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1441, 18, 24, 17, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1442, 18, 24, 17, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1443, 18, 24, 17, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1444, 18, 24, 17, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1445, 18, 24, 17, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1446, 18, 24, 17, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1447, 18, 24, 17, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1448, 18, 24, 17, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1449, 18, 24, 17, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1450, 18, 24, 17, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1451, 18, 24, 17, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1452, 18, 24, 17, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1453, 18, 24, 18, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1454, 18, 24, 18, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1455, 18, 24, 18, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1456, 18, 24, 18, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1457, 18, 24, 18, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1458, 18, 24, 18, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1459, 18, 24, 18, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1460, 18, 24, 18, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1461, 18, 24, 18, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1462, 18, 24, 18, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1463, 18, 24, 18, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1464, 18, 24, 18, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1465, 18, 24, 19, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1466, 18, 24, 19, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1467, 18, 24, 19, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1468, 18, 24, 19, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1469, 18, 24, 19, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1470, 18, 24, 19, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1471, 18, 24, 19, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1472, 18, 24, 19, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1473, 18, 24, 19, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1474, 18, 24, 19, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1475, 18, 24, 19, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1476, 18, 24, 19, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1477, 18, 24, 20, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1478, 18, 24, 20, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1479, 18, 24, 20, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1480, 18, 24, 20, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1481, 18, 24, 20, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1482, 18, 24, 20, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1483, 18, 24, 20, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1484, 18, 24, 20, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1485, 18, 24, 20, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1486, 18, 24, 20, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1487, 18, 24, 20, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1488, 18, 24, 20, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1489, 18, 24, 21, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1490, 18, 24, 21, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1491, 18, 24, 21, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1492, 18, 24, 21, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1493, 18, 24, 21, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1494, 18, 24, 21, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1495, 18, 24, 21, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1496, 18, 24, 21, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1497, 18, 24, 21, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1498, 18, 24, 21, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1499, 18, 24, 21, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1500, 18, 24, 21, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1501, 18, 24, 22, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1502, 18, 24, 22, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1503, 18, 24, 22, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1504, 18, 24, 22, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1505, 18, 24, 22, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1506, 18, 24, 22, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1507, 18, 24, 22, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1508, 18, 24, 22, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1509, 18, 24, 22, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1510, 18, 24, 22, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1511, 18, 24, 22, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1512, 18, 24, 22, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1513, 18, 24, 23, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1514, 18, 24, 23, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1515, 18, 24, 23, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1516, 18, 24, 23, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1517, 18, 24, 23, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1518, 18, 24, 23, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1519, 18, 24, 23, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1520, 18, 24, 23, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1521, 18, 24, 23, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1522, 18, 24, 23, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1523, 18, 24, 23, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1524, 18, 24, 23, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1525, 18, 25, 24, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1526, 18, 25, 24, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1527, 18, 25, 24, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1528, 18, 25, 24, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1529, 18, 25, 24, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1530, 18, 25, 24, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1531, 18, 25, 24, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1532, 18, 25, 24, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1533, 18, 25, 24, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1534, 18, 25, 24, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1535, 18, 25, 24, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1536, 18, 25, 24, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1537, 18, 25, 25, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1538, 18, 25, 25, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1539, 18, 25, 25, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1540, 18, 25, 25, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1541, 18, 25, 25, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1542, 18, 25, 25, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1543, 18, 25, 25, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1544, 18, 25, 25, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1545, 18, 25, 25, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1546, 18, 25, 25, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1547, 18, 25, 25, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1548, 18, 25, 25, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1549, 18, 25, 26, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1550, 18, 25, 26, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1551, 18, 25, 26, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1552, 18, 25, 26, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1553, 18, 25, 26, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1554, 18, 25, 26, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1555, 18, 25, 26, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1556, 18, 25, 26, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1557, 18, 25, 26, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1558, 18, 25, 26, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1559, 18, 25, 26, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1560, 18, 25, 26, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1561, 18, 25, 27, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1562, 18, 25, 27, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000B8E005E3D0B0000 AS DateTime2), 1, CAST(0x000B8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1563, 18, 25, 27, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1564, 18, 25, 27, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1565, 18, 25, 27, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1566, 18, 25, 27, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1567, 18, 25, 27, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1568, 18, 25, 27, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1569, 18, 25, 27, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1570, 18, 25, 27, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1571, 18, 25, 27, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1572, 18, 25, 27, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1573, 18, 25, 28, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1574, 18, 25, 28, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1575, 18, 25, 28, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1576, 18, 25, 28, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1577, 18, 25, 28, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1578, 18, 25, 28, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1579, 18, 25, 28, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1580, 18, 25, 28, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1581, 18, 25, 28, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1582, 18, 25, 28, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1583, 18, 25, 28, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1584, 18, 25, 28, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1585, 18, 25, 29, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1586, 18, 25, 29, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1587, 18, 25, 29, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1588, 18, 25, 29, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1589, 18, 25, 29, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1590, 18, 25, 29, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1591, 18, 25, 29, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1592, 18, 25, 29, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1593, 18, 25, 29, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1594, 18, 25, 29, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1595, 18, 25, 29, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1596, 18, 25, 29, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1597, 18, 25, 30, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1598, 18, 25, 30, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1599, 18, 25, 30, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1600, 18, 25, 30, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1601, 18, 25, 30, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1602, 18, 25, 30, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1603, 18, 25, 30, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1604, 18, 25, 30, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1605, 18, 25, 30, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1606, 18, 25, 30, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1607, 18, 25, 30, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1608, 18, 25, 30, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1609, 18, 25, 31, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1610, 18, 25, 31, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1611, 18, 25, 31, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1612, 18, 25, 31, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1613, 18, 25, 31, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1614, 18, 25, 31, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1615, 18, 25, 31, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1616, 18, 25, 31, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1617, 18, 25, 31, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1618, 18, 25, 31, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1619, 18, 25, 31, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1620, 18, 25, 31, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1621, 18, 25, 32, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1622, 18, 25, 32, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1623, 18, 25, 32, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1624, 18, 25, 32, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1625, 18, 25, 32, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1626, 18, 25, 32, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1627, 18, 25, 32, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1628, 18, 25, 32, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1629, 18, 25, 32, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1630, 18, 25, 32, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1631, 18, 25, 32, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1632, 18, 25, 32, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1633, 18, 25, 33, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1634, 18, 25, 33, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1635, 18, 25, 33, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1636, 18, 25, 33, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1637, 18, 25, 33, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1638, 18, 25, 33, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1639, 18, 25, 33, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1640, 18, 25, 33, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1641, 18, 25, 33, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1642, 18, 25, 33, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1643, 18, 25, 33, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1644, 18, 25, 33, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1645, 18, 25, 34, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1646, 18, 25, 34, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1647, 18, 25, 34, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1648, 18, 25, 34, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1649, 18, 25, 34, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1650, 18, 25, 34, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1651, 18, 25, 34, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1652, 18, 25, 34, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1653, 18, 25, 34, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1654, 18, 25, 34, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1655, 18, 25, 34, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1656, 18, 25, 34, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1657, 18, 26, 35, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1658, 18, 26, 35, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1659, 18, 26, 35, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1660, 18, 26, 35, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1661, 18, 26, 35, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1662, 18, 26, 35, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1663, 18, 26, 35, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1664, 18, 26, 35, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1665, 18, 26, 35, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1666, 18, 26, 35, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1667, 18, 26, 35, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1668, 18, 26, 35, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1669, 18, 26, 36, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1670, 18, 26, 36, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1671, 18, 26, 36, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1672, 18, 26, 36, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1673, 18, 26, 36, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1674, 18, 26, 36, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1675, 18, 26, 36, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1676, 18, 26, 36, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1677, 18, 26, 36, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1678, 18, 26, 36, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1679, 18, 26, 36, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1680, 18, 26, 36, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1681, 18, 26, 37, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1682, 18, 26, 37, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1683, 18, 26, 37, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1684, 18, 26, 37, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1685, 18, 26, 37, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1686, 18, 26, 37, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1687, 18, 26, 37, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1688, 18, 26, 37, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1689, 18, 26, 37, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1690, 18, 26, 37, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1691, 18, 26, 37, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1692, 18, 26, 37, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1693, 18, 26, 38, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1694, 18, 26, 38, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1695, 18, 26, 38, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1696, 18, 26, 38, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1697, 18, 26, 38, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1698, 18, 26, 38, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1699, 18, 26, 38, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1700, 18, 26, 38, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1701, 18, 26, 38, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1702, 18, 26, 38, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1703, 18, 26, 38, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1704, 18, 26, 38, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1705, 18, 26, 39, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1706, 18, 26, 39, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1707, 18, 26, 39, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1708, 18, 26, 39, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1709, 18, 26, 39, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1710, 18, 26, 39, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1711, 18, 26, 39, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1712, 18, 26, 39, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1713, 18, 26, 39, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1714, 18, 26, 39, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1715, 18, 26, 39, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1716, 18, 26, 39, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
GO
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1717, 18, 26, 40, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1718, 18, 26, 40, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1719, 18, 26, 40, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1720, 18, 26, 40, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1721, 18, 26, 40, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1722, 18, 26, 40, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1723, 18, 26, 40, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1724, 18, 26, 40, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1725, 18, 26, 40, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1726, 18, 26, 40, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1727, 18, 26, 40, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1728, 18, 26, 40, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1729, 18, 26, 41, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1730, 18, 26, 41, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1731, 18, 26, 41, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1732, 18, 26, 41, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1733, 18, 26, 41, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1734, 18, 26, 41, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1735, 18, 26, 41, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1736, 18, 26, 41, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1737, 18, 26, 41, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1738, 18, 26, 41, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1739, 18, 26, 41, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1740, 18, 26, 41, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1741, 18, 26, 42, NULL, CAST(0x9E3A0B00 AS Date), CAST(0xBB3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1742, 18, 26, 42, NULL, CAST(0xBC3A0B00 AS Date), CAST(0xDA3A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1743, 18, 26, 42, NULL, CAST(0xDB3A0B00 AS Date), CAST(0xF93A0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1744, 18, 26, 42, NULL, CAST(0xFA3A0B00 AS Date), CAST(0x163B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1745, 18, 26, 42, NULL, CAST(0x173B0B00 AS Date), CAST(0x353B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1746, 18, 26, 42, NULL, CAST(0x363B0B00 AS Date), CAST(0x533B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1747, 18, 26, 42, NULL, CAST(0x543B0B00 AS Date), CAST(0x723B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1748, 18, 26, 42, NULL, CAST(0x733B0B00 AS Date), CAST(0x903B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1749, 18, 26, 42, NULL, CAST(0x913B0B00 AS Date), CAST(0xAF3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1750, 18, 26, 42, NULL, CAST(0xB03B0B00 AS Date), CAST(0xCE3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1751, 18, 26, 42, NULL, CAST(0xCF3B0B00 AS Date), CAST(0xEC3B0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_fees] ([id], [school_id], [grade_fees_id], [student_id], [route_vehicle_stops_fee_log_id], [apply_from], [apply_to], [fine], [concession_amount], [no_fine], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1752, 18, 26, 42, NULL, CAST(0xED3B0B00 AS Date), CAST(0x0B3C0B00 AS Date), NULL, NULL, 0, 1, CAST(0x000C8E005E3D0B0000 AS DateTime2), 1, CAST(0x000C8E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 1, N'20150', 1, 1, 14, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 2, N'20150', 1, 1, 15, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 3, N'20150', 1, 1, 16, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 4, N'20150', 1, 1, 10, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 5, N'20150', 1, 1, 11, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 6, N'20150', 1, 1, 12, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 7, N'20150', 2, 1, 13, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 8, N'20150', 2, 1, 14, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 9, N'20150', 2, 1, 15, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 10, N'20150557', 2, 1, 36, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 11, N'20150558', 2, 1, 5, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 12, N'20150', 2, 1, 6, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 13, N'20150', 2, 1, 7, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 14, N'20150', 2, 1, 8, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 15, N'20150', 2, 1, 9, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 16, N'20150', 3, 1, 10, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 17, N'20150', 3, 1, 11, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 18, N'20150', 3, 1, 12, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 19, N'20150', 3, 1, 13, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 20, N'20150', 3, 1, 12, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 21, N'20150', 3, 1, 13, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 22, N'20150', 3, 1, 14, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 23, N'20150', 3, 1, 1, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 24, N'20150', 4, 1, 2, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 25, N'20150', 4, 1, 3, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 26, N'20150', 4, 1, 4, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 27, N'20150', 4, 1, 5, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 28, N'20150', 4, 1, 6, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 29, N'20150', 4, 1, 7, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 30, N'20150', 4, 1, 8, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 31, N'20150', 4, 1, 9, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 32, N'20150', 4, 1, 10, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 33, N'20150', 4, 1, 11, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 34, N'20150', 4, 1, 12, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 35, N'20150', 5, 1, 13, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 36, N'20150', 5, 1, 14, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 37, N'20150', 5, 1, 15, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 38, N'20150', 5, 1, 16, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 39, N'20150', 5, 1, 17, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 40, N'20150', 5, 1, 18, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 41, N'20150', 5, 1, 19, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_grade_session_log] ([id], [school_id], [student_id], [registration_id], [grade_id], [section_id], [roll_number], [exam_roll_number], [session_id], [sgsl_status], [created_by], [created_on], [updated_by], [updated_on]) VALUES (NULL, 18, 42, N'20150', 5, 1, 20, NULL, 1, N'active', 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'a5d1b2f3-cced-48fe-8fe4-04ea9e5fc038', 16, 18, 157, 200, 0, N'', N'2235', N'cash', CAST(0x00000000583D0B0000 AS DateTime2), NULL, 1, CAST(0x00112D01583D0B0000 AS DateTime2), 1, CAST(0x00112D01583D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'08c932a7-6d85-4b32-ab5a-06d3807d84ba', 10, 18, 69, 200, 0, N'', N'2233', N'cash', CAST(0x00000000403D0B0000 AS DateTime2), NULL, 1, CAST(0x000DE100403D0B0000 AS DateTime2), 1, CAST(0x000DE100403D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'f3b31422-a120-47ec-9336-3ede3e4e11d6', 1, 18, 61, 200, 0, N'', N'2232', N'cash', CAST(0x00000000403D0B0000 AS DateTime2), NULL, 1, CAST(0x008EE000403D0B0000 AS DateTime2), 1, CAST(0x008EE000403D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'4881b835-3c16-4950-bd1f-4e46dc9833b4', 7, 18, 66, 200, 0, N'', N'2233', N'cash', CAST(0x00000000403D0B0000 AS DateTime2), NULL, 1, CAST(0x000DE100403D0B0000 AS DateTime2), 1, CAST(0x000DE100403D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'38922b5b-795d-49a4-8a43-53004bf0c5a0', 9, 18, 68, 200, 0, N'', N'2233', N'cash', CAST(0x00000000403D0B0000 AS DateTime2), NULL, 1, CAST(0x000DE100403D0B0000 AS DateTime2), 1, CAST(0x000DE100403D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'fdedee58-39db-45db-92a6-6dbd4a8a36eb', 21, 18, 747, 50, 0, N'', N'2236', N'cash', CAST(0x000000005E3D0B0000 AS DateTime2), NULL, 1, CAST(0x00D88E005E3D0B0000 AS DateTime2), 1, CAST(0x00D88E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'7e7c032c-8b0a-4982-97d9-6f8d96074623', 6, 18, 64, 200, 0, N'', N'2233', N'cash', CAST(0x00000000403D0B0000 AS DateTime2), NULL, 1, CAST(0x000DE100403D0B0000 AS DateTime2), 1, CAST(0x000DE100403D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'39f4986c-334b-4cb3-8cbc-7f034b4c8c93', 11, 18, 70, 200, 0, N'', N'2233', N'cash', CAST(0x00000000403D0B0000 AS DateTime2), NULL, 1, CAST(0x000DE100403D0B0000 AS DateTime2), 1, CAST(0x000DE100403D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'7c536fe9-7037-433d-b90f-8002b6cb7d3e', 3, 18, 25, 200, 5, N'', N'2232', N'cash', CAST(0x00000000403D0B0000 AS DateTime2), NULL, 1, CAST(0x00E7E000403D0B0000 AS DateTime2), 1, CAST(0x00E7E000403D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'706fae41-e28c-48aa-9d3f-855bccf5691d', 22, 18, 181, 200, 0, N'', N'2237', N'cash', CAST(0x00000000603D0B0000 AS DateTime2), NULL, 1, CAST(0x00E9B700603D0B0000 AS DateTime2), 1, CAST(0x00E9B700603D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'ee0fe199-d630-4566-8cdd-88ae66a0efdf', 4, 18, 62, 200, 0, N'', N'2233', N'cash', CAST(0x00000000403D0B0000 AS DateTime2), NULL, 1, CAST(0x000DE100403D0B0000 AS DateTime2), 1, CAST(0x000DE100403D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'bfb0886c-c16e-46c9-8c4c-89a5af380b52', 8, 18, 67, 200, 0, N'', N'2233', N'cash', CAST(0x00000000403D0B0000 AS DateTime2), NULL, 1, CAST(0x000DE100403D0B0000 AS DateTime2), 1, CAST(0x000DE100403D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'07cd7d74-864b-4db0-b998-8c9a38f66f70', 14, 18, 121, 200, 0, N'', N'2234', N'cash', CAST(0x00000000583D0B0000 AS DateTime2), NULL, 1, CAST(0x00F32C01583D0B0000 AS DateTime2), 1, CAST(0x00F32C01583D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'9da3fbf4-b242-46df-9455-993a7770fb36', 18, 18, 26, 195, 0, N'', N'2236', N'cash', CAST(0x000000005E3D0B0000 AS DateTime2), NULL, 1, CAST(0x00D88E005E3D0B0000 AS DateTime2), 1, CAST(0x00D88E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'cd4a1cb3-45bb-4ae4-bc39-9b5cb17c1c5b', 20, 18, 746, 50, 0, N'', N'2236', N'cash', CAST(0x000000005E3D0B0000 AS DateTime2), NULL, 1, CAST(0x00D88E005E3D0B0000 AS DateTime2), 1, CAST(0x00D88E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'5c40c0ef-513e-4a44-bd54-9f81136c2568', 15, 18, 122, 200, 0, N'', N'2234', N'cash', CAST(0x00000000583D0B0000 AS DateTime2), NULL, 1, CAST(0x00F32C01583D0B0000 AS DateTime2), 1, CAST(0x00F32C01583D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'756e9252-5580-4137-b0d3-b7ed311f5c1d', 19, 18, 27, 195, 0, N'', N'2236', N'cash', CAST(0x000000005E3D0B0000 AS DateTime2), NULL, 1, CAST(0x00D88E005E3D0B0000 AS DateTime2), 1, CAST(0x00D88E005E3D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'ac7109f5-67af-487f-a97c-b93e38cd3e8a', 13, 18, 72, 200, 0, N'', N'2233', N'cash', CAST(0x00000000403D0B0000 AS DateTime2), NULL, 1, CAST(0x000DE100403D0B0000 AS DateTime2), 1, CAST(0x000DE100403D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'22d598ca-ecd6-410c-a0ae-bd43a63290e1', 17, 18, 158, 200, 0, N'', N'2235', N'cash', CAST(0x00000000583D0B0000 AS DateTime2), NULL, 1, CAST(0x00112D01583D0B0000 AS DateTime2), 1, CAST(0x00112D01583D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'db70c79b-e6c9-4b63-8e36-d2df46a41408', 12, 18, 71, 200, 0, N'', N'2233', N'cash', CAST(0x00000000403D0B0000 AS DateTime2), NULL, 1, CAST(0x000DE100403D0B0000 AS DateTime2), 1, CAST(0x000DE100403D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'45812aa2-6c5e-420a-9f1f-f0a87f4640ea', 5, 18, 63, 200, 0, N'', N'2233', N'cash', CAST(0x00000000403D0B0000 AS DateTime2), NULL, 1, CAST(0x000DE100403D0B0000 AS DateTime2), 1, CAST(0x000DE100403D0B0000 AS DateTime2))
INSERT [dbo].[student_payments] ([id_offline], [id], [school_id], [student_fees_id], [amount], [fine], [comment], [recept_no], [payment_mode], [payment_date], [ip], [created_by], [created_on], [updated_by], [updated_on]) VALUES (N'13173a26-a9ad-48f7-bdf3-fdbbd6f96da3', 2, 18, 65, 200, 0, N'', N'2232', N'cash', CAST(0x00000000403D0B0000 AS DateTime2), NULL, 1, CAST(0x008EE000403D0B0000 AS DateTime2), 1, CAST(0x008EE000403D0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1, 18, 2, 1, 1, 1, 1, NULL, N'20150', N'14', NULL, CAST(0xA0390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (2, 18, 3, 2, 1, 1, 1, NULL, N'20150', N'15', NULL, CAST(0xB6390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (3, 18, 4, 3, 1, 1, 1, NULL, N'20150', N'16', NULL, CAST(0xC2390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (4, 18, 5, 4, 1, 1, 1, NULL, N'20150', N'10', NULL, CAST(0x7E390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (5, 18, 6, 5, 1, 1, 1, NULL, N'20150', N'11', NULL, CAST(0xA5390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (6, 18, 7, 6, 1, 1, 1, NULL, N'20150', N'12', NULL, CAST(0xBC390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (7, 18, 8, 7, 2, 1, 1, NULL, N'20150', N'13', NULL, CAST(0xC1390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (8, 18, 9, 8, 2, 1, 1, NULL, N'20150', N'14', NULL, CAST(0xC8390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (9, 18, 10, 9, 2, 1, 1, NULL, N'20150', N'15', NULL, CAST(0xCB390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (10, 18, 11, 10, 2, 1, 1, NULL, N'20150557', N'36', NULL, CAST(0xE2390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (11, 18, 12, 11, 2, 1, 1, NULL, N'20150558', N'5', NULL, CAST(0xE5390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (12, 18, 13, 12, 2, 1, 1, NULL, N'20150', N'6', NULL, CAST(0x62390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (13, 18, 14, 13, 2, 1, 1, NULL, N'20150', N'7', NULL, CAST(0x74390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (14, 18, 15, 14, 2, 1, 1, NULL, N'20150', N'8', NULL, CAST(0x93390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (15, 18, 16, 15, 2, 1, 1, NULL, N'20150', N'9', NULL, CAST(0xB6390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (16, 18, 17, 16, 3, 1, 1, NULL, N'20150', N'10', NULL, CAST(0xB6390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (17, 18, 18, 17, 3, 1, 1, NULL, N'20150', N'11', NULL, CAST(0xBA390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (18, 18, 19, 18, 3, 1, 1, NULL, N'20150', N'12', NULL, CAST(0xBC390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (19, 18, 20, 19, 3, 1, 1, NULL, N'20150', N'13', NULL, CAST(0xBF390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (20, 18, 21, 20, 3, 1, 1, NULL, N'20150', N'12', NULL, CAST(0xB9390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (21, 18, 22, 21, 3, 1, 1, NULL, N'20150', N'13', NULL, CAST(0xB9390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (22, 18, 23, 22, 3, 1, 1, NULL, N'20150', N'14', NULL, CAST(0xBA390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (23, 18, 24, 23, 3, 1, 1, NULL, N'20150', N'1', NULL, CAST(0xB3390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (24, 18, 25, 24, 4, 1, 1, NULL, N'20150', N'2', NULL, CAST(0xB3390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (25, 18, 26, 25, 4, 1, 1, NULL, N'20150', N'3', NULL, CAST(0xB4390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (26, 18, 27, 26, 4, 1, 1, NULL, N'20150', N'4', NULL, CAST(0xB4390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (27, 18, 28, 27, 4, 1, 1, NULL, N'20150', N'5', NULL, CAST(0xB5390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (28, 18, 29, 28, 4, 1, 1, NULL, N'20150', N'6', NULL, CAST(0xB6390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (29, 18, 30, 29, 4, 1, 1, NULL, N'20150', N'7', NULL, CAST(0xB6390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (30, 18, 31, 30, 4, 1, 1, NULL, N'20150', N'8', NULL, CAST(0xB8390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (31, 18, 32, 31, 4, 1, 1, NULL, N'20150', N'9', NULL, CAST(0xBB390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (32, 18, 33, 32, 4, 1, 1, NULL, N'20150', N'10', NULL, CAST(0xBC390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (33, 18, 34, 33, 4, 1, 1, NULL, N'20150', N'11', NULL, CAST(0xBF390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (34, 18, 35, 34, 4, 1, 1, NULL, N'20150', N'12', NULL, CAST(0xBF390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (35, 18, 36, 35, 5, 1, 1, NULL, N'20150', N'13', NULL, CAST(0xC2390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (36, 18, 37, 36, 5, 1, 1, NULL, N'20150', N'14', NULL, CAST(0xC0390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (37, 18, 38, 37, 5, 1, 1, NULL, N'20150', N'15', NULL, CAST(0xC0390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (38, 18, 39, 38, 5, 1, 1, NULL, N'20150', N'16', NULL, CAST(0xC1390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (39, 18, 40, 39, 5, 1, 1, NULL, N'20150', N'17', NULL, CAST(0xC2390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (40, 18, 41, 40, 5, 1, 1, NULL, N'20150', N'18', NULL, CAST(0xC3390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (41, 18, 42, 41, 5, 1, 1, NULL, N'20150', N'19', NULL, CAST(0xC3390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
INSERT [dbo].[students] ([id], [school_id], [user_id], [parent_id], [grade_id], [section_id], [session_id], [trip_stop_id], [registration_id], [roll_number], [exam_roll_number], [enrollment_date], [status], [dc_number], [dc_date_of_issue], [created_by], [created_on], [updated_by], [updated_on]) VALUES (42, 18, 43, 42, 5, 1, 1, NULL, N'20150', N'20', NULL, CAST(0xC3390B00 AS Date), N'active', NULL, NULL, 1, CAST(0x00C57C00633B0B0000 AS DateTime2), 1, CAST(0x00C57C00633B0B0000 AS DateTime2))
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
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (1, 18, NULL, NULL, N'staff', N'cbse_admin', NULL, NULL, NULL, NULL, NULL, N'CBSE', NULL, N'ADMIN', NULL, N'male', N'O+', N'cbse_admin', CAST(0x35120B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000A806010678F8 AS DateTime), NULL, N'', CAST(0x0000A60800000000 AS DateTime), NULL, CAST(0x0000A60800000000 AS DateTime), NULL)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (2, 18, NULL, NULL, N'student', NULL, NULL, N'9906595824', N'Paraypora Rafiabad', NULL, NULL, N'Umar', N'Hassan', N'Magray', N'<u>Umar</u>, Hassan Magray', N'male', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (3, 18, NULL, NULL, N'student', NULL, NULL, N'9796777954', N'Reban Rafiabad', NULL, NULL, N'Ronak', N'', N'Reyaz', N'<u>Ronak</u>,  Reyaz', N'female', N'O+', NULL, CAST(0xC8320B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (4, 18, NULL, NULL, N'student', NULL, NULL, N'9697812004', N'Budden Rafiabad', NULL, NULL, N'Kaiser', N'Sajad', N'Sheikh', N'<u>Kaiser</u>, Sajad Sheikh', N'male', N'O+', NULL, CAST(0x47290B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (5, 18, NULL, NULL, N'student', NULL, NULL, N'9596319655', N'Arampora Sopore', NULL, NULL, N'Durakshan', N'', N'Majeed', N'<u>Durakshan</u>,  Majeed', N'female', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (6, 18, NULL, NULL, N'student', NULL, NULL, N'9858178956', N'Hib Dangerpora', NULL, NULL, N'Sanjeeda', N'', N'Mansoor', N'<u>Sanjeeda</u>,  Mansoor', N'female', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (7, 18, NULL, NULL, N'student', NULL, NULL, N'9906707804', N'Lorahima Rafiabad', NULL, NULL, N'Toyab', N'', N'Gulzar', N'<u>Toyab</u>,  Gulzar', N'male', N'O+', NULL, CAST(0x52280B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (8, 18, NULL, NULL, N'student', NULL, NULL, N'9596303701', N'Reban Rafiabad', NULL, NULL, N'Afshana', N'', N'Mushtaq', N'<u>Afshana</u>,  Mushtaq', N'female', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (9, 18, NULL, NULL, N'student', NULL, NULL, N'7298866416', N'Budden Rafiabad', NULL, NULL, N'Moin-ul-islam', N'', N'Moin-ul-islam', N'<u>Moin-ul-islam</u>,  Moin-ul-islam', N'male', N'O+', NULL, CAST(0x182F0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (10, 18, NULL, NULL, N'student', NULL, NULL, N'9596063258', N'Nowpora Kalan Sopore', NULL, NULL, N'Suhail', N'Ahmad', N'Yatoo', N'<u>Suhail</u>, Ahmad Yatoo', N'male', N'O+', NULL, CAST(0x10320B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (11, 18, NULL, NULL, N'student', NULL, NULL, N'9796740718', N'Reban Rafiabad', NULL, NULL, N'Maryam', N'', N'Zahoor', N'<u>Maryam</u>,  Zahoor', N'female', N'O+', NULL, CAST(0xD92A0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (12, 18, NULL, NULL, N'student', NULL, NULL, N'9622685749', N'Nowpora Kalan Sopore', NULL, NULL, N'Arooj', N'un', N'nisa', N'<u>Arooj</u>, un nisa', N'female', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (13, 18, NULL, NULL, N'student', NULL, NULL, N'9906873099', N'Nowpora Kalan Sopore', NULL, NULL, N'Dawood', N'Ahmad', N'War', N'<u>Dawood</u>, Ahmad War', N'male', N'O+', NULL, CAST(0xB1250B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (14, 18, NULL, NULL, N'student', NULL, NULL, N'9906926057', N'Nowpora Kalan Sopore', NULL, NULL, N'Mohamad', N'', N'Sahil', N'<u>Mohamad</u>,  Sahil', N'male', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (15, 18, NULL, NULL, N'student', NULL, NULL, N'9596466614', N'Achabal Rafiabad', NULL, NULL, N'Mohammad', N'Umar', N'Dar', N'<u>Mohammad</u>, Umar Dar', N'male', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (16, 18, NULL, NULL, N'student', NULL, NULL, N'9796777954', N'Reban Rafiabad', NULL, NULL, N'Javid', N'', N'Rayaz', N'<u>Javid</u>,  Rayaz', N'male', N'O+', NULL, CAST(0x1F2C0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (17, 18, NULL, NULL, N'student', NULL, NULL, N'9906090513', N'Nowpora Kalan Sopore', NULL, NULL, N'Saliq', N'', N'Suhail', N'<u>Saliq</u>,  Suhail', N'male', N'O+', NULL, CAST(0x74340B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (18, 18, NULL, NULL, N'student', NULL, NULL, N'9596287112', N'Batpora Rafiabad', NULL, NULL, N'Ruhullah', N'', N'Ruhullah', N'<u>Ruhullah</u>,  Ruhullah', N'male', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (19, 18, NULL, NULL, N'student', NULL, NULL, N'9596053957', N'Noorbagh Sopore', NULL, NULL, N'Aiman', N'', N'Parvez', N'<u>Aiman</u>,  Parvez', N'female', N'O+', NULL, CAST(0xA3290B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (20, 18, NULL, NULL, N'student', NULL, NULL, N'8713907997', N'Hadipora Rafiabad', NULL, NULL, N'Alieha', N'bint', N'Ashraf', N'<u>Alieha</u>, bint Ashraf', N'female', N'O+', NULL, CAST(0x48300B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (21, 18, NULL, NULL, N'student', NULL, NULL, N'9596088778', N'Nowpora Kalan Sopore', NULL, NULL, N'Ajaz', N'Manzoor', N'Dar', N'<u>Ajaz</u>, Manzoor Dar', N'male', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (22, 18, NULL, NULL, N'student', NULL, NULL, N'8491076602', N'Kangroosa Rafiabad c/o Model town', NULL, NULL, N'Muzamil', N'', N'Yousuf', N'<u>Muzamil</u>,  Yousuf', N'male', N'O+', NULL, CAST(0x76250B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (23, 18, NULL, NULL, N'student', NULL, NULL, N'9906612256', N'Baba Yousuf Sopore', NULL, NULL, N'Suhaib', N'', N'Tariq', N'<u>Suhaib</u>,  Tariq', N'male', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (24, 18, NULL, NULL, N'student', NULL, NULL, N'9797855452', N'Chatlora Rafiabad', NULL, NULL, N'Mehvish', N'', N'Farooq', N'<u>Mehvish</u>,  Farooq', N'female', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (25, 18, NULL, NULL, N'student', NULL, NULL, N'9419733692', N'Budden Rafiabad', NULL, NULL, N'Adfer', N'', N'Ahad', N'<u>Adfer</u>,  Ahad', N'female', N'O+', NULL, CAST(0x492B0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (26, 18, NULL, NULL, N'student', NULL, NULL, N'9906815201', N'Nowpora Kalan Sopore', NULL, NULL, N'Ubaid', N'Ahmad', N'Dar', N'<u>Ubaid</u>, Ahmad Dar', N'male', N'O+', NULL, CAST(0xE2260B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (27, 18, NULL, NULL, N'student', NULL, NULL, N'9906815201', N'Nowpora Kalan Sopore', NULL, NULL, N'Iqra', N'', N'Ahad', N'<u>Iqra</u>,  Ahad', N'female', N'O+', NULL, CAST(0x6E340B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (28, 18, NULL, NULL, N'student', NULL, NULL, N'9906541720', N'Watergam Rafiabad', NULL, NULL, N'Shazia', N'', N'Ahmad', N'<u>Shazia</u>,  Ahmad', N'female', N'O+', NULL, CAST(0x01270B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (29, 18, NULL, NULL, N'student', NULL, NULL, N'9622598542', N'Nowpora Kalan Sopore', NULL, NULL, N'Gulzar', N'Ahmad', N'Dar', N'<u>Gulzar</u>, Ahmad Dar', N'male', N'O+', NULL, CAST(0x352A0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (30, 18, NULL, NULL, N'student', NULL, NULL, N'9419594389', N'Chijhama Rafiabad', NULL, NULL, N'Faisal', N'Gani', N'Yatoo', N'<u>Faisal</u>, Gani Yatoo', N'male', N'O+', NULL, CAST(0x9D290B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (31, 18, NULL, NULL, N'student', NULL, NULL, N'9697011901', N'Budden Rafiabad', NULL, NULL, N'Irfan', N'', N'Irshad', N'<u>Irfan</u>,  Irshad', N'male', N'O+', NULL, CAST(0x57310B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (32, 18, NULL, NULL, N'student', NULL, NULL, N'9419726794', N'Nowpora Kalan Sopore', NULL, NULL, N'Shakir', N'', N'Irshad', N'<u>Shakir</u>,  Irshad', N'male', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (33, 18, NULL, NULL, N'student', NULL, NULL, N'9622712875', N'Nowpora Kalan Sopore', NULL, NULL, N'Masarat', N'', N'Dilawar', N'<u>Masarat</u>,  Dilawar', N'female', N'O+', NULL, CAST(0x83300B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (34, 18, NULL, NULL, N'student', NULL, NULL, N'9018421616', N'Watergam Rafiabad', NULL, NULL, N'Pakeeza', N'', N'Rashid', N'<u>Pakeeza</u>,  Rashid', N'female', N'O+', NULL, CAST(0x492B0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (35, 18, NULL, NULL, N'student', NULL, NULL, N'9419368928', N'Reban Rafiabad', NULL, NULL, N'Rafia', N'', N'Jan', N'<u>Rafia</u>,  Jan', N'female', N'O+', NULL, CAST(0x0C2B0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (36, 18, NULL, NULL, N'student', NULL, NULL, N'9697812004', N'Budden Rafiabad', NULL, NULL, N'Sheikh', N'Athar', N'Sajad', N'<u>Sheikh</u>, Athar Sajad', N'male', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (37, 18, NULL, NULL, N'student', NULL, NULL, N'9596530409', N'Arampora Sopore', NULL, NULL, N'Danish', N'', N'Fayaz', N'<u>Danish</u>,  Fayaz', N'male', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (38, 18, NULL, NULL, N'student', NULL, NULL, N'8803608795', N'Bomai Sopore', NULL, NULL, N'Nadeem', N'Maq1bool', N'Bhat', N'<u>Nadeem</u>, Maq1bool Bhat', N'male', N'O+', NULL, CAST(0x61350B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (39, 18, NULL, NULL, N'student', NULL, NULL, N'8491962203', N'Baghi Rehmat Sopore', NULL, NULL, N'Bilal', N'Ashraf', N'Kachroo', N'<u>Bilal</u>, Ashraf Kachroo', N'male', N'O+', NULL, CAST(0xEF310B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (40, 18, NULL, NULL, N'student', NULL, NULL, N'9419038879', N'Noorbagh Sopore', NULL, NULL, N'Faisal', N'', N'Farooq', N'<u>Faisal</u>,  Farooq', N'male', N'O+', NULL, CAST(0x4C320B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (41, 18, NULL, NULL, N'student', NULL, NULL, N'9622728678', N'Nowpora Kalan Sopore', NULL, NULL, N'Abid', N'', N'Tariq', N'<u>Abid</u>,  Tariq', N'male', N'O+', NULL, CAST(0xC7280B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (42, 18, NULL, NULL, N'student', NULL, NULL, N'9622579087', N'Nowpora Kalan Sopore', NULL, NULL, N'Shagufta', N'', N'Nabi', N'<u>Shagufta</u>,  Nabi', N'female', N'O+', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (43, 18, NULL, NULL, N'student', NULL, NULL, N'9797862990', N'Nowpora Kalan Sopore', NULL, NULL, N'Zainab', N'', N'Riyaz', N'<u>Zainab</u>,  Riyaz', N'female', N'O+', NULL, CAST(0xA22B0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009022D4 AS DateTime), 1, CAST(0x0000A608009236DC AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (44, 18, NULL, NULL, N'student', NULL, NULL, N'9596303701', N'Reban Rafiabad', NULL, NULL, N'Umar', N'Hassan', N'Magray', N'<u>Umar</u>, Hassan Magray', N'female', N'', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (45, 18, NULL, NULL, N'student', NULL, NULL, N'7298866416', N'Budden Rafiabad', NULL, NULL, N'Ronak', N'', N'Reyaz', N'<u>Ronak</u>,  Reyaz', N'male', N'', NULL, CAST(0x182F0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (46, 18, NULL, NULL, N'student', NULL, NULL, N'9596063258', N'Nowpora Kalan Sopore', NULL, NULL, N'Kaiser', N'Sajad', N'Sheikh', N'<u>Kaiser</u>, Sajad Sheikh', N'male', N'', NULL, CAST(0x10320B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (47, 18, NULL, NULL, N'student', NULL, NULL, N'9796740718', N'Reban Rafiabad', NULL, NULL, N'Durakshan', N'', N'Majeed', N'<u>Durakshan</u>,  Majeed', N'female', N'', NULL, CAST(0xD92A0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (48, 18, NULL, NULL, N'student', NULL, NULL, N'9906873099', N'Nowpora Kalan Sopore', NULL, NULL, N'Toyab', N'', N'Gulzar', N'<u>Toyab</u>,  Gulzar', N'male', N'', NULL, CAST(0xB1250B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (49, 18, NULL, NULL, N'student', NULL, NULL, N'9906926057', N'Nowpora Kalan Sopore', NULL, NULL, N'Afshana', N'', N'Mushtaq', N'<u>Afshana</u>,  Mushtaq', N'male', N'', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (50, 18, NULL, NULL, N'student', NULL, NULL, N'9596466614', N'Achabal Rafiabad', NULL, NULL, N'Moin-ul-islam', N'', N'Moin-ul-islam', N'<u>Moin-ul-islam</u>,  Moin-ul-islam', N'male', N'', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (51, 18, NULL, NULL, N'student', NULL, NULL, N'9796777954', N'Reban Rafiabad', NULL, NULL, N'Suhail', N'Ahmad', N'Yatoo', N'<u>Suhail</u>, Ahmad Yatoo', N'male', N'', NULL, CAST(0x1F2C0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (52, 18, NULL, NULL, N'student', NULL, NULL, N'9906090513', N'Nowpora Kalan Sopore', NULL, NULL, N'Maryam', N'', N'Zahoor', N'<u>Maryam</u>,  Zahoor', N'male', N'', NULL, CAST(0x74340B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (53, 18, NULL, NULL, N'student', NULL, NULL, N'9596287112', N'Batpora Rafiabad', NULL, NULL, N'Arooj', N'un', N'nisa', N'<u>Arooj</u>, un nisa', N'male', N'', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (54, 18, NULL, NULL, N'student', NULL, NULL, N'9596053957', N'Noorbagh Sopore', NULL, NULL, N'Dawood', N'Ahmad', N'War', N'<u>Dawood</u>, Ahmad War', N'female', N'', NULL, CAST(0xA3290B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (55, 18, NULL, NULL, N'student', NULL, NULL, N'8713907997', N'Hadipora Rafiabad', NULL, NULL, N'Mohamad', N'', N'Sahil', N'<u>Mohamad</u>,  Sahil', N'female', N'', NULL, CAST(0x48300B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (56, 18, NULL, NULL, N'student', NULL, NULL, N'8491076602', N'Kangroosa Rafiabad c/o Model town', NULL, NULL, N'Javid', N'', N'Rayaz', N'<u>Javid</u>,  Rayaz', N'male', N'', NULL, CAST(0x76250B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (57, 18, NULL, NULL, N'student', NULL, NULL, N'9906612256', N'Baba Yousuf Sopore', NULL, NULL, N'Saliq', N'', N'Suhail', N'<u>Saliq</u>,  Suhail', N'male', N'', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (58, 18, NULL, NULL, N'student', NULL, NULL, N'9797855452', N'Chatlora Rafiabad', NULL, NULL, N'Ruhullah', N'', N'Ruhullah', N'<u>Ruhullah</u>,  Ruhullah', N'female', N'', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (59, 18, NULL, NULL, N'student', NULL, NULL, N'9419733692', N'Budden Rafiabad', NULL, NULL, N'Aiman', N'', N'Parvez', N'<u>Aiman</u>,  Parvez', N'female', N'', NULL, CAST(0x492B0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (60, 18, NULL, NULL, N'student', NULL, NULL, N'9906815201', N'Nowpora Kalan Sopore', NULL, NULL, N'Alieha', N'bint', N'Ashraf', N'<u>Alieha</u>, bint Ashraf', N'male', N'', NULL, CAST(0xE2260B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (61, 18, NULL, NULL, N'student', NULL, NULL, N'9906815201', N'Nowpora Kalan Sopore', NULL, NULL, N'Ajaz', N'Manzoor', N'Dar', N'<u>Ajaz</u>, Manzoor Dar', N'female', N'', NULL, CAST(0x6E340B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (62, 18, NULL, NULL, N'student', NULL, NULL, N'9906541720', N'Watergam Rafiabad', NULL, NULL, N'Muzamil', N'', N'Yousuf', N'<u>Muzamil</u>,  Yousuf', N'female', N'', NULL, CAST(0x01270B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (63, 18, NULL, NULL, N'student', NULL, NULL, N'9622598542', N'Nowpora Kalan Sopore', NULL, NULL, N'Suhaib', N'', N'Tariq', N'<u>Suhaib</u>,  Tariq', N'male', N'', NULL, CAST(0x352A0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (64, 18, NULL, NULL, N'student', NULL, NULL, N'9419594389', N'Chijhama Rafiabad', NULL, NULL, N'Mehvish', N'', N'Farooq', N'<u>Mehvish</u>,  Farooq', N'male', N'', NULL, CAST(0x9D290B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (65, 18, NULL, NULL, N'student', NULL, NULL, N'9697011901', N'Budden Rafiabad', NULL, NULL, N'Adfer', N'', N'Ahad', N'<u>Adfer</u>,  Ahad', N'male', N'', NULL, CAST(0x57310B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (66, 18, NULL, NULL, N'student', NULL, NULL, N'9419726794', N'Nowpora Kalan Sopore', NULL, NULL, N'Ubaid', N'Ahmad', N'Dar', N'<u>Ubaid</u>, Ahmad Dar', N'male', N'', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (67, 18, NULL, NULL, N'student', NULL, NULL, N'9622712875', N'Nowpora Kalan Sopore', NULL, NULL, N'Iqra', N'', N'Ahad', N'<u>Iqra</u>,  Ahad', N'female', N'', NULL, CAST(0x83300B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (68, 18, NULL, NULL, N'student', NULL, NULL, N'9018421616', N'Watergam Rafiabad', NULL, NULL, N'Shazia', N'', N'Ahmad', N'<u>Shazia</u>,  Ahmad', N'female', N'', NULL, CAST(0x492B0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (69, 18, NULL, NULL, N'student', NULL, NULL, N'9419368928', N'Reban Rafiabad', NULL, NULL, N'Gulzar', N'Ahmad', N'Dar', N'<u>Gulzar</u>, Ahmad Dar', N'female', N'', NULL, CAST(0x0C2B0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (70, 18, NULL, NULL, N'student', NULL, NULL, N'9697812004', N'Budden Rafiabad', NULL, NULL, N'Faisal', N'Gani', N'Yatoo', N'<u>Faisal</u>, Gani Yatoo', N'male', N'', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (71, 18, NULL, NULL, N'student', NULL, NULL, N'9596530409', N'Arampora Sopore', NULL, NULL, N'Irfan', N'', N'Irshad', N'<u>Irfan</u>,  Irshad', N'male', N'', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (72, 18, NULL, NULL, N'student', NULL, NULL, N'8803608795', N'Bomai Sopore', NULL, NULL, N'Shakir', N'', N'Irshad', N'<u>Shakir</u>,  Irshad', N'male', N'', NULL, CAST(0x61350B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (73, 18, NULL, NULL, N'student', NULL, NULL, N'8491962203', N'Baghi Rehmat Sopore', NULL, NULL, N'Masarat', N'', N'Dilawar', N'<u>Masarat</u>,  Dilawar', N'male', N'', NULL, CAST(0xEF310B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (74, 18, NULL, NULL, N'student', NULL, NULL, N'9419038879', N'Noorbagh Sopore', NULL, NULL, N'Pakeeza', N'', N'Rashid', N'<u>Pakeeza</u>,  Rashid', N'male', N'', NULL, CAST(0x4C320B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (75, 18, NULL, NULL, N'student', NULL, NULL, N'9622728678', N'Nowpora Kalan Sopore', NULL, NULL, N'Rafia', N'', N'Jan', N'<u>Rafia</u>,  Jan', N'male', N'', NULL, CAST(0xC7280B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (76, 18, NULL, NULL, N'student', NULL, NULL, N'9622579087', N'Nowpora Kalan Sopore', NULL, NULL, N'Sheikh', N'Athar', N'Sajad', N'<u>Sheikh</u>, Athar Sajad', N'female', N'', NULL, CAST(0x3AF90A00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (77, 18, NULL, NULL, N'student', NULL, NULL, N'9797862990', N'Nowpora Kalan Sopore', NULL, NULL, N'Danish', N'', N'Fayaz', N'<u>Danish</u>,  Fayaz', N'female', N'', NULL, CAST(0xA22B0B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'inactive', CAST(0x0000A608009185E8 AS DateTime), 1, CAST(0x0000A608009185E8 AS DateTime), 1)
INSERT [dbo].[users] ([id], [school_id], [student_id], [role_id], [user_type], [username], [email], [phone], [address_line_one], [address_line_two], [area], [first_name], [middle_name], [last_name], [full_name], [gender], [blood_group], [password], [birth_date], [other_phones], [default_phone_number_id], [adhaar_number], [bank_name], [bank_branch], [bank_account_number], [bank_ifsc_code], [flags], [last_login_time], [user_avatar_file_id], [status], [created_on], [created_by], [updated_on], [updated_by]) VALUES (78, 18, NULL, 1, N'staff', N'abrar_haq', N'', N'', N'Upper Ashpeer Sopore', N'', N'Sopore', N'Abrar', N'', N'Haq', N'<u>Abrar</u>,  Haq', N'male', N'O+', N'unvFPu', CAST(0x67120B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000A63300C5B9F8 AS DateTime), NULL, N'active', CAST(0x0000A631011B60EC AS DateTime), 1, CAST(0x0000A631011B60EC AS DateTime), 1)
INSERT [dbo].[vehicles] ([id], [school_id], [tracker_id], [registration_number], [bus_number], [insurance_renew_date], [staff_id], [created_by], [created_on], [updated_by], [updated_on]) VALUES (1, 18, 3, N'JK 05C 5055', N'1', NULL, 0, 1, CAST(0x007A00016D3B0B0000 AS DateTime2), 1, CAST(0x007A00016D3B0B0000 AS DateTime2))
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
ALTER TABLE [dbo].[fee_categories]  WITH CHECK ADD  CONSTRAINT [fc_created_by_fk] FOREIGN KEY([created_by])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[fee_categories] CHECK CONSTRAINT [fc_created_by_fk]
GO
ALTER TABLE [dbo].[fee_categories]  WITH CHECK ADD  CONSTRAINT [fc_updated_by_fk] FOREIGN KEY([updated_by])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[fee_categories] CHECK CONSTRAINT [fc_updated_by_fk]
GO
ALTER TABLE [dbo].[grade_fees]  WITH CHECK ADD  CONSTRAINT [gf_created_by_fk] FOREIGN KEY([created_by])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[grade_fees] CHECK CONSTRAINT [gf_created_by_fk]
GO
ALTER TABLE [dbo].[grade_fees]  WITH CHECK ADD  CONSTRAINT [gf_updated_by_fk] FOREIGN KEY([updated_by])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[grade_fees] CHECK CONSTRAINT [gf_updated_by_fk]
GO
ALTER TABLE [dbo].[grades]  WITH CHECK ADD  CONSTRAINT [grades_created_by_fk] FOREIGN KEY([created_by])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[grades] CHECK CONSTRAINT [grades_created_by_fk]
GO
ALTER TABLE [dbo].[grades]  WITH CHECK ADD  CONSTRAINT [grades_updated_by_fk] FOREIGN KEY([updated_by])
REFERENCES [dbo].[users] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[grades] CHECK CONSTRAINT [grades_updated_by_fk]
GO
ALTER TABLE [dbo].[routes]  WITH CHECK ADD  CONSTRAINT [r_created_by_fk] FOREIGN KEY([created_by])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[routes] CHECK CONSTRAINT [r_created_by_fk]
GO
ALTER TABLE [dbo].[routes]  WITH CHECK ADD  CONSTRAINT [r_updated_by_fk] FOREIGN KEY([updated_by])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[routes] CHECK CONSTRAINT [r_updated_by_fk]
GO
ALTER TABLE [dbo].[student_payments]  WITH CHECK ADD  CONSTRAINT [sp_created_by_fk] FOREIGN KEY([created_by])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[student_payments] CHECK CONSTRAINT [sp_created_by_fk]
GO
ALTER TABLE [dbo].[student_payments]  WITH CHECK ADD  CONSTRAINT [sp_updated_by_fk] FOREIGN KEY([updated_by])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[student_payments] CHECK CONSTRAINT [sp_updated_by_fk]
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
