USE [StandingSrv]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		±è½Â±Õ 
-- Create date: 2019-08-18  
-- Email:		bonoman77@gmail.com  
-- Description:	´ëÆ¯°ø °ø¿ëÄÚµå µå·Ó´Ù¿î 
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