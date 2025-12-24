USE data;

SHOW TABLES;

DESC Blinkit_data;

-- TYPE CASTING

ALTER TABLE Blinkit_data
MODIFY COLUMN `Item Fat Content` VARCHAR(20);

ALTER TABLE Blinkit_data
MODIFY COLUMN `Item Identifier` VARCHAR(50);

ALTER TABLE Blinkit_data
MODIFY COLUMN `Item Type` VARCHAR(50);

ALTER TABLE blinkit_data
MODIFY COLUMN `Outlet Identifier` VARCHAR(50);

ALTER TABLE blinkit_data
MODIFY COLUMN `Outlet Location Type` VARCHAR(50);

ALTER TABLE blinkit_data
MODIFY COLUMN `Outlet Size` VARCHAR(50);

ALTER TABLE blinkit_data
MODIFY COLUMN `Outlet Type` VARCHAR(50);

ALTER TABLE blinkit_data
MODIFY COLUMN `Item Visibility` FLOAT;

ALTER TABLE blinkit_data
MODIFY COLUMN `Item Weight` FLOAT;

ALTER TABLE blinkit_data
MODIFY COLUMN `Sales` FLOAT;

ALTER TABLE blinkit_data
MODIFY COLUMN `Rating` FLOAT;

SELECT *
FROM blinkit_data;

SELECT COUNT(*)
FROM blinkit_data;

SET SQL_SAFE_UPDATES = 0;

UPDATE blinkit_data
SET `Item Fat Content` =
CASE 
WHEN `Item Fat Content` IN ('LF','low fat') THEN 'Low Fat'
WHEN `Item Fat Content` = 'reg' THEN 'Regular'
ELSE  `Item Fat Content`
END;

SELECT DISTINCT(`Item Fat Content`)
FROM blinkit_data;

SELECT *
FROM blinkit_data;

SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data;

SELECT ROUND(AVG(Sales)) AS Avg_Sales 
FROM blinkit_data;

SELECT COUNT(*) AS No_of_Items
FROM blinkit_data;
    
SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data;
 
SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_For_Lowfat
FROM blinkit_data
WHERE `Item Fat Content`='Low Fat';

SELECT `Item Fat Content`,
	CONCAT(CAST(SUM(Sales)/1000 AS DECIMAL(10,2)),'K')AS Total_sales_byfatcontent,
    CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_sales_byfatcontent,
    COUNT(*) AS No_ofitems_in_fatcontent,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating_byfatcontent
FROM blinkit_data
GROUP BY `Item Fat Content`
ORDER BY Total_sales_byfatcontent;

SELECT `Item Type`,
	CONCAT(CAST(SUM(Sales)/1000 AS DECIMAL(10,2)),'K')AS Total_sales_by_Itemtype,
    CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_sales_by_Itemtype,
    COUNT(*) AS No_ofitems_in_fatcontent,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating_by_Itemtype
FROM blinkit_data
GROUP BY `Item Type`
ORDER BY Total_sales_by_Itemtype
LIMIT 5;

SELECT 
    `Outlet Location Type`,
    CONCAT(ROUND(SUM(CASE WHEN `Item Fat Content` = 'Low Fat' THEN Sales ELSE 0 END)/1000, 2), 'K') AS Low_Fat,
    CONCAT(ROUND(SUM(CASE WHEN `Item Fat Content` = 'Regular' THEN Sales ELSE 0 END)/1000, 2), 'K') AS Regular
FROM blinkit_data
GROUP BY `Outlet Location Type`
ORDER BY `Outlet Location Type`;

SELECT *
FROM blinkit_data;

SELECT `Outlet Establishment Year`,
	CONCAT(CAST(SUM(Sales)/1000 AS DECIMAL(10,2)),'K')AS Total_sales_byestablished_year,
    CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_sales_byestablished_year,
    COUNT(*) AS No_ofitems_in_byestablished_year,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating_byestablished_year
FROM blinkit_data
GROUP BY `Outlet Establishment Year`
ORDER BY Total_sales_byestablished_year DESC;

SELECT `Outlet Location Type`, 
	CONCAT(CAST(SUM(Sales)/1000 AS DECIMAL(10,2)),'K')AS Total_sales_bylocationtype,
    CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_sales_bylocationtype,
    COUNT(*) AS No_ofitems_in_bylocationtype,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating_bylocationtype
FROM blinkit_data
GROUP BY `Outlet Location Type`
ORDER BY Total_sales_bylocationtype DESC;

SELECT `Outlet Type`, 
	CONCAT(CAST(SUM(Sales)/1000 AS DECIMAL(10,2)),'K')AS Total_sales_byOutletType,
    CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_sales_byOutletType,
    COUNT(*) AS No_ofitems_in_byOutletType,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating_byOutletType
FROM blinkit_data
GROUP BY `Outlet Type`
ORDER BY Total_sales_byOutletType DESC;


