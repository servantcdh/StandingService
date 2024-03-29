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
-- Description:	대특공 사용자(관리자)관리 - 사용자리스트 >>>>>>>> 기획안이 바뀌어야 함 (Publisher와 연동 끊음) 
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingAdminList]
	@PageSize int = 30, 
	@PageNumber int = 1, 
	@MetroID int, 
	@CircuitID int, 
	@CongregationID int, 
	@AdminName nvarchar(100), 
	@Gender char(1) 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	a.AdminID 
	, m.MetroID
	, m.MetroName 
	, a.AdminName
	, a.Mobile 
	, a.AdminRoleID
	, i.Item AS AdminRole 
	, a.CreateDate 
FROM dbo.Admins a 
	LEFT JOIN dbo.Metros m 
		ON a.MetroID=m.MetroID 
	INNER JOIN dbo.ItemCodes i   
		ON a.AdminRoleID=i.ID
WHERE 
	a.UseYn=1 
	AND m.MetroID = CASE WHEN @MetroID IS NULL THEN m.MetroID ELSE @MetroID END 
	AND a.AdminName = CASE WHEN @AdminName IS NULL THEN a.AdminName ELSE @AdminName END 
ORDER BY a.AdminID DESC 
OFFSET (@PageNumber-1)*@PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY




--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
---- =============================================
---- Author:		김승균 
---- Create date: 2019-08-18  
---- Email:		bonoman77@gmail.com  
---- Description:	대특공 사용자(관리자)관리 - 사용자등록 (이름조회) 
---- =============================================

--ALTER PROCEDURE [dbo].[uspGetStandingAdminPublisherSearch]
--	@PublisherName nvarchar(100)
--AS

--SET NOCOUNT ON;
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

--SELECT 
--	p.PublisherID
--	, p.PublisherName 
--	, m.MetroID
--	, m.MetroName 
--	, c.CircuitID
--	, c.CircuitName 
--	, g.CongregationID
--	, g.CongregationName 
--	, p.ServantTypeID 
--	, i2.Item AS ServantType 
--	, p.Mobile 
--	, p.CreateDate 
--FROM dbo.Publishers p  
--	INNER JOIN dbo.Congregations g 
--		ON p.CongregationID=g.CongregationID 
--	INNER JOIN dbo.Circuits c 
--		ON g.CircuitID=c.CircuitID
--	INNER JOIN dbo.Metros m 
--		ON c.MetroID=m.MetroID 
--	INNER JOIN dbo.ItemCodes i2   
--		ON p.ServantTypeID=i2.ID
--WHERE p.UseYn=1 
--   	  AND p.PublisherName LIKE @PublisherName+'%'




--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
---- =============================================
---- Author:		김승균 
---- Create date: 2019-08-18  
---- Email:		bonoman77@gmail.com  
---- Description:	대특공 사용자(관리자)관리 - 사용자등록 (관리자선택) 
---- =============================================

--ALTER PROCEDURE [dbo].[uspGetStandingAdminPublisherSelect]
--	@PublisherID nvarchar(100)
--AS

--SET NOCOUNT ON;
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

--SELECT 
--	p.PublisherID
--	, p.PublisherName 
--	, m.MetroID
--	, m.MetroName 
--	, c.CircuitID
--	, c.CircuitName 
--	, g.CongregationID
--	, g.CongregationName 
--	, p.ServantTypeID 
--	, i2.Item AS ServantType 
--	, p.Mobile 
--	, p.CreateDate 
--FROM dbo.Publishers p  
--	INNER JOIN dbo.Congregations g 
--		ON p.CongregationID=g.CongregationID 
--	INNER JOIN dbo.Circuits c 
--		ON g.CircuitID=c.CircuitID
--	INNER JOIN dbo.Metros m 
--		ON c.MetroID=m.MetroID 
--	INNER JOIN dbo.ItemCodes i2   
--		ON p.ServantTypeID=i2.ID
--WHERE p.UseYn=1 
--   	  AND p.PublisherID=@PublisherID 
	 





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 사용자(관리자)관리 - 사용자등록
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingAdminInsert]
	@Account nvarchar(100)
	, @UserPassword nvarchar(100)
	, @AdminName nvarchar(50) 
	, @AdminRoleID int 
	, @TempUseYn bit
	, @Mobile varchar(13) 
AS

SET NOCOUNT ON;

INSERT INTO dbo.Admins (
	AdminName 
	, Account
	, UserPassword
	, AdminRoleID
	, TempPassYn 
	, Mobile 
	, UseYn 
	, CreateDate
) VALUES ( 
	@AdminName 
	, @Account 
	, HASHBYTES('SHA2_512', @UserPassword)  
	, @AdminRoleID  
	, @TempUseYn
	, @Mobile 
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
-- Description:	대특공 사용자(관리자)관리 - 사용자수정
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingAdminUpdate]
	@AdminID int 
	, @UserPassword nvarchar(100)
	, @AdminRoleID int 
	, @TempPassYn bit
	, @Mobile varchar(13) 
AS

SET NOCOUNT ON;

UPDATE a SET 
	a.UserPassword=HASHBYTES('SHA2_512', @UserPassword)  
	, a.AdminRoleID=@AdminRoleID
	, a.TempPassYn=@TempPassYn
	, a.Mobile=@Mobile 
FROM dbo.Admins a 
WHERE a.AdminID=@AdminID 

SELECT @@ROWCOUNT



  

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 사용자(관리자)관리 - 사용자삭제
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingAdminDelete]
	@AdminID int 
	, @UseYn bit  
AS

SET NOCOUNT ON;

UPDATE a SET a.UseYn=@UseYn, a.UpdateDate=GETDATE() FROM dbo.Admins a WHERE a.AdminID=@AdminID 

SELECT @@ROWCOUNT
