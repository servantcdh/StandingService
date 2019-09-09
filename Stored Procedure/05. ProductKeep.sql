USE [StandingSrv]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-09  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 보관장소관리 - 보관장소리스트
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingProductKeepZoneList]
	@PageSize int = 30, 
	@PageNumber int = 1, 
	@MetroID int, 
	@CircuitID int, 
	@CongregationID int, 
	@PublisherName nvarchar(100), 
	@ServantTypeID int 
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
FROM dbo.KeepZones k 
	INNER JOIN dbo.Publishers p  
		ON k.PublisherID=p.PublisherID 
	INNER JOIN dbo.Congregations g 
		ON p.CongregationID=g.CongregationID 
	INNER JOIN dbo.Circuits c 
		ON g.CircuitID=c.CircuitID
	INNER JOIN dbo.Metros m 
		ON c.MetroID=m.MetroID 
	INNER JOIN dbo.ItemCodes i2   
		ON p.ServantTypeID=i2.ID
WHERE 
	k.UseYn=1 
	AND m.MetroID = CASE WHEN @MetroID IS NULL THEN m.MetroID ELSE @MetroID END 
	AND c.CircuitID = CASE WHEN @CircuitID IS NULL THEN c.CircuitID ELSE @CircuitID END 
	AND g.CongregationID = CASE WHEN @CongregationID IS NULL THEN g.CongregationID ELSE @CongregationID END 
	AND p.PublisherName = CASE WHEN @PublisherName IS NULL THEN p.PublisherName ELSE @PublisherName END 
	AND p.ServantTypeID = CASE WHEN @ServantTypeID IS NULL THEN p.ServantTypeID ELSE @ServantTypeID END 
ORDER BY k.KeepZoneID DESC 
OFFSET (@PageNumber-1)*@PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-09  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 보관장소관리 - 보관장소등록
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingProductKeepZoneInsert]
	@PublisherID int 
	, @ZipCode varchar(10) 
	, @ZoneAddress nvarchar(200)  
AS

SET NOCOUNT ON;

INSERT INTO dbo.KeepZones (
	PublisherID 
	, ZipCode
	, ZoneAddress 
	, UseYn 
	, CreateDate
) VALUES ( 
	@PublisherID
	, @ZipCode
	, @ZoneAddress
	, 1
	, GETDATE()  
) 





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-09  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 보관장소관리 - 보관장소수정
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingProductKeepZoneUpdate]
	@KeepZoneID int  
	, @ZipCode varchar(10) 
	, @ZoneAddress nvarchar(200)  
AS

SET NOCOUNT ON;


UPDATE k SET 
	k.ZipCode=@ZipCode 
	, k.ZoneAddress =@ZoneAddress 
    , k.UpdateDate=GETDATE()  
FROM dbo.KeepZones k 
WHERE k.KeepZoneID=@KeepZoneID



	  

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-09  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 보관장소관리 - 보관장소삭제
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingProductKeepZoneDelete]
	@KeepZoneID int  
	, @UseYn int 
AS

SET NOCOUNT ON;

UPDATE k SET k.UseYn=@UseYn FROM dbo.KeepZones k WHERE k.KeepZoneID=@KeepZoneID 