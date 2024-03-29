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
-- Description:	대특공 출판물관리 - 출판물재고리스트
-- =============================================

CREATE PROCEDURE [dbo].[uspGetStandingProductStockList]
	@PageSize int = 30, 
	@PageNumber int = 1, 
	@MetroID int, 
	@CircuitID int, 
	@ProductID int, 
	@StartDate smalldatetime, 
	@EndDate smalldatetime 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT 
	s.CircuitID
	, c.CircuitName 
	, i.Item AS ProductKind 
	, p.ProductAlias
	, p.ProductName 
	, s.StockCnt 
	, o.ReceiptDate
FROM (
	SELECT 
		s.CircuitID, s.ProductID, SUM(StockCnt) AS StockCnt 
	FROM dbo.ProductStocks s 
	GROUP BY s.CircuitID, s.ProductID  
	) s 
	INNER JOIN dbo.Circuits c 
		ON s.CircuitID=c.CircuitID
	INNER JOIN dbo.Metros m 
		ON c.MetroID=m.MetroID
	INNER JOIN dbo.Products p 
		ON s.ProductID=p.ProductID 
	INNER JOIN dbo.ItemCodes i 
		ON p.ProductKindID=i.ID 
	LEFT JOIN (
		SELECT CircuitID, ProductID, MAX(ReceiptDate) AS ReceiptDate 
		FROM dbo.ProductOrders 
		GROUP BY CircuitID, ProductID 
	) o ON s.CircuitID=o.CircuitID AND s.ProductID=o.ProductID	
WHERE	
	m.MetroID = CASE WHEN @MetroID IS NULL THEN m.MetroID ELSE @MetroID END 
	AND c.CircuitID = CASE WHEN @CircuitID IS NULL THEN c.CircuitID ELSE @CircuitID END 
	AND p.ProductID = CASE WHEN @ProductID IS NULL THEN p.ProductID ELSE @ProductID  END 
ORDER BY o.ReceiptDate DESC 
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
-- Description:	대특공 출판물관리 - 출판물주문리스트
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingProductOrderList]
	@PageSize int = 30, 
	@PageNumber int = 1, 
	@MetroID int, 
	@CircuitID int, 
	@ProductID int, 
	@StartDate smalldatetime, 
	@EndDate smalldatetime 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 


SELECT 
	o.ProductOrderID
	, c.MetroID
	, m.MetroName
	, c.CircuitID
	, c.CircuitName
	, o.AdminID
	, a.AdminName 
	, a.Mobile 
	, o.ProductID
	, i.Item AS ProductKind 
	, p.ProductAlias
	, p.ProductName
	, o.OrderCnt
	, o.ReceiptDate
	, o.InvoiceCode
FROM dbo.ProductOrders o 
	INNER JOIN dbo.Circuits c 
		ON o.CircuitID=c.CircuitID
	INNER JOIN dbo.Metros m 
		ON c.MetroID=m.MetroID 
	INNER JOIN dbo.Admins a  
		ON o.AdminID=a.AdminID 
	INNER JOIN dbo.Products p   
		ON o.ProductID=p.ProductID 
 	INNER JOIN dbo.ItemCodes i 
		ON p.ProductKindID=i.ID 
WHERE	
	m.MetroID = CASE WHEN @MetroID IS NULL THEN m.MetroID ELSE @MetroID END 
	AND c.CircuitID = CASE WHEN @CircuitID IS NULL THEN c.CircuitID ELSE @CircuitID END 
	AND p.ProductID = CASE WHEN @ProductID IS NULL THEN p.ProductID ELSE @ProductID END 
ORDER BY o.ProductOrderID DESC 
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
-- Description:	대특공 출판물관리리 - 출판물 주문을 위한 관리자(순회감독자) 정보 
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingProductOrderAdminInfo]
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



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-10  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 출판물관리리 - 출판물 주문을 위한 제품재고리스트 
-- =============================================

ALTER PROCEDURE [dbo].[uspGetStandingProductOrderStockList]
	@CircuitID int 
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

SELECT s.ProductID, p.ProductName, COUNT(s.StockCnt) 
FROM dbo.ProductStocks s
	INNER JOIN dbo.Products p 
		ON s.ProductID=p.ProductID 
WHERE s.CircuitID=@CircuitID
GROUP BY s.ProductID, p.ProductName 
ORDER BY p.ProductName 



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-10  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 출판물관리 - 출판물주문등록
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingProductOrderInsert]
	@CircuitID int 
	, @AdminID int 
	, @ProductID int 
	, @OrderCnt int 
	, @ReceiptDate smalldatetime 
AS

SET NOCOUNT ON;

INSERT INTO dbo.ProductOrders (
	CircuitID 
	, AdminID 
	, ProductID 
	, OrderCnt  
	, ReceiptDate  
	, CreateDate 
) VALUES (
	@CircuitID  
	, @AdminID
	, @ProductID 
	, @OrderCnt 
	, @ReceiptDate
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
-- Description:	대특공 출판물관리 - 출판물주문업데이트
-- =============================================

ALTER PROCEDURE [dbo].[uspSetStandingProductOrderUpdate]
	@ProductOrderID int 
	, @OrderCnt int 
	, @ReceiptDate smalldatetime 
AS

SET NOCOUNT ON;

UPDATE o SET 
	o.OrderCnt=@OrderCnt 
    , o.UpdateDate=GETDATE()  
FROM dbo.ProductOrders o 
WHERE o.ProductOrderID=@ProductOrderID

SELECT @@ROWCOUNT
	 




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-10  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 출판물관리 - 출판물주문삭제 
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingProductOrderDelete]
	@ProductOrderID int 
AS

SET NOCOUNT ON;

DELETE FROM dbo.ProductOrders WHERE ProductOrderID=@ProductOrderID


	 
	 
	 
	 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		김승균 
-- Create date: 2019-09-10  
-- Email:		bonoman77@gmail.com  
-- Description:	대특공 출판물관리 - 출판물주문송장등록
-- =============================================

CREATE PROCEDURE [dbo].[uspSetStandingProductOrderInvoiceUpdate]
	@ProductOrderID int 
	, @InvoiceCode varchar(100) 
AS

SET NOCOUNT ON;

UPDATE o SET 
	o.InvoiceCode=@InvoiceCode 
    , o.UpdateDate=GETDATE()  
FROM dbo.ProductOrders o 
WHERE o.ProductOrderID=@ProductOrderID

	 
	 
	  	  