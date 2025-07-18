-- 1) Top 100 ADDRESS
SELECT TOP 100 *
FROM dbo.ADDRESS;

-- 2) Insert new CITY
INSERT INTO dbo.CITIES (ID, COUNTRYID, CITY)
VALUES (999, 90, 'Ankara');

-- 3) Update USER ID 10
UPDATE dbo.USERS
SET
    NAMESURNAME = 'HANDE SAYAR',
    USERNAME_ = 'HNDSYR',
    EMAIL = 'HHSAYAR@GMAÝL.COM',
    PASSWORD_ = '123.ABC'
WHERE ID = 10;

-- 4) SALEORDERS for 'SEKERLEME' & 'ULKER' brand
SELECT s.*
FROM dbo.SALEORDERS AS s
JOIN dbo.ITEMS AS i
    ON s.ITEMCODE = i.ID
WHERE i.CATEGORY1 = 'SEKERLEME'
AND i.BRAND = 'ULKER';

-- 5) SALEORDERS LINETOTAL > 20000 for 'ULKER'
SELECT s.*
FROM dbo.SALEORDERS AS s
JOIN dbo.ITEMS AS i
    ON s.ITEMCODE = i.ID
WHERE s.LINETOTAL > 20000
AND i.BRAND = 'ULKER'; -- Added brand filter

-- 6) SALEORDERS weekdays for 'ULKER'
SELECT s.*
FROM dbo.SALEORDERS AS s
JOIN dbo.ITEMS AS i
    ON s.ITEMCODE = i.ID
WHERE DATENAME(dw, ORDERDATE) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Pazartesi', 'Salý', 'Çarþamba', 'Perþembe', 'Cuma')
AND i.BRAND = 'ULKER'; -- Added brand filter

-- 7) Sunday sales for 'ULKER' brand
SELECT s.*
FROM dbo.SALEORDERS AS s
JOIN dbo.ITEMS AS i
    ON s.ITEMCODE = i.ID
WHERE DATENAME(dw, s.ORDERDATE) IN ('Sunday', 'Pazar')
AND i.BRAND = 'ULKER';

-- 8) Count unique CATEGORY1 in 'ULKER' ITEMS
SELECT COUNT(DISTINCT CATEGORY1) AS UniqueCategory1Count
FROM dbo.ITEMS
WHERE BRAND = 'ULKER'; -- Added brand filter

-- 9) Order 'ULKER' ITEMS by UNITPRICE DESC
SELECT *
FROM dbo.ITEMS
WHERE BRAND = 'ULKER' -- Added brand filter
ORDER BY UNITPRICE DESC;

-- 10) City sales (SUM,COUNT,MIN,MAX,AVG) for 'ULKER' brand
SELECT
    c.CITY,
    SUM(s.LINETOTAL) AS TotalSales,
    COUNT(s.LINETOTAL) AS OrderCount,
    MIN(s.LINETOTAL) AS MinSale,
    MAX(s.LINETOTAL) AS MaxSale,
    AVG(s.LINETOTAL) AS AverageSale
FROM dbo.SALEORDERS AS s
JOIN dbo.ADDRESS AS a
    ON s.ADDRESSTEXT = a.ADDRESSTEXT
JOIN dbo.CITIES AS c
    ON a.CITYID = c.ID
JOIN dbo.ITEMS AS i
    ON s.ITEMCODE = i.ID
WHERE i.BRAND = 'ULKER'
GROUP BY c.CITY
ORDER BY c.CITY;

-- 11) Total sales by categories for 'ULKER'
SELECT
    i.CATEGORY1,
    SUM(s.LINETOTAL) AS TotalCategorySales
FROM dbo.SALEORDERS AS s
JOIN dbo.ITEMS AS i
    ON s.ITEMCODE = i.ID
WHERE i.BRAND = 'ULKER' -- Added brand filter
GROUP BY i.CATEGORY1
ORDER BY i.CATEGORY1;

-- 12) ORDER & USER joins (INNER) for 'ULKER'
SELECT s.*, u.*
FROM dbo.SALEORDERS AS s
INNER JOIN dbo.USERS AS u
    ON s.USERNAME_ = u.USERNAME_
JOIN dbo.ITEMS AS i
    ON s.ITEMCODE = i.ID
WHERE i.BRAND = 'ULKER'; -- Added brand filter

-- 12) ORDER & USER joins (LEFT) for 'ULKER'
SELECT s.*, u.*
FROM dbo.SALEORDERS AS s
LEFT JOIN dbo.USERS AS u
    ON s.USERNAME_ = u.USERNAME_
JOIN dbo.ITEMS AS i
    ON s.ITEMCODE = i.ID
WHERE i.BRAND = 'ULKER'; -- Added brand filter

-- 12) ORDER & USER joins (RIGHT) for 'ULKER'
SELECT s.*, u.*
FROM dbo.SALEORDERS AS s
RIGHT JOIN dbo.USERS AS u
    ON s.USERNAME_ = u.USERNAME_
JOIN dbo.ITEMS AS i
    ON s.ITEMCODE = i.ID
WHERE i.BRAND = 'ULKER'; -- Added brand filter

-- 13) ADDRESS & USER joins (general)
SELECT a.*, u.*
FROM dbo.ADDRESS AS a
INNER JOIN dbo.USERS AS u
    ON a.USERID = u.ID;

-- 13) ADDRESS & USER joins (LEFT) (general)
SELECT a.*, u.*
FROM dbo.ADDRESS AS a
LEFT JOIN dbo.USERS AS u
    ON a.USERID = u.ID;

