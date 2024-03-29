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
-- Description:	대특공 봉사일정관리 - 봉사일정일별수량
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingDailyServicePlanCnt]
	@UserEmail nvarchar(200)
	, @UserPassword nvarchar(100) 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 


SELECT 
	t.ServiceZoneID
	, t.ServiceYoil 
	, t.ServiceTime
	, p.PublisherName 
	, s.LeaderYn
	, s.WaitingYn
FROM dbo.ServiceTimes t 
	INNER JOIN dbo.ServiceZones z 
		ON t.ServiceZoneID=z.ServiceZoneID
	INNER JOIN dbo.Circuits c 
		ON z.CircuitID=c.CircuitID
	LEFT JOIN dbo.ServiceTimeSets s
		ON t.ServiceTimeID=s.ServiceTimeID
WHERE s.PublisherID=@PublisherID
ORDER BY 1, 2, 3 
GO  
 




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사일정관리 - 봉사일정일별상세
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingDailyServicePlanDetail]
	@ServiceDate smalldatetime 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 


SELECT 
	t.ServiceZoneID
	, t.ServiceYoil 
	, t.ServiceTime
	, p.PublisherName 
	, s.LeaderYn
	, s.WaitingYn
FROM dbo.ServiceTimes t 
	INNER JOIN dbo.ServiceZones z 
		ON t.ServiceZoneID=z.ServiceZoneID
	INNER JOIN dbo.Circuits c 
		ON z.CircuitID=c.CircuitID
	LEFT JOIN dbo.ServiceTimeSets s
		ON t.ServiceTimeID=s.ServiceTimeID
WHERE s.PublisherID=@PublisherID
ORDER BY 1, 2, 3 
GO  
 





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사일정관리 - 봉사일정초기화
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingServicePlanReset]
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



	  