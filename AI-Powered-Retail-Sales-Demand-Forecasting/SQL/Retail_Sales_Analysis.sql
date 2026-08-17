CREATE DATABASE retail_sales_db;

USE retail_sales_db;

CREATE TABLE retail_sales (
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Product_ID VARCHAR(10),
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Region VARCHAR(30),
    City VARCHAR(50),
    Quantity INT,
    Unit_Price DECIMAL(12,2),
    Discount DECIMAL(5,2),
    Sales DECIMAL(14,2),
    Cost DECIMAL(14,2),
    Profit DECIMAL(14,2),
    Payment_Mode VARCHAR(30),
    Customer_Segment VARCHAR(30),
    Inventory_Level INT,
    Supplier_ID VARCHAR(20)
);


SELECT COUNT(*) AS total_rows
FROM retail_sales;

SELECT *
FROM retail_sales
LIMIT 10;


--  Total Sales & Profit
SELECT
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM retail_sales;

-- Category-wise Sales & Profit
SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM retail_sales
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Top 5 Products by Sales
SELECT
    Product_Name,
    SUM(Sales) AS Total_Sales
FROM retail_sales
GROUP BY Product_Name
ORDER BY Total_Sales DESC
LIMIT 5;

SELECT
    SUM(Order_ID IS NULL) AS Order_ID_Missing,
    SUM(Order_Date IS NULL) AS Order_Date_Missing,
    SUM(Product_ID IS NULL) AS Product_ID_Missing,
    SUM(Product_Name IS NULL) AS Product_Name_Missing,
    SUM(Category IS NULL) AS Category_Missing,
    SUM(Customer_ID IS NULL) AS Customer_ID_Missing,
    SUM(Customer_Name IS NULL) AS Customer_Name_Missing,
    SUM(Region IS NULL) AS Region_Missing,
    SUM(City IS NULL) AS City_Missing,
    SUM(Quantity IS NULL) AS Quantity_Missing,
    SUM(Unit_Price IS NULL) AS Unit_Price_Missing,
    SUM(Discount IS NULL) AS Discount_Missing,
    SUM(Sales IS NULL) AS Sales_Missing,
    SUM(Cost IS NULL) AS Cost_Missing,
    SUM(Profit IS NULL) AS Profit_Missing
FROM retail_sales;


-- Duplicate check

SELECT
    Order_ID,
    COUNT(*) AS duplicate_count
FROM retail_sales
GROUP BY Order_ID
HAVING COUNT(*) > 1;


-- Negative / invalid values check
SELECT *
FROM retail_sales
WHERE Quantity <= 0
   OR Unit_Price <= 0
   OR Sales <= 0
   OR Cost <= 0
   OR Profit < 0
LIMIT 20;

-- Region-wise Sales & Profit
SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM retail_sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM retail_sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM retail_sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

-- Monthly Sales Trend
SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM retail_sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

-- Low Inventory
SELECT
    Product_Name,
    AVG(Inventory_Level) AS Avg_Inventory
FROM retail_sales
GROUP BY Product_Name
ORDER BY Avg_Inventory ASC;

-- Product-wise Profit Margin

SELECT
    Product_Name,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM retail_sales
GROUP BY Product_Name
ORDER BY Profit_Margin_Percentage DESC;