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
-- Description:	대특공 공지사항 - 공지사항리스트
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingNoticeList]
	@PageSize int = 30, 
	@PageNumber int = 1, 
	@MetroID int, 
	@CircuitID int, 
	@ReceiveGroupID int, 
	@AdminID int
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	m.MetroID
	, ISNULL(m.MetroName, '전체') AS MetroName  
	, c.CircuitID
	, ISNULL(c.CircuitName, '전체') AS CircuitName  
	, s.Item AS ReceiveGroup
	, n.Title
	, a.AdminName
	, n.ReadCnt
	, CONVERT(char(10), n.CreateDate, 121) AS CreateDate  
FROM dbo.Notices n  
	INNER JOIN dbo.Admins a   
		ON n.AdminID=a.AdminID
	INNER JOIN dbo.ItemCodes s   
		ON n.ReceiveGroupID=S.ID
	LEFT JOIN dbo.Circuits c 
		ON n.CircuitID=c.CircuitID
	LEFT JOIN dbo.Metros m 
		ON n.MetroID=m.MetroID 
WHERE 
	n.DeleteDate IS NULL  
	AND m.MetroID = CASE WHEN @MetroID IS NULL THEN m.MetroID ELSE @MetroID END 
	AND c.CircuitID = CASE WHEN @CircuitID IS NULL THEN c.CircuitID ELSE @CircuitID END 
	AND n.ReceiveGroupID = CASE WHEN @ReceiveGroupID IS NULL THEN n.ReceiveGroupID ELSE @ReceiveGroupID END 
ORDER BY n.NoticeID DESC 
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
-- Description:	대특공 공지사항 - 공지사항상세
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingNoticeDetail]
	@NoticeID int 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	m.MetroID
	, ISNULL(m.MetroName, '전체') AS MetroName  
	, c.CircuitID
	, ISNULL(c.CircuitName, '전체') AS CircuitName  
	, n.ReceiveGroupID
	, s.Item AS ReceiveGroup
	, n.Title
	, n.Contents
	, n.DisplayYn 
	, a.AdminID
	, n.ReadCnt
	, CONVERT(char(10), n.CreateDate, 121) AS CreateDate  
FROM dbo.Notices n  
	INNER JOIN dbo.Admins a   
		ON n.AdminID=a.AdminID
	INNER JOIN dbo.ItemCodes s   
		ON n.ReceiveGroupID=S.ID
	LEFT JOIN dbo.Circuits c 
		ON n.CircuitID=c.CircuitID
	LEFT JOIN dbo.Metros m 
		ON n.MetroID=m.MetroID 
WHERE n.NoticeID=@NoticeID 





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 공지사항 - 공지사항등록
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingNoticeInsert]
	@MetroID int 
	, @CircuitID int
	, @ReceiveGroupID int
	, @Title nvarchar(500) 
	, @Contents nvarchar(max)
	, @DisplayYn bit 
	, @AdminID int 
	, @ReadCnt int 
AS

SET NOCOUNT ON;

INSERT INTO dbo.Notices (
	MetroID
	, CircuitID
	, ReceiveGroupID
	, Title
	, Contents
	, DisplayYn 
	, AdminID
	, ReadCnt
	, CreateDate    
) VALUES ( 
	@MetroID
	, @CircuitID
	, @ReceiveGroupID
	, @Title
	, @Contents
	, @DisplayYn 
	, @AdminID
	, @ReadCnt
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
-- Description:	대특공 공지사항 - 공지사항수정
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingNoticeUpdate]
	@NoticeID int 
	, @MetroID int 
	, @CircuitID int
	, @ReceiveGroupID int
	, @Title nvarchar(500) 
	, @Contents nvarchar(max)
	, @DisplayYn bit 
	, @AdminID int 
	, @ReadCnt int 
AS

SET NOCOUNT ON;

UPDATE n SET 
	n.MetroID=@NoticeID
	, n.CircuitID=@CircuitID 
	, n.ReceiveGroupID=@ReceiveGroupID
	, n.Title=@Title
	, n.Contents=@Contents
	, n.DisplayYn=@DisplayYn
	, n.AdminID=@AdminID
	, n.ReadCnt=@ReadCnt
    , n.UpdateDate=GETDATE()  
FROM dbo.Notices n 
WHERE n.NoticeID=@NoticeID 

SELECT @@ROWCOUNT



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 공지사항 - 공지사항삭제
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingNoticeDelete]
	@NoticeID int 
AS

SET NOCOUNT ON;

UPDATE n SET n.DeleteDate=GETDATE() FROM dbo.Notices n WHERE n.NoticeID=@NoticeID 




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 공지사항 - 공지사항 읽기수 업데이트 
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingNoticeReadCnt]
	@NoticeID int 
AS

SET NOCOUNT ON;

UPDATE n SET n.ReadCnt=n.ReadCnt+1 FROM dbo.Notices n WHERE n.NoticeID=@NoticeID 







SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 공지사항 - 공지사항파일보기
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingNoticeFile]
	@NoticeID int 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT f.NoticeFileID, f.FilePath FROM dbo.NoticeFiles f WHERE f.NoticeID=@NoticeID ORDER BY f.NoticeFileID  





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 공지사항 - 공지사항 파일등록
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingNoticeFileInsert]
	@NoticeID int 
	, @FilePath nvarchar(500) 
AS

SET NOCOUNT ON;

INSERT INTO dbo.NoticeFiles (NoticeID, FilePath) VALUES (@NoticeID, @FilePath) 

SELECT @@ROWCOUNT




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 공지사항 - 공지사항파일삭제
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingNoticeFileDelete]
	@NoticeFileID int 
AS

SET NOCOUNT ON;

DELETE FROM dbo.NoticeFiles WHERE NoticeFileID=@NoticeFileID 