-- 13) ADDRESS & USER joins (RIGHT) (general)
SELECT a.*, u.*
FROM dbo.ADDRESS AS a
RIGHT JOIN dbo.USERS AS u
    ON a.USERID = u.ID;

-- 14) Top sales brand (overall)
SELECT TOP 1
    i.BRAND,
    SUM(s.LINETOTAL) AS TotalSales
FROM dbo.SALEORDERS AS s
JOIN dbo.ITEMS AS i
    ON s.ITEMCODE = i.ID
GROUP BY i.BRAND
ORDER BY TotalSales DESC;

-- 15) Top-selling item in 'ATIÞTIRMALIK' for 'ULKER'
SELECT TOP 1
    i.ITEMNAME,
    SUM(s.LINETOTAL) AS TotalSales
FROM dbo.SALEORDERS AS s
JOIN dbo.ITEMS AS i
    ON s.ITEMCODE = i.ID
WHERE i.CATEGORY1 = 'ATIÞTIRMALIK'
AND i.BRAND = 'ULKER'
GROUP BY i.ITEMNAME
ORDER BY TotalSales DESC;

-- 16) Avg price for 'GIDA' category products for 'ULKER'
SELECT AVG(UNITPRICE) AS AveragePrice
FROM dbo.ITEMS
WHERE CATEGORY1 = 'GIDA'
AND BRAND = 'ULKER';

-- 17) Top age group purchases for 'ULKER'
SELECT TOP 1
    u.BIRTHDATE,
    SUM(s.LINETOTAL) AS TotalSales
FROM dbo.SALEORDERS AS s
JOIN dbo.USERS AS u
    ON s.USERNAME_ = u.USERNAME_
JOIN dbo.ITEMS AS i
    ON s.ITEMCODE = i.ID
WHERE i.BRAND = 'ULKER' -- Added brand filter
GROUP BY u.BIRTHDATE
ORDER BY TotalSales DESC;

-- 18) Concatenate 'ULKER' ITEM categories
SELECT
    ID,
    ITEMNAME,
    BRAND,
    CONCAT_WS(' - ', CATEGORY1, CATEGORY2, CATEGORY3, CATEGORY4) AS FullCategoryPath
FROM dbo.ITEMS
WHERE BRAND = 'ULKER'; -- Added brand filter

-- 19) First 5 chars of APPROVECODE (general)
SELECT
    APPROVECODE,
    LEFT(APPROVECODE, 5) AS First5DigitsOfApproveCode
FROM dbo.PAYMENTS;

-- 20) All PAYMENT data (general)
SELECT *
FROM dbo.PAYMENTS;

-- 21) USERS PASSWORD_ uppercase (general)
SELECT ID, USERNAME_, NAMESURNAME, UPPER(PASSWORD_) AS UppercasePassword
FROM dbo.USERS;

-- 22) USERS surnames lowercase (general)
SELECT
    NAMESURNAME,
    LOWER(SUBSTRING(NAMESURNAME, CHARINDEX(' ', NAMESURNAME) + 1, LEN(NAMESURNAME) - CHARINDEX(' ', NAMESURNAME))) AS LowercaseSurname
FROM dbo.USERS
WHERE NAMESURNAME LIKE '% %';

-- 23) Convert INVOICES DATE_ formats (general)
SELECT
    DATE_ AS OriginalDate,
    FORMAT(DATE_, 'MM/dd/yyyy') AS FormattedDate_mm_dd_yyyy,
    FORMAT(DATE_, 'yyyy.MM.dd') AS FormattedDate_yyyy_mm_dd,
    FORMAT(DATE_, 'dd.MM.yyyy') AS FormattedDate_dd_mm_yyyy,
    FORMAT(DATE_, 'yyyyMMdd') AS FormattedDate_yyyymmdd
FROM dbo.INVOICES;

-- 24) INVOICES DATE_ (Y, M, D, Week) (general)
SELECT
    DATE_ AS OriginalDate,
    YEAR(DATE_) AS InvoiceYear,
    MONTH(DATE_) AS InvoiceMonth,
    DAY(DATE_) AS InvoiceDay,
    DATEPART(wk, DATE_) AS InvoiceWeekOfYear
FROM dbo.INVOICES;

-- 25) SALEORDERS month to season for 'ULKER'
SELECT
    MONTH_ AS MonthName,
    CASE
        WHEN MONTH_ IN ('Mart', 'Nisan', 'Mayýs') THEN 'Spring'
        WHEN MONTH_ IN ('Haziran', 'Temmuz', 'Aðustos') THEN 'Summer'
        WHEN MONTH_ IN ('Eylül', 'Ekim', 'Kasým') THEN 'Autumn'
        WHEN MONTH_ IN ('Aralýk', 'Ocak', 'Þubat') THEN 'Winter'
        ELSE 'Unknown Month'
    END AS Season
FROM dbo.SALEORDERS AS s
JOIN dbo.ITEMS AS i
    ON s.ITEMCODE = i.ID
WHERE i.BRAND = 'ULKER' -- Added brand filter
GROUP BY MONTH_
ORDER BY MONTH_;

-- 26) ITEMS brand categories (general categorization)
SELECT
    BRAND,
    CASE BRAND
        WHEN 'ULKER' THEN 'FOOD & DRINK'
        WHEN 'REXONA' THEN 'COSMETICS'
        WHEN 'ALGIDA' THEN 'ICE CREAM'
        WHEN 'NESCAFE' THEN 'HOT BEVERAGE'
        ELSE 'OTHER'
    END AS BrandCategory
FROM dbo.ITEMS;