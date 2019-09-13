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
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 보고된출판물관리 - 일별출판물리스트
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingDailyServiceReportList]
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
-- Description:	대특공 보고된출판물관리 - 일별출판물상세
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingDailyServiceReportDetail]
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



	  