USE [StandingSrv]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		��±� 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	��Ư�� �����ڵ� ��Ӵٿ� 
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingItemCodeList]
	@Separate nvarchar(100) 
	, @SelectedID int
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	i.ID
	, i.Separate
	, i.Item 
FROM dbo.ItemCodes i   
WHERE i.UseYn=1 
   	  AND i.Separate=@Separate
	  AND i.ID=CASE WHEN @SelectedID IS NULL THEN i.ID ELSE @SelectedID END  
ORDER BY i.OrderNum 




-- =============================================
-- Author:		��±� 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	��Ư�� ��ܰ˻� - ���ø���Ʈ 
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingSearchMetroList]
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	m.MetroID
	, m.MetroName 
FROM dbo.Metros m   
ORDER BY m.OrderNum 

GO




-- =============================================
-- Author:		��±� 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	��Ư�� ��ܰ˻� - ����(��ȸ��)����Ʈ 
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingSearchCircuitList]
	@MetroID int 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	c.CircuitID
	, c.CircuitName 
FROM dbo.Circuits c
WHERE c.MetroID=@MetroID    
ORDER BY c.CircuitName

GO





-- =============================================
-- Author:		��±� 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	��Ư�� ��ܰ˻� - ȸ�߸���Ʈ 
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingSearchCongregationList]
	@CircuitID int 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	g.CongregationID
	, g.CongregationName 
FROM dbo.Congregations g
WHERE g.CircuitID=@CircuitID    
ORDER BY g.CongregationName

GO
