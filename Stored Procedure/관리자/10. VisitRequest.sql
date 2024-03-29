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
-- Description:	대특공 방문요청관리 - 방문요청리스트
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingServiceVisitRequestList]
	@PageSize int = 30, 
	@PageNumber int = 1, 
	@MetroID int, 
	@CircuitID int, 
	@CongregationID int, 
	@PublisherName nvarchar(100), 
	@InsteresterName nvarchar(100),
	@StartDate smalldatetime, 
	@EndDate smalldatetime
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	p.PublisherID  
	, m.MetroID
	, m.MetroName 
	, c.CircuitID
	, c.CircuitName 
	, g.CongregationID
	, g.CongregationName
	, p.PublisherName
	, CASE WHEN p.Gender='M' THEN '형제' ELSE '자매' END AS PublisherGender
	, p.Mobile AS PublisherMobile 
	, v.InsteresterName
	, v.Gender
	, v.AddressMain
	, v.Mobile
	, v.CreateDate 
	, CASE WHEN v.AdminID IS NULL THEN '미확인' ELSE '확인' END AS AdminConfirm
	, CASE WHEN v.ReceiptDate IS NULL THEN '미처리' ELSE v.ReceiptDate END AS ReceiptDate 
FROM dbo.Publishers p  
	INNER JOIN dbo.Congregations g 
		ON p.CongregationID=g.CongregationID 
	INNER JOIN dbo.Circuits c 
		ON g.CircuitID=c.CircuitID
	INNER JOIN dbo.Metros m 
		ON c.MetroID=m.MetroID 
	INNER JOIN dbo.VisitRequests v 
		ON p.PublisherID=v.PublisherID  
	INNER JOIN dbo.ItemCodes i2   
		ON p.ServantTypeID=i2.ID
WHERE 
	v.UseYn=1 
	AND m.MetroID = CASE WHEN @MetroID IS NULL THEN m.MetroID ELSE @MetroID END 
	AND c.CircuitID = CASE WHEN @CircuitID IS NULL THEN c.CircuitID ELSE @CircuitID END 
	AND g.CongregationID = CASE WHEN @CongregationID IS NULL THEN g.CongregationID ELSE @CongregationID END 
	AND p.PublisherName = CASE WHEN @PublisherName IS NULL THEN p.PublisherName ELSE @PublisherName END 
	AND v.InsteresterName = CASE WHEN @InsteresterName IS NULL THEN v.InsteresterName ELSE @InsteresterName END 
	AND v.CreateDate >= CASE WHEN @StartDate IS NULL THEN DATEADD(MM, -1, GETDATE()) ELSE @StartDate END
	AND v.CreateDate < CASE WHEN @EndDate IS NULL THEN DATEADD(MM, 3, GETDATE()) ELSE DATEADD(DD, 1, @EndDate) END
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
-- Description:	대특공 방문요청관리 - 방문요청상세
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingServiceVisitRequestDetail]
	@VisitRequestID int 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 


SELECT 
	p.PublisherID  
	, m.MetroID
	, m.MetroName 
	, c.CircuitID
	, c.CircuitName 
	, g.CongregationID
	, g.CongregationName
	, p.PublisherName
	, CASE WHEN p.Gender='M' THEN '형제' ELSE '자매' END AS PublisherGender
	, p.Mobile AS PublisherMobile 
	, v.InsteresterName
	, v.Gender
	, v.Country 
	, v.Sido
	, v.Sigungu
	, v.AddressMain
	, v.AddressDetail
	, v.ZipCode
	, v.Mobile 
	, v.Email
	, v.RequestWeekday
	, v.RequestTime 
	, v.CreateDate 
	, v.ReceiptDate
	, v.Contents
FROM dbo.Publishers p  
	INNER JOIN dbo.Congregations g 
		ON p.CongregationID=g.CongregationID 
	INNER JOIN dbo.Circuits c 
		ON g.CircuitID=c.CircuitID
	INNER JOIN dbo.Metros m 
		ON c.MetroID=m.MetroID 
	INNER JOIN dbo.VisitRequests v 
		ON p.PublisherID=v.PublisherID  
	INNER JOIN dbo.ItemCodes i2   
		ON p.ServantTypeID=i2.ID
WHERE v.VisitRequestID=@VisitRequestID 





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-09  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 방문요청관리 - 방문요청등록 (사용자)
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingServiceVisitRequestInsert]
	@PublisherID int  
	, @InsteresterName nvarchar(50) 
	, @Gender nvarchar(1) -- M/F 
	, @Country nvarchar(50) 
	, @Sido nvarchar(50)
	, @Sigungu nvarchar(50)
	, @AddressMain nvarchar(200)
	, @AddressDetail nvarchar(200)
	, @ZipCode varchar(10)
	, @Mobile varchar(15)
	, @Email varchar(50)
	, @RequestWeekday nvarchar(1) -- 월/화/수/목/금/토/일
	, @RequestTime nvarchar(10)
	, @Contents nvarchar(2000)
AS

SET NOCOUNT ON;


INSERT INTO dbo.VisitRequests (
	InsteresterName
	, Gender 
	, Country 
	, Sido 
	, Sigungu 
	, AddressMain
	, AddressDetail 
	, ZipCode 
	, Mobile 
	, Email 
	, RequestWeekday 
	, RequestTime 
	, Contents 
	, UseYn 
	, CreateDate 
) VALUES ( 
	@InsteresterName
	, @Gender 
	, @Country 
	, @Sido 
	, @Sigungu 
	, @AddressMain
	, @AddressDetail 
	, @ZipCode 
	, @Mobile 
	, @Email 
	, @RequestWeekday 
	, @RequestTime 
	, @Contents 
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
-- Description:	대특공 방문요청관리 - 방문요청수정
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingServiceVisitRequestUpdate]
	@VisitRequestID int 
	, @InsteresterName nvarchar(50) 
	, @Gender nvarchar(1) -- M/F 
	, @Country nvarchar(50) 
	, @Sido nvarchar(50)
	, @Sigungu nvarchar(50)
	, @AddressMain nvarchar(200)
	, @AddressDetail nvarchar(200)
	, @ZipCode varchar(10)
	, @Mobile varchar(15)
	, @Email varchar(50)
	, @RequestWeekday nvarchar(1) -- 월/화/수/목/금/토/일 
	, @RequestTime nvarchar(10)
	, @Contents nvarchar(2000)
AS

SET NOCOUNT ON;

UPDATE v SET 
	v.InsteresterName=@InsteresterName 
	, v.Gender=@Gender 
	, v.Country=@Country
	, v.Sido=@Sido
	, v.Sigungu=@Sigungu
	, v.AddressMain=@AddressMain
	, v.AddressDetail=@AddressDetail 
	, v.ZipCode=@ZipCode 
	, v.Mobile=@Mobile
	, v.Email=@Email
	, v.RequestWeekday=@RequestWeekday
	, v.RequestTime=@RequestTime
	, v.Contents=@Contents
    , v.UpdateDate=GETDATE()  
FROM dbo.VisitRequests v
WHERE v.VisitRequestID=@VisitRequestID 

SELECT @@ROWCOUNT



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 방문요청관리 - 방문요청삭제
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingServiceVisitRequestDelete]
	@VisitRequestID int 
	, @UseYn bit 
AS

SET NOCOUNT ON;

UPDATE v SET v.UseYn=@UseYn, v.UpdateDate=GETDATE() FROM dbo.VisitRequests v WHERE v.VisitRequestID=@VisitRequestID 

SELECT @@ROWCOUNT



