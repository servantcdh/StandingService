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
	@PageSize int = 30, 
	@PageNumber int = 1, 
	@MetroID int, 
	@CircuitID int, 
	@CongregationID int, 
	@PublisherName nvarchar(100), 
	@Gender char(1), 
	@ServantTypeID int, 
	@EndYn bit = 0 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	p.PublisherID  
	, m.MetroID
	, m.MetroName 
	, c.CircuitID
	, c.CircuitName 
	, p.PublisherName
	, p.ServantTypeID 
	, i2.Item AS ServantType 
	, p.Mobile 
	, CASE WHEN p.EndDate IS NULL THEN '봉사중' ELSE '중단' END AS EndKind
	, CONVERT(char(10), p.CreateDate, 121) AS CreateDate  

FROM dbo.Letters e 
	INNER JOIN dbo.Admins a 
		ON e.AdminID=a.AdminID   
	INNER JOIN dbo.Admins a 
		ON e.ReceiveAdminID=a.AdminID   




dbo.Publishers p  
	INNER JOIN dbo.Congregations g 
		ON p.CongregationID=g.CongregationID 
	INNER JOIN dbo.Circuits c 
		ON g.CircuitID=c.CircuitID
	INNER JOIN dbo.Metros m 
		ON c.MetroID=m.MetroID 
	INNER JOIN dbo.ItemCodes i2   
		ON p.ServantTypeID=i2.ID
WHERE 
	p.UseYn=1 
	AND m.MetroID = CASE WHEN @MetroID IS NULL THEN m.MetroID ELSE @MetroID END 
	AND c.CircuitID = CASE WHEN @CircuitID IS NULL THEN c.CircuitID ELSE @CircuitID END 
	AND g.CongregationID = CASE WHEN @CongregationID IS NULL THEN g.CongregationID ELSE @CongregationID END 
	AND p.PublisherName = CASE WHEN @PublisherName IS NULL THEN p.PublisherName ELSE @PublisherName END 
	AND p.Gender = CASE WHEN @Gender IS NULL THEN p.Gender ELSE @Gender END 
	AND p.ServantTypeID = CASE WHEN @ServantTypeID IS NULL THEN p.ServantTypeID ELSE @ServantTypeID END 
ORDER BY p.PublisherID DESC 
OFFSET (@PageNumber-1)*@PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY





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
	  