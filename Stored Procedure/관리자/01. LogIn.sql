USE [StandingSrv]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 로그인 - 관리자로그인 
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingAdminLogIn]
	@Account nvarchar(100)
	, @UserPassword nvarchar(100) 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT TOP 1 
	a.AdminID 
	, a.AdminName
	, a.AdminRoleID
	, a.MetroID
	, a.CircuitID
	, a.CongregationID
	, a.TempPassYn 
FROM dbo.Admins a 
WHERE a.UseYn=1 
   		AND a.Account=@Account
		AND a.UserPassword=HASHBYTES('SHA2_512', @UserPassword) 





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 로그인 - 비밀번호변경
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingAdminPasswordUpdate]
	@AdminID int 
	, @OldPassword nvarchar(100) 
	, @NewPassword nvarchar(100) 
AS

SET NOCOUNT ON;

UPDATE a SET 
	a.UserPassword=HASHBYTES('SHA2_512', @NewPassword)
FROM dbo.Admins a 
WHERE a.UseYn=1 
   		AND a.AdminID=@AdminID
		AND a.UserPassword=HASHBYTES('SHA2_512', @OldPassword) 

SELECT @@ROWCOUNT




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 로그인 - 비밀번호초기화
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingAdminPasswordReset]
	@Account nvarchar(100)
	, @Mobile varchar(15) 
AS

SET NOCOUNT ON;

DECLARE @ResetPassword nvarchar(100) 
SET @ResetPassword='11112222'

UPDATE a SET 
	a.UserPassword=HASHBYTES('SHA2_512', @ResetPassword)
FROM dbo.Admins a 
WHERE a.UseYn=1 
   		AND a.Account=@Account
		AND a.Mobile=@Mobile

SELECT @@ROWCOUNT

