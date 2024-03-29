USE [StandingSrv]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-13  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 보고된출판물관리 - 일별출판물수량 (27Page) 
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingDailyServiceReportCnt]
	@SetMonth smalldatetime -- '2019-01-01' 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

CREATE TABLE #Date (
	YMD smalldatetime 
) 

DECLARE @SetDate smalldatetime 
SET @SetDate = @SetMonth 

WHILE @SetDate < DATEADD(MM, 1, @SetMonth) BEGIN 
	INSERT INTO #Date (YMD) VALUES (@SetDate)   
	SET @SetDate=DATEADD(DD, 1, @SetDate) 
END 

SELECT 
	d.YMD
	, ISNULL(rr.PlacementQty, 0) AS PlacementQty
	, ISNULL(vv.VideoShowQty, 0) AS VideoShowQty
	, ISNULL(tt.VisitRequestQty, 0) AS VisitRequestQty
FROM #Date d 
	LEFT JOIN (
		SELECT 
			r.ServiceDate
			, SUM(r.Qty) AS PlacementQty      
		FROM dbo.ServiceReports r
			INNER JOIN dbo.Products p 
				ON r.ProductID=p.ProductID
			INNER JOIN dbo.ItemCodes c 
				ON p.ProductKindID=c.ID 	 
		WHERE c.Item<>N'동영상'
			  AND r.ServiceDate>=@SetMonth AND r.ServiceDate<DATEADD(MM, 1, @SetMonth)
		GROUP BY r.ServiceDate		
	) rr ON d.YMD=rr.ServiceDate   
	LEFT JOIN (
		SELECT 
			r.ServiceDate
			, SUM(r.Qty)  AS VideoShowQty        
		FROM dbo.ServiceReports r
			INNER JOIN dbo.Products p 
				ON r.ProductID=p.ProductID
			INNER JOIN dbo.ItemCodes c 
				ON p.ProductKindID=c.ID 	 
		WHERE c.Item=N'동영상'
			  AND r.ServiceDate>=@SetMonth AND r.ServiceDate<DATEADD(MM, 1, @SetMonth)
		GROUP BY r.ServiceDate		
	) vv ON d.YMD=vv.ServiceDate   
	LEFT JOIN (
		SELECT 
			t.ServiceDate
			, COUNT(*) AS VisitRequestQty        
		FROM dbo.VisitRequests t 
		WHERE t.UseYn=1
		      --AND t.ServiceDate>=@SetMonth AND t.ServiceDate<DATEADD(MM, 1, @SetMonth)
		GROUP BY t.ServiceDate		
	) tt ON d.YMD=tt.ServiceDate   
ORDER BY d.YMD 






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-17  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 보고된출판물관리 - 일별출판물리스트
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingDailyServiceReportList]
	@PageSize int = 30, 
	@PageNumber int = 1, 
	@MetroID int, 
	@CircuitID int, 
	@ServiceZoneID int, 
	@ServiceDate smalldatetime 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 


SELECT 
	t.ServiceTime
	, z.ZoneName  
	, b.PublisherName  
	, r.ServiceDate
	, SUM(CASE WHEN cc.Item<>N'동영상' THEN r.Qty ELSE 0 END) AS VideoShowQty
	, SUM(CASE WHEN cc.Item=N'동영상' THEN r.Qty ELSE 0 END) AS VideoShowQty
	, SUM(r.Qty) AS PlacementQty      
FROM dbo.ServiceReports r
	INNER JOIN dbo.Publishers b  
		ON r.PublisherID=b.PublisherID
	INNER JOIN dbo.ServiceActs a 
		ON r.ServiceActID=a.ServiceActID
	INNER JOIN dbo.ServiceTimes t 
		ON a.ServiceTimeID=t.ServiceTimeID
	INNER JOIN dbo.ServiceZones z 
		ON t.ServiceZoneID=z.ServiceZoneID
	INNER JOIN dbo.Circuits c 
		ON z.CircuitID=c.CircuitID
	INNER JOIN dbo.Metros m 
		ON c.MetroID=m.MetroID
	INNER JOIN dbo.Products p 
		ON r.ProductID=p.ProductID
	INNER JOIN dbo.ItemCodes cc  
		ON p.ProductKindID=cc.ID 	
	LEFT JOIN (
		SELECT 
			t.ServiceDate
			, t.PublisherID 
			, COUNT(*) AS VisitRequestQty        
		FROM dbo.VisitRequests t 
		WHERE t.UseYn=1
		      AND t.ServiceDate>=@ServiceDate AND t.ServiceDate<DATEADD(MM, 1, @ServiceDate)
		GROUP BY t.ServiceDate, t.PublisherID		
	) tt ON r.ServiceDate=tt.ServiceDate   		 
WHERE r.ServiceDate>=@ServiceDate AND r.ServiceDate<DATEADD(MM, 1, @ServiceDate)
	AND m.MetroID = CASE WHEN @MetroID IS NULL THEN m.MetroID ELSE @MetroID END 
	AND c.CircuitID = CASE WHEN @CircuitID IS NULL THEN c.CircuitID ELSE @CircuitID END 
	AND z.ServiceZoneID = CASE WHEN @ServiceZoneID IS NULL THEN z.ServiceZoneID ELSE @ServiceZoneID END 
GROUP BY t.ServiceTime, z.ZoneName, b.PublisherName, r.ServiceDate    
ORDER BY t.ServiceTime, z.ZoneName, b.PublisherName	
OFFSET (@PageNumber-1)*@PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY







SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-17  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 보고된출판물관리 - 일별출판물상세 (상단전도인정보) 
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingDailyServiceReportDetail]
	@PublisherID int 
	, @ServiceDate smalldatetime 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	m.MetroID
	, m.MetroName 
	, c.CircuitID
	, c.CircuitName 
	, p.PublisherID  
	, p.PublisherName
	, p.Mobile 
	, @ServiceDate AS ServiceDate  
FROM dbo.Publishers p  
	INNER JOIN dbo.Congregations g 
		ON p.CongregationID=g.CongregationID 
	INNER JOIN dbo.Circuits c 
		ON g.CircuitID=c.CircuitID
	INNER JOIN dbo.Metros m 
		ON c.MetroID=m.MetroID 
WHERE p.PublisherID=@PublisherID




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-17  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 보고된출판물관리 - 일별출판물상세
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingDailyServiceReportDetailList]
	@PublisherID int 
	, @ServiceDate smalldatetime 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 


SELECT 
	m.MetroName 
	, c.CircuitName
	, p.LanguageName 
	, cc.Item AS ProductType  
	, p.ProductName 
FROM dbo.ServiceReports r
	INNER JOIN dbo.Publishers b  
		ON r.PublisherID=b.PublisherID
	INNER JOIN dbo.ServiceActs a 
		ON r.ServiceActID=a.ServiceActID
	INNER JOIN dbo.Circuits c 
		ON r.CircuitID=c.CircuitID
	INNER JOIN dbo.Metros m 
		ON c.MetroID=m.MetroID
	INNER JOIN dbo.Products p 
		ON r.ProductID=p.ProductID
	INNER JOIN dbo.ItemCodes cc  
		ON p.ProductKindID=cc.ID 	
WHERE cc.Item<>N'동영상'
      AND b.PublisherID=@PublisherID
	  AND r.ServiceDate=@ServiceDate
ORDER BY 1, 2, 3 


