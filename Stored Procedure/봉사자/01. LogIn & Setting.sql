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
-- Description:	대특공 봉사자 - 봉사자 로그인 
-- =============================================

CREATE PROCEDURE [dbo].[uspGetPublisherLogIn]
	@Account nvarchar(100)
	, @UserPassword nvarchar(100) 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT TOP 1 
	a.PublisherID 
	, a.PublisherName
	, a.CongregationID
	, a.PioneerTypeID
	, a.ServantTypeID
	, a.Mobile 
	, a.TempPassYn 
FROM dbo.Publishers a 
WHERE a.UseYn=1 
   		AND a.Account=@Account
		AND a.UserPassword=HASHBYTES('SHA2_512', @UserPassword) 

GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사자 - 비밀번호 초기화정보 확인  
-- =============================================

CREATE PROCEDURE [dbo].[uspGetPublisherLogInMobileConfirm]
	@Account nvarchar(100)
	, @Mobile varchar(15) 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT TOP 1 
	a.PublisherID 
	, a.Account 
	, a.Mobile 
FROM dbo.Publishers a 
WHERE a.UseYn=1 
   		AND a.Account=@Account
		AND a.UserPassword=@Mobile 

GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사자 - 비밀번호초기화 
-- =============================================

CREATE PROCEDURE [dbo].[uspSetPublisherPasswordReset]
	@PublisherID int 
	, @NewPassword nvarchar(100)  
AS

SET NOCOUNT ON;


UPDATE a SET 
	a.UserPassword=HASHBYTES('SHA2_512', @NewPassword)
	, a.TempPassYn=1 
FROM dbo.Publishers a 
WHERE a.PublisherID=@PublisherID

SELECT @@ROWCOUNT
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사자 - 비밀번호변경
-- =============================================

CREATE PROCEDURE [dbo].[uspSetPublisherPasswordUpdate]
	@PublisherID int 
	, @NewPassword nvarchar(100)  
AS

SET NOCOUNT ON;


UPDATE a SET 
	a.UserPassword=HASHBYTES('SHA2_512', @NewPassword)
FROM dbo.Publishers a 
WHERE a.PublisherID=@PublisherID

SELECT @@ROWCOUNT
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사자 - 사용언어변경
-- =============================================

CREATE PROCEDURE [dbo].[uspSetPublisherLanguageUpdate]
	@PublisherID int 
	, @UseLanguage nvarchar(30)  
AS

SET NOCOUNT ON;


UPDATE a SET 
	a.UseLanguage=@UseLanguage
FROM dbo.Publishers a 
WHERE a.PublisherID=@PublisherID

SELECT @@ROWCOUNT
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사자 - 개인정보변경
-- =============================================

CREATE PROCEDURE [dbo].[uspSetPublisherLanguageUpdate]
	@PublisherID int 
	, @CongregationID int  
	, @Mobile varchar(15)  
AS

SET NOCOUNT ON;


UPDATE a SET 
	a.CongregationID=@CongregationID
	, a.Mobile=@Mobile
FROM dbo.Publishers a 
WHERE a.PublisherID=@PublisherID

SELECT @@ROWCOUNT





-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사자 - 내사진보기
-- =============================================

CREATE PROCEDURE [dbo].[uspGetPublisherMyPhoto]
	@PublisherID int 
AS

SET NOCOUNT ON;


SELECT a.PublisherID, a.PhotoFilePath
FROM dbo.Publishers a 
WHERE a.PublisherID=@PublisherID

GO


-- =============================================
-- Author:		김승균 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 봉사자 - 사진업데이트
-- =============================================

CREATE PROCEDURE [dbo].[uspSetPublisherMyPhotoUpdate]
	@PublisherID int 
	, @PhotoFilePath nvarchar(300)  
AS

SET NOCOUNT ON;


UPDATE a SET 
	a.PhotoFilePath=@PhotoFilePath
FROM dbo.Publishers a 
WHERE a.PublisherID=@PublisherID

SELECT @@ROWCOUNT
GO

