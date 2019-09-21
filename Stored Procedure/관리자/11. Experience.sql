USE [StandingSrv]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-10  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 경험담관리 - 경험담리스트
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingServiceExperienceList]
	@PageSize int = 30, 
	@PageNumber int = 1, 
	@MetroID int, 
	@CircuitID int, 
	@CongregationID int, 
	@AdminName nvarchar(50),  
	@PublisherName nvarchar(50),  
	@BranchConfirmYn bit,
	@StartDate smalldatetime, 
	@EndDate smalldatetime  
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	x.MetroName   
	, x.CircuitName 
	, x.AdminName  
	, x.Mobile 
	, p.PublisherName
	, p.Gender 
	, c.CircuitName 
	, g.CongregationName
	, p.Mobile
	, CONVERT(char(10), e.CreateDate, 121) AS CreateDate  
	, e.BranchConfirmYn  
FROM dbo.Experiences e
	INNER JOIN (
		SELECT aa.AdminID, aa.AdminName, mm.MetroID, mm.MetroName, cc.CircuitID, cc.CircuitName, aa.Mobile 	
		FROM dbo.Admins aa  
			INNER JOIN dbo.ItemCodes ss 
				ON aa.AdminRoleID=ss.ID 
			LEFT JOIN dbo.Circuits cc 
				ON aa.CircuitID=cc.CircuitID
			LEFT JOIN dbo.Metros mm 
				ON aa.MetroID=mm.MetroID 
		WHERE ss.Item=N'순회감독자' 
	 ) x ON e.AdminID=x.AdminID  
	INNER JOIN dbo.Publishers p 
		ON e.PublisherID=p.PublisherID 
	INNER JOIN dbo.Congregations g 
		ON p.CongregationID=g.CongregationID 
	INNER JOIN dbo.Circuits c 
		ON g.CircuitID=c.CircuitID 
	INNER JOIN dbo.Metros m 
		ON c.MetroID=m.MetroID 
WHERE 
	e.UseYn=1 
	AND x.MetroID = CASE WHEN @MetroID IS NULL THEN x.MetroID ELSE @MetroID END 
	AND x.CircuitID = CASE WHEN @CircuitID IS NULL THEN c.CircuitID ELSE @CircuitID END 
	AND x.AdminName = CASE WHEN @AdminName IS NULL THEN x.AdminName ELSE @AdminName END 
	AND p.PublisherName = CASE WHEN @PublisherName IS NULL THEN p.PublisherName ELSE @PublisherName END 
	AND e.BranchConfirmYn = CASE WHEN @BranchConfirmYn IS NULL THEN e.BranchConfirmYn ELSE @BranchConfirmYn END 
ORDER BY e.ExperienceID DESC 
OFFSET (@PageNumber-1)*@PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-10  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 경험담관리 - 경험담보고 등록을 위한 관리자(순회감독자) 정보 
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingServiceExperienceAdminInfo]
	@AdminID int
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	aa.AdminID
	, aa.AdminName
	, mm.MetroID
	, mm.MetroName
	, cc.CircuitID
	, cc.CircuitName
	, aa.Mobile 	
FROM dbo.Admins aa  
	INNER JOIN dbo.ItemCodes ss 
		ON aa.AdminRoleID=ss.ID 
	LEFT JOIN dbo.Circuits cc 
		ON aa.CircuitID=cc.CircuitID
	LEFT JOIN dbo.Metros mm 
		ON aa.MetroID=mm.MetroID 
WHERE aa.AdminID=@AdminID 

SELECT @@ROWCOUNT





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-10  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 경험담관리 - 경험담상세
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingServiceExperienceDetail]
	@ExperienceID int
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	x.MetroName   
	, x.CircuitName 
	, x.AdminName  
	, x.Mobile 
	, p.PublisherName
	, p.Gender 
	, c.CircuitName 
	, g.CongregationName
	, p.Mobile
	, CONVERT(char(10), e.CreateDate, 121) AS CreateDate  
	, e.BranchConfirmYn  
FROM dbo.Experiences e
	INNER JOIN (
		SELECT aa.AdminID, aa.AdminName, mm.MetroID, mm.MetroName, cc.CircuitID, cc.CircuitName, aa.Mobile 	
		FROM dbo.Admins aa  
			INNER JOIN dbo.ItemCodes ss 
				ON aa.AdminRoleID=ss.ID 
			LEFT JOIN dbo.Circuits cc 
				ON aa.CircuitID=cc.CircuitID
			LEFT JOIN dbo.Metros mm 
				ON aa.MetroID=mm.MetroID 
		WHERE ss.Item=N'순회감독자' 
	 ) x ON e.AdminID=x.AdminID  
	INNER JOIN dbo.Publishers p 
		ON e.PublisherID=p.PublisherID 
	INNER JOIN dbo.Congregations g 
		ON p.CongregationID=g.CongregationID 
	INNER JOIN dbo.Circuits c 
		ON g.CircuitID=c.CircuitID 
	INNER JOIN dbo.Metros m 
		ON c.MetroID=m.MetroID 
WHERE 
	e.ExperienceID=@ExperienceID 

SELECT @@ROWCOUNT






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-10    
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 경험담관리 - 경험담등록 
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingServiceExperienceInsert]
	@AdminID int 
	, @PublisherID int  
	, @Contents nvarchar(max)
AS

SET NOCOUNT ON;

INSERT INTO dbo.Experiences (
	AdminID 
	, PublisherID 
	, Contents 
	, BranchConfirmYn 
	, UseYn 
	, CreateDate 
) VALUES ( 
	@AdminID
	, @PublisherID 
	, @Contents
	, 0 
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
-- Create date: 2019-09-10  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 경험담관리 - 경험담수정
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingServiceExperienceUpdate]
	@ExperienceID int 
	, @PublisherID int  
	, @Contents nvarchar(max)
AS

SET NOCOUNT ON;

UPDATE e SET 
	e.PublisherID=@PublisherID 
	, e.Contents =@Contents 
    , e.UpdateDate=GETDATE()  
FROM dbo.Experiences e
WHERE e.ExperienceID=@ExperienceID

SELECT @@ROWCOUNT





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-10   
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 경험담관리 - 경험담승인 
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingServiceExperienceBranchConfirm]
	@ExperienceID int 
	, @BranchConfirmYn bit  
AS

SET NOCOUNT ON;

UPDATE e SET e.BranchConfirmYn=@BranchConfirmYn, e.UpdateDate=GETDATE()  
FROM dbo.Experiences e
WHERE e.ExperienceID=@ExperienceID

SELECT @@ROWCOUNT




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-10   
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 경험담관리 - 경험담삭제
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingServiceExperienceDelete]
	@ExperienceID int 
	, @UseYn bit  
AS

SET NOCOUNT ON;

UPDATE e SET e.UseYn=@UseYn, e.UpdateDate=GETDATE()  
FROM dbo.Experiences e
WHERE e.ExperienceID=@ExperienceID

SELECT @@ROWCOUNT
