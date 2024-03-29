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
-- Description:	대특공 메시지함 - 받은메시지리스트
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingLetterReceiveList]
	@PageSize int = 30, 
	@PageNumber int = 1, 
	@AdminID int, 
	@ReceiveAdminID int, 
	@StartDate smalldatetime, 
	@EndDate smalldatetime, 
	@ReadYn bit 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	e.AdminID
	, a.AdminName 
	, e.ReceiveAdminID
	, r.AdminName AS ReceiveAdminName 
	, e.Title 
	, e.ReceiveDate
	, e.ReadYn 
	, CONVERT(char(10), e.CreateDate, 121) AS CreateDate  
FROM dbo.Letters e  
	INNER JOIN dbo.Admins a 
		ON e.AdminID=a.AdminID   
	INNER JOIN dbo.Admins r  
		ON e.ReceiveAdminID=r.AdminID   
WHERE 
	e.AdminID = CASE WHEN @AdminID IS NULL THEN e.AdminID ELSE @AdminID END 
	AND e.ReceiveAdminID = CASE WHEN @ReceiveAdminID IS NULL THEN e.ReceiveAdminID ELSE @ReceiveAdminID END 
	AND e.ReadYn = CASE WHEN @ReadYn IS NULL THEN e.ReadYn ELSE @ReadYn END 
ORDER BY e.LetterID DESC 
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
-- Description:	대특공 메시지함 - 보낸메시지리스트
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingLetterSendList]
	@PageSize int = 30, 
	@PageNumber int = 1, 
	@AdminID int, 
	@ReceiveAdminID int, 
	@StartDate smalldatetime, 
	@EndDate smalldatetime, 
	@ReadYn bit 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	e.AdminID
	, a.AdminName 
	, e.ReceiveAdminID
	, r.AdminName AS ReceiveAdminName 
	, e.Title 
	, e.ReceiveDate
	, e.ReadYn 
	, CONVERT(char(10), e.CreateDate, 121) AS CreateDate  
FROM dbo.Letters e  
	INNER JOIN dbo.Admins a 
		ON e.AdminID=a.AdminID   
	INNER JOIN dbo.Admins r  
		ON e.ReceiveAdminID=r.AdminID   
WHERE 
	e.AdminID = CASE WHEN @AdminID IS NULL THEN e.AdminID ELSE @AdminID END 
	AND e.ReceiveAdminID = CASE WHEN @ReceiveAdminID IS NULL THEN e.ReceiveAdminID ELSE @ReceiveAdminID END 
	AND e.ReadYn = CASE WHEN @ReadYn IS NULL THEN e.ReadYn ELSE @ReadYn END 
ORDER BY e.LetterID DESC 
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
-- Description:	대특공 메시지함 - 메시지상세
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingLetterDetail]
	@LetterID int 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	e.AdminID
	, a.AdminName 
	, e.ReceiveAdminID
	, r.AdminName AS ReceiveAdminName 
	, e.Title 
	, e.Contents 
	, e.ReceiveDate
	, e.ReadYn 
	, CONVERT(char(10), e.CreateDate, 121) AS CreateDate  
FROM dbo.Letters e  
	INNER JOIN dbo.Admins a 
		ON e.AdminID=a.AdminID   
	INNER JOIN dbo.Admins r  
		ON e.ReceiveAdminID=r.AdminID   
WHERE e.LetterID=@LetterID 





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 메시지함 - 메시지등록
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingLetterInsert]
	@AdminID int 
	, @Title nvarchar(500) 
	, @Contents nvarchar(max) 
	, @ReceiveAdminID int 
AS

SET NOCOUNT ON;

INSERT INTO dbo.Letters (
	AdminID 
	, Title
	, Contents
	, ReceiveAdminID
	, CreateDate    
) VALUES ( 
	@AdminID
	, @Title
	, @Contents
	, @ReceiveAdminID 
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
-- Description:	대특공 메시지함 - 메시지 수신여부 업데이트 
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingLetterReadUpdate]
	@LetterID int 
AS

SET NOCOUNT ON;

UPDATE e SET e.ReadYn=1 FROM dbo.Letters e WHERE e.LetterID=@LetterID 







SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 메시지함 - 메시지 파일보기
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingLetterFile]
	@LetterID int 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT f.LetterFileID, f.FilePath FROM dbo.LetterFiles f WHERE f.LetterID=@LetterID ORDER BY f.LetterFileID  





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 메시지함 - 메시지 파일등록
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingLetterFileInsert]
	@LetterID int 
	, @FilePath nvarchar(500) 
AS

SET NOCOUNT ON;

INSERT INTO dbo.LetterFiles (LetterID, FilePath) VALUES (@LetterID, @FilePath) 

SELECT @@ROWCOUNT




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 메시지함 - 메시지 파일삭제
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingLetterFileDelete]
	@LetterFileID int 
AS

SET NOCOUNT ON;

DELETE FROM dbo.LetterFiles WHERE LetterFileID=@LetterFileID 



