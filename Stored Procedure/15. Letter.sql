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
-- Description:	대특공 메시지함 - 받은메시지리스트
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingLetterReceiveList]
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
-- Description:	대특공 메시지함 - 받은메시지상세
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingLetterReceiveDetail]
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
-- Description:	대특공 메시지함 - 보낸메시지리스트
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingLetterSendList]
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
-- Description:	대특공 메시지함 - 보낸메시지상세
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingLetterSendDetail]
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
-- Description:	대특공 메시지함 - 메시지등록
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingLetterInsert]
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
	  