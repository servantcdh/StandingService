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

ALTER PROCEDURE [dbo].[uspGetStandingProductKeepZoneList]
	@PageSize int = 30, 
	@PageNumber int = 1, 
	@MetroID int, 
	@CircuitID int, 
	@CongregationID int, 
	@AdminName nvarchar(100) 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	a.AdminID  
	, m.MetroID
	, m.MetroName 
	, c.CircuitID
	, c.CircuitName 
	, a.AdminName
	, a.AdminRoleID 
	, i.Item AS AdminRole 
	, a.Mobile
	, k.ZipCode 
	, k.ZoneAddress  
	, CONVERT(char(10), k.CreateDate, 121) AS CreateDate  
FROM dbo.KeepZones k 
	INNER JOIN dbo.Admins a  
		ON k.AdminID=a.AdminID 
	INNER JOIN dbo.ItemCodes i   
		ON a.AdminRoleID=i.ID
	LEFT JOIN dbo.Congregations g 
		ON a.CongregationID=g.CongregationID 
	LEFT JOIN dbo.Circuits c 
		ON a.CircuitID=c.CircuitID
	LEFT JOIN dbo.Metros m 
		ON a.MetroID=m.MetroID 
WHERE 
	k.UseYn=1 
	AND m.MetroID = CASE WHEN @MetroID IS NULL THEN m.MetroID ELSE @MetroID END 
	AND c.CircuitID = CASE WHEN @CircuitID IS NULL THEN c.CircuitID ELSE @CircuitID END 
	AND g.CongregationID = CASE WHEN @CongregationID IS NULL THEN g.CongregationID ELSE @CongregationID END 
	AND a.AdminName = CASE WHEN @AdminName IS NULL THEN a.AdminName ELSE @AdminName END 
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
	@AdminID int 
	, @ZipCode varchar(10) 
	, @ZoneAddress nvarchar(200)  
AS

SET NOCOUNT ON;

INSERT INTO dbo.KeepZones (
	AdminID 
	, ZipCode
	, ZoneAddress 
	, UseYn 
	, CreateDate
) VALUES ( 
	@AdminID
	, @ZipCode
	, @ZoneAddress
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

SELECT @@ROWCOUNT


	  

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

ALTER PROCEDURE [dbo].[uspSetStandingProductKeepZoneDelete]
	@KeepZoneID int  
	, @UseYn int 
AS

SET NOCOUNT ON;

UPDATE k SET k.UseYn=@UseYn FROM dbo.KeepZones k WHERE k.KeepZoneID=@KeepZoneID 

SELECT @@ROWCOUNT
