USE [StandingSrv]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-17  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사시간관리 - 봉사타임지정 선택정보 
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingServiceTimeList]
	@CircuitID int 
	, @ServiceYoil nvarchar(1)
AS

SET NOCOUNT ON;

SELECT 
	t.ServiceZoneID
	, t.ServiceTime
	, COUNT(*) AS PublisherCnt 
FROM dbo.ServiceTimes t 
	INNER JOIN dbo.ServiceZones z 
		ON t.ServiceZoneID=z.ServiceZoneID
	INNER JOIN dbo.Circuits c 
		ON z.CircuitID=c.CircuitID
	LEFT JOIN dbo.ServiceTimeSets s
		ON t.ServiceTimeID=s.ServiceTimeID
WHERE c.CircuitID=@CircuitID AND t.ServiceYoil=@ServiceYoil AND s.WaitingYn=0
GROUP BY t.ServiceZoneID, t.ServiceTime
ORDER BY t.ServiceZoneID, t.ServiceTime
GO 



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-17  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사시간관리 - 봉사타임지정 선택정보 (봉사자 세팅정보) 
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingServiceTimePublisher]
	@PublisherID int 
AS

SET NOCOUNT ON;

SELECT 
	t.ServiceZoneID
	, t.ServiceYoil 
	, t.ServiceTime
	, CASE WHEN s.PublisherID IS NULL THEN '미지정'  
		   WHEN s.PublisherID IS NOT NULL AND s.WaitingYn=1 THEN '대기'  
		   WHEN s.PublisherID IS NOT NULL ANd s.WaitingYn=0 AND s.LeaderYn=0 THEN '봉사자'  
		   WHEN s.PublisherID IS NOT NULL ANd s.WaitingYn=0 AND s.LeaderYn=1 THEN '인도자'  
	  END AS ServiceSetType 
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
-- Description:	대특공 봉사시간관리 - 봉사자 봉사시간셋팅정보 등록
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingServiceTimePublieherInsert]
	@PublisherID int
	, @ServiceTimeID int 
	, @LeaderYn bit 
	, @WaitingYn bit 
AS

SET NOCOUNT ON;

INSERT INTO dbo.ServiceTimeSets (
	ServiceTimeID
	, PublisherID
	, LeaderYn
	, WaitingYn 
	, CreateDate 
) VALUES ( 
	@ServiceTimeID
	, @PublisherID
	, @LeaderYn
	, @WaitingYn 
	, GETDATE() 
) 
  
  





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사시간관리 - 봉사자 봉사시간셋팅정보 수정
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingServiceTimePublieherUpdate]
	@PublisherID int
	, @ServiceTimeID int 
	, @LeaderYn bit 
	, @WaitingYn bit 
AS

SET NOCOUNT ON;
	  

UPDATE s SET 
	s.LeaderYn=@LeaderYn
	, s.WaitingYn=@WaitingYn
	, s.UpdateDate=GETDATE()  
FROM dbo.ServiceTimeSets s 
WHERE s.ServiceTimeID=@ServiceTimeID AND s.PublisherID=@PublisherID

SELECT @@ROWCOUNT






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사시간관리 - 봉사자 봉사시간셋팅정보 삭제 
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingServiceTimePublieherDelete]
	@PublisherID int
	, @ServiceTimeID int 
AS

SET NOCOUNT ON;
  

DELETE FROM dbo.ServiceTimeSets WHERE ServiceTimeID=@ServiceTimeID AND PublisherID=@PublisherID

SELECT @@ROWCOUNT
