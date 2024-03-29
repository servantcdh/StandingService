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
	z.ServiceZoneID 
	, z.OrderNum 
	, z.ZoneName 
	, z.ZoneAlias 
	, a.AdminID
	, a.AdminName  
	, z.CreateDate   
FROM dbo.ServiceZones z  
	INNER JOIN dbo.Admins a 
		ON z.AdminID=a.AdminID  
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
-- Description:	대특공 구역관리 - 구역정보상세
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingServiceZoneDetail]
	@ServiceZoneID int 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	z.ServiceZoneID 
	, z.OrderNum 
	, z.ZoneName 
	, z.ZoneAlias 
	, z.Latitude
	, z.Longitude
	, z.UseYn
	, z.ZoneAddress
	, a.AdminID
	, a.AdminName  
	, z.CreateDate   
FROM dbo.ServiceZones z  
	INNER JOIN dbo.Admins a 
		ON z.AdminID=a.AdminID  
WHERE z.ServiceZoneID=@ServiceZoneID 
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

ALTER PROCEDURE [dbo].[uspSetStandingServiceZoneInsert]
	@ZoneName nvarchar(50)
	, @ZoneAlias nvarchar(50)
	, @Latitude varchar(50)
	, @Longitude varchar(50)
	, @ZoneAddress nvarchar(200)
	, @OrderNum int
	, @AdminID int
	, @CircuitID int 
AS

SET NOCOUNT ON;

INSERT INTO dbo.ServiceZones (
	ZoneName
	, ZoneAlias
	, Latitude
	, Longitude
	, ZoneAddress
	, OrderNum
	, AdminID
	, CircuitID 
	, UseYn
	, CreateDate
) VALUES ( 
	@ZoneName
	, @ZoneAlias
	, @Latitude
	, @Longitude
	, @ZoneAddress
	, @OrderNum
	, @AdminID
	, @CircuitID
	, 1
	, GETDATE()  
) 

SELECT @@ROWCOUNT




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

ALTER PROCEDURE [dbo].[uspSetStandingServiceZoneUpdate]
	@ServiceZoneID int 
	, @ZoneName nvarchar(50)
	, @ZoneAlias nvarchar(50)
	, @Latitude varchar(50)
	, @Longitude varchar(50)
	, @ZoneAddress nvarchar(200)
	, @OrderNum int
	, @AdminID int
	, @CircuitID int 
AS

SET NOCOUNT ON;

UPDATE z SET 
	z.ZoneName=@ZoneName
	, z.ZoneAlias=@ZoneAlias
	, z.Latitude=@Latitude
	, z.Longitude=@Longitude
	, z.ZoneAddress=@ZoneAddress
	, z.OrderNum=@OrderNum
	, z.AdminID=@AdminID
	, z.CircuitID=@CircuitID 
	, z.UpdateDate=GETDATE()  
FROM dbo.ServiceZones z 
WHERE z.ServiceZoneID=@ServiceZoneID

SELECT @@ROWCOUNT


	  

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

ALTER PROCEDURE [dbo].[uspSetStandingServiceZoneDelete]
	@ServiceZoneID int  
AS

SET NOCOUNT ON;

UPDATE z SET z.UseYn=0 FROM dbo.ServiceZones z WHERE z.ServiceZoneID=@ServiceZoneID 

SELECT @@ROWCOUNT
