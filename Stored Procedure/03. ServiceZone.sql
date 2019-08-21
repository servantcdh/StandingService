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
-- Description:	대특공 구역관리 - 구역리스트
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingServiceZoneList]
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	z.OrderNum 
	, z.ZoneName 
	, z.ZoneAlias 
	, z.AdminID 
	, z.CreateDate   
FROM dbo.ServiceZones z  
	INNER JOIN dbo.Publishers p 
		ON z.AdminID=p.PublisherID  
WHERE z.UseYn=1 
ORDER BY z.OrderNum 






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 구역관리 - 구역등록
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingServiceZoneInsert]
	@ZoneName nvarchar(50)
	, @ZoneAlias nvarchar(50)
	, @Latitude varchar(50)
	, @Longitude varchar(50)
	, @ZoneAddress nvarchar(200)
	, @OrderNum int
	, @AdminID int
AS

SET NOCOUNT ON;

SELECT TOP 10 * FROM dbo.Publishers 


DECLARE @CIrcuitID int 
SET @CIrcuitID = (SELECT TOP 1 CircuitID FROM dbo.Publishers WHERE PublisherID=@AdminID) 

INSERT INTO dbo.ServiceZones (
	ZoneName
	, ZoneAlias
	, Latitude
	, Longitude
	, ZoneAddress
	, OrderNum
	, AdminID
	, UseYn
	, CreateDate
) VALUES ( 
	CircuitID
	, ZoneName
	, ZoneAlias
	, Latitude
	, Longitude
	, ZoneAddress
	, OrderNum
	, AdminID
	, 1
	, GETDATE()  
) 




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
-- Description:	대특공 구역관리 - 구역수정
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingServiceZoneUpdate]
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
-- Description:	대특공 구역관리 - 구역삭제
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingServiceZoneDelete]
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