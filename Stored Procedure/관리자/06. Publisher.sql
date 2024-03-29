USE [StandingSrv]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-07  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사자관리 - 봉사자리스트
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingPublisherList]
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
FROM dbo.Publishers p  
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
-- Create date: 2019-09-07  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사자관리 - 봉사자등록
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingPublisherInsert]
	@Account nvarchar(100)
	, @PublisherName nvarchar(50) 
	, @UserPassword nvarchar(100)
	, @CongregationID int  
	, @Gender char(1) -- M/F 
	, @Mobile varchar(13) 
	, @MobileOsKindID int 
	, @PhotoFilePath nvarchar(300) 
	, @PioneerTypeID int 
	, @ServantTypeID int 
	, @UseYn bit
	, @SupportYn bit
	, @Memo nvarchar(300)
	, @EndDate smalldatetime 
	, @EndTypeID int  
AS

SET NOCOUNT ON;

INSERT INTO dbo.Publishers (
	Account 
	, PublisherName 
	, UserPassword
	, TempPassYn  
	, CongregationID 
	, Gender 
	, Mobile  
	, MobileOsKindID 
	, PhotoFilePath  
	, PioneerTypeID 
	, ServantTypeID 
	, UseYn
	, SupportYn 
	, Memo 
	, EndDate 
	, EndTypeID
	, CreateDate    
) VALUES ( 
	@Account
	, @PublisherName
	, HASHBYTES('SHA2_512', @UserPassword)  
	, 1 
	, @CongregationID   
	, @Gender   
	, @Mobile 
	, @MobileOsKindID 
	, @PhotoFilePath 
	, @PioneerTypeID 
	, @ServantTypeID 
	, @UseYn 
	, @SupportYn
	, @Memo
	, @EndDate 
	, @EndTypeID 
    , GETDATE()  
) 

SELECT @@ROWCOUNT



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-07
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사자관리 - 봉사자수정
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingPublisherUpdate]
	@PublisherID int 
	, @UserPassword nvarchar(100)
	, @TempPassYn bit 
	, @CongregationID int  
	, @Gender char(1) -- M/F   
	, @Mobile varchar(13) 
	, @MobileOsKindID int 
	, @PhotoFilePath nvarchar(300) 
	, @PioneerTypeID int 
	, @ServantTypeID int 
	, @UseYn bit
	, @SupportYn bit
	, @Memo nvarchar(300)
	, @EndDate smalldatetime 
	, @EndTypeID int  
AS

SET NOCOUNT ON;

UPDATE p SET 
	p.UserPassword=HASHBYTES('SHA2_512', @UserPassword)  
	, p.TempPassYn=@TempPassYn 
	, p.CongregationID=@CongregationID   
	, p.Gender=@Gender   
	, p.Mobile=@Mobile 
	, p.MobileOsKindID=@MobileOsKindID 
	, p.PhotoFilePath=@PhotoFilePath 
	, p.PioneerTypeID=@PioneerTypeID 
	, p.ServantTypeID=@ServantTypeID 
	, p.UseYn=@UseYn 
	, p.SupportYn=@SupportYn
	, p.Memo=@Memo
	, p.EndDate=@EndDate 
	, p.EndTypeID=@EndTypeID 
    , p.UpdateDate=GETDATE()  
FROM dbo.Publishers p 
WHERE p.PublisherID=@PublisherID 

SELECT @@ROWCOUNT



	  

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-07  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사자관리 - 봉사자삭제
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingPublisherDelete]
	@PublisherID int 
	, @UseYn bit 
AS

SET NOCOUNT ON;

UPDATE p SET p.UseYn=@UseYn, p.UpdateDate=GETDATE() FROM dbo.Publishers p WHERE p.PublisherID=@PublisherID 

SELECT @@ROWCOUNT


