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
-- Description:	대특공 보관장소관리 - 보관장소리스트
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingProductKeepZoneList]
	@UserEmail nvarchar(200)
	, @UserPassword nvarchar(100) 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT TOP 1 
	u.ChannelUserID 
	, u.UserName
	, u.UserEmail
	, u.ChannelKindID
FROM dbo.ChannelUsers u 
WHERE u.UseYn=1 
   	  AND u.UserEmail=@UserEmail
	  AND u.UserPassword=@UserPassword 





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 보관장소관리 - 보관장소등록
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingProductKeepZoneInsert]
	@UserEmail nvarchar(200)
	, @UserPassword nvarchar(100) 
AS

SET NOCOUNT ON;

SELECT TOP 1 
	u.ChannelUserID 
	, u.UserName
	, u.UserEmail
	, u.ChannelKindID
FROM dbo.ChannelUsers u 
WHERE u.UseYn=1 
   	  AND u.UserEmail=@UserEmail
	  AND u.UserPassword=@UserPassword 




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 보관장소관리 - 보관장소수정
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingProductKeepZoneUpdate]
	@UserEmail nvarchar(200)
	, @UserPassword nvarchar(100) 
AS

SET NOCOUNT ON;

SELECT TOP 1 
	u.ChannelUserID 
	, u.UserName
	, u.UserEmail
	, u.ChannelKindID
FROM dbo.ChannelUsers u 
WHERE u.UseYn=1 
   	  AND u.UserEmail=@UserEmail
	  AND u.UserPassword=@UserPassword 



	  

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 보관장소관리 - 보관장소삭제
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingProductKeepZoneDelete]
	@UserEmail nvarchar(200)
	, @UserPassword nvarchar(100) 
AS

SET NOCOUNT ON;

SELECT TOP 1 
	u.ChannelUserID 
	, u.UserName
	, u.UserEmail
	, u.ChannelKindID
FROM dbo.ChannelUsers u 
WHERE u.UseYn=1 
   	  AND u.UserEmail=@UserEmail
	  AND u.UserPassword=@UserPassword 