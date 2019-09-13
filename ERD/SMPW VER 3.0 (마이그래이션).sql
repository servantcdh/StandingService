USE StandingSrv
go 

-- ===================
-- ItemCodes 코드등록 
-- ===================

SELECT TOP 100 * FROM ItemCodes

-- SELECT TOP 10 * FROM dbo.Admins 

INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('AdminRoleID','관리자', 1, 1, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('AdminRoleID','지부사무실', 1, 2, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('AdminRoleID','순회감독자', 1, 3, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('AdminRoleID','순회구보조자', 1, 4, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('AdminRoleID','조정장로', 1, 5, GETDATE()) 


SELECT TOP 10 * FROM SMPW.dbo.TB_Code WHERE Ckind = 'SERVANT1'

INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('PioneerTypeID','정규파이오니아', 1, 1, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('PioneerTypeID','특별파이오니아', 1, 2, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('PioneerTypeID','정규파이오니아', 1, 3, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('PioneerTypeID','기타', 1, 4, GETDATE()) 


SELECT TOP 10 * FROM SMPW.dbo.TB_Code WHERE Ckind = 'SERVANT2'

INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ServantTypeID','일반', 1, 1, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ServantTypeID','봉사의종', 1, 2, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ServantTypeID','장로', 1, 3, GETDATE()) 

SELECT TOP 10 * FROM SMPW.dbo.TB_Code WHERE Ckind = 'ENDNOTE'

INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('EndTypeID','자의중단', 1, 1, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('EndTypeID','자격상실', 1, 2, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('EndTypeID','이사', 1, 3, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('EndTypeID','사망', 1, 4, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('EndTypeID','기타', 1, 5, GETDATE()) 

SELECT TOP 10 * FROM SMPW.dbo.TB_Code WHERE Ckind = 'CANCEL'

INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('CancelTypeID','해당없음', 1, 1, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('CancelTypeID','날씨', 1, 2, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('CancelTypeID','인원부족', 1, 3, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('CancelTypeID','구역문제', 1, 4, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('CancelTypeID','기타', 1, 5, GETDATE()) 

SELECT TOP 10 * FROM SMPW.dbo.TB_Code WHERE Ckind = 'PUBKIND'

INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ProductKindID','성경', 1, 1, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ProductKindID','서적', 1, 2, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ProductKindID','잡지', 1, 3, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ProductKindID','팜플렛', 1, 4, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ProductKindID','동영상', 1, 5, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ProductKindID','기타', 1, 5, GETDATE()) 

-- SELECT TOP 10 * FROM SMPW.dbo.TB_Code WHERE Ckind = 'LANGUAGE'

-- INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('LanguageKindID','성경', 1, 1, GETDATE()) 
-- INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('LanguageKindID','성경', 1, 1, GETDATE()) 
-- INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('LanguageKindID','성경', 1, 1, GETDATE()) 


INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('PushKindID','일정등록', 1, 1, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('PushKindID','일정취소', 1, 2, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('PushKindID','지원요청', 1, 3, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('PushKindID','기타', 1, 4, GETDATE()) 

INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ServiceStatusID','정상일정', 1, 1, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ServiceStatusID','일회지원', 1, 2, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ServiceStatusID','불참', 1, 3, GETDATE()) 

INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ServiceStatusID','정상일정', 1, 1, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ServiceStatusID','일회지원', 1, 2, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('ServiceStatusID','불참', 1, 3, GETDATE()) 

INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('MobileTypeID','Android', 1, 1, GETDATE()) 
INSERT INTO dbo.ItemCodes (Separate, Item, UseYn, OrderNum, CreateDate) VALUES ('MobileTypeID','iOS', 1, 2, GETDATE()) 





-- ===================
-- TB_Metro >> Metros 
-- ===================

INSERT INTO dbo.Metros (MetroCode, MetroName, OrderNum, CreateDate) 
SELECT MetCode, MetName, ROW_NUMBER() OVER (ORDER BY OrderNum) AS OrderNum, GETDATE()   
FROM SMPW.dbo.TB_Metro ORDER BY OrderNum 

SELECT * FROM dbo.Metros 

-- TB_Circuit >> Circuits 
INSERT INTO dbo.Circuits (MetroID, CircuitName, Memo, CreateDate) 
SELECT 1, CirCode, '서울지역 임시마이그래이션', GETDATE() 
FROM SMPW.dbo.TB_Circuit WHERE MetCode='SEU'

SELECT * FROM dbo.Circuits 


-- =================================
--  TB_Congregation >> Congregations 
-- =================================
 
SELECT * FROM SMPW.dbo.TB_Congregation WHERE MetCode='SEU'

SELECT CongName, COUNT(*) FROM SMPW.dbo.TB_Congregation WHERE MetCode='SEU'
GROUP BY CongName HAVING COUNT(*)>1





-- ===========================
--  TB_Publication >> Products 
-- ===========================

--SELECT PubCode, COUNT(*) 
--FROM SMPW.dbo.TB_Publication 
--WHERE PubCode NOT IN ('P0299', 'P0399','P0401','P0501','P1001','P2001','P3001')
--GROUP BY PubCode HAVING COUNT(*)>1

--SELECT PubName, COUNT(*) 
--FROM SMPW.dbo.TB_Publication 
--WHERE PubCode NOT IN ('P0299', 'P0399','P0401','P0501','P1001','P2001','P3001')
--GROUP BY PubName HAVING COUNT(*)>1

SELECT * FROM dbo.ItemCodes WHERE Separate='ProductKindID'

SELECT * FROM StandingSrv.dbo.Products 

SELECT * FROM SMPW.dbo.TB_Publication WHERE PubCode IN ('P0299', 'P0399','P0401','P0501','P1001','P2001','P3001')


INSERT INTO StandingSrv.dbo.Products (ProductCode, ProductName, ProductAlias, ProductKindID, Language, UseYn, OrderNum, CreateDate)  
SELECT 'P000', '동영상','동영상',27,'한국어', 1, 1, GETDATE()) 

INSERT INTO StandingSrv.dbo.Products (ProductCode, ProductName, ProductAlias, ProductKindID, Language, UseYn, OrderNum, CreateDate)  
SELECT 
	PubCode
	, PubName
	, PubAlias
	, CASE 
		WHEN PubKind='BIB' THEN 22
	    WHEN PubKind='MAG' THEN 24
	    WHEN PubKind='BOK' THEN 23
	    WHEN PubKind='BRO' THEN 25
      END AS ProductKindID
	, '한국어'
	, 1 
	, OrderNum 
	, GETDATE() 
FROM SMPW.dbo.TB_Publication 
WHERE PubCode NOT IN ('P0299', 'P0399','P0401','P0501','P1001','P2001','P3001')





-- ====================
--  TB_Admin >> Admins 
-- ====================

SELECT * FROM StandingSrv.dbo.ItemCodes WHERE Separate='AdminRoleID'

SELECT TOP 10 * FROM StandingSrv.dbo.Admins

DECLARE @UserPassword nvarchar(100) 
SET @UserPassword='11112222'

INSERT INTO StandingSrv.dbo.Admins (CircuitID, Account, UserPassword, UserName, AdminRoleID, Mobile, UseYn, CreateDate)  
SELECT 
	1
	, 'skkim'
	,  HASHBYTES('SHA2_512', @UserPassword)
	, '김승균'
	, 1
	, '010-9808-5043'
	, 1
	, GETDATE() 
SELECT TOP 10 * FROM StandingSrv.dbo.Admins


-- ===========================
--  TB_Zone >> ServiceZone  
-- ===========================

SELECT * FROM StandingSrv.dbo.ServiceZones

INSERT INTO StandingSrv.dbo.ServiceZones (CircuitID, ZoneName, ZoneAlias, Latitude, Longitude, OrderNum, CreateDate) 
SELECT b.CircuitID, ZoneName, ZoneAlias
	, CASE WHEN Latitude='' THEN NULL ELSE Latitude END AS Latitude
	, CASE WHEN Longitude='' THEN NULL ELSE Longitude END AS Longitude
	, OrderNum 
	, GETDATE() 
FROM SMPW.[dbo].[TB_Zone] a 
	INNER JOIN StandingSrv.[dbo].[Circuits] b 
		ON a.CirCode=b.CircuitName -- 특정지역만 마이그래이션하기 때문에 이 방식이 가능함... 가급적 새로 등록하는 것이 옳아보입니다. 
WHERE MetCode='SEU'
      AND ZoneName<>'.'
  
SELECT * FROM StandingSrv.dbo.ServiceZones


-- ===========================
--  ServiceTime 
-- ===========================

CREATE TABLE #aaa (WD nvarchar(2)) 
	INSERT INTO #aaa (WD) VALUES ('월') 
	INSERT INTO #aaa (WD) VALUES ('화') 
	INSERT INTO #aaa (WD) VALUES ('수') 
	INSERT INTO #aaa (WD) VALUES ('목') 
	INSERT INTO #aaa (WD) VALUES ('금') 
	INSERT INTO #aaa (WD) VALUES ('토') 
	INSERT INTO #aaa (WD) VALUES ('일') 

CREATE TABLE #bbb (TT smallint) 
	INSERT INTO #bbb (TT) VALUES (9) 
	INSERT INTO #bbb (TT) VALUES (10) 
	INSERT INTO #bbb (TT) VALUES (11) 
	INSERT INTO #bbb (TT) VALUES (12) 
	INSERT INTO #bbb (TT) VALUES (13) 
	INSERT INTO #bbb (TT) VALUES (14) 
	INSERT INTO #bbb (TT) VALUES (15) 
	INSERT INTO #bbb (TT) VALUES (16) 
	INSERT INTO #bbb (TT) VALUES (17) 
	INSERT INTO #bbb (TT) VALUES (18) 
	INSERT INTO #bbb (TT) VALUES (19) 
	INSERT INTO #bbb (TT) VALUES (20) 

SELECT * 
INTO #ccc 
FROM #aaa 
	CROSS JOIN #bbb 



SELECT * FROM StandingSrv.dbo.ServiceZones


INSERT INTO StandingSrv.dbo.ServiceTimes SELECT 1, WD, TT, GETDATE() FROM #ccc 
INSERT INTO StandingSrv.dbo.ServiceTimes SELECT 2, WD, TT, GETDATE() FROM #ccc 
INSERT INTO StandingSrv.dbo.ServiceTimes SELECT 3, WD, TT, GETDATE() FROM #ccc 

SELECT * FROM StandingSrv.dbo.ServiceTimes  




-- =====================================
--  TB_Congregation >> Congregations  
-- =====================================

SELECT * FROM StandingSrv.dbo.Congregations 

INSERT INTO StandingSrv.dbo.Congregations (CircuitID, CongregationName, CongregationAlias, CreateDate) 
SELECT t.CircuitID, c.CongName, c.CongName, GETDATE()
FROM SMPW.dbo.TB_Congregation c 
	INNER JOIN StandingSrv.dbo.Circuits t 
		ON c.CirCode=t.CircuitName   
WHERE MetCode='SEU' AND CirCode LIKE '지역%' AND CongName<>'지원' 
ORDER BY c.CongName


SELECT * FROM StandingSrv.dbo.Congregations 



-- =====================================
--  TB_Congregation >> Congregations  
-- =====================================

SELECT TOP 10 * FROM StandingSrv.dbo.Publishers

SELECT TOP 10 * FROM SMPW.dbo.TB_UserPioneer

SELECT TOP 10 * FROM StandingSrv.dbo.ItemCodes WHERE Separate='PioneerTypeID'
SELECT TOP 10 * FROM StandingSrv.dbo.ItemCodes WHERE Separate='ServantTypeID'
SELECT TOP 10 * FROM StandingSrv.dbo.ItemCodes WHERE Separate='MobileOsKindID'


SET ANSI_WARNINGS OFF

DECLARE @UserPassword2 nvarchar(50)
SET @UserPassword2='11112222'

INSERT INTO StandingSrv.dbo.Publishers (
	CongregationID
	, Account
	, UserPassword
	, UserName
	, Gender
	, PioneerTypeID
	, ServantTypeID
	, Mobile
	, MobileOsKindID
	, SupportYn
	, LeaderYn 
	, UseYn
	, CreateDate 
) VALUES ( 
	1
	, 'skkim'
	, HASHBYTES('SHA2_512', @UserPassword2)
	, '김승균'
	, 'M'
	, 5
	, 11
	, '010-9808-5043'
	, 38
	, 1
	, 1 
	, 1
	, GETDATE()  
) 

SET ANSI_WARNINGS ON 

SELECT TOP 10 * FROM StandingSrv.dbo.Publishers










