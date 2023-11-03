Fact Table:
A fact table is a primary component of a star schema or snowflake schema in a data warehouse. It contains quantitative data (facts) that can be analyzed, such as sales revenue, quantity sold, or profit. Fact tables are usually associated with business transactions or events and store detailed information. Each row in the fact table represents a specific event or transaction, and they often contain foreign keys that link to dimension tables. Fact tables are typically the focus of analytical queries and support OLAP operations.

Dimension Table:
Dimension tables provide context and descriptive information for the data in a fact table. They contain attributes or characteristics that help categorize, filter, or group the data in the fact table. Dimension tables are usually smaller in size compared to fact tables and help users understand the "who, what, when, where, and why" related to the facts in the fact table. For example, in a sales data warehouse, dimension tables could include tables for time (e.g., year, quarter, month), products, customers, and stores. These dimension tables contain attributes like product names, customer names, store locations, etc., that allow users to analyze and aggregate the data.

OLAP (Online Analytical Processing) Operations:
OLAP stands for Online Analytical Processing, and it refers to a category of computer processing that enables interactive and complex data analysis for decision support. OLAP operations help users gain insights from data stored in a data warehouse. There are several OLAP operations, including:

Roll-Up: This operation involves aggregating data along a hierarchy. For example, you can roll up monthly sales data to quarterly or yearly totals to see higher-level summaries.

Drill Down: The opposite of roll-up, drill down allows users to access more detailed information. For example, you can drill down from yearly sales to quarterly, monthly, and daily sales figures.

Slice: Slicing involves selecting a specific subset of data from a cube, typically along one dimension. For example, you can slice sales data to view only sales from a specific region or time period.

Dice: Dicing is similar to slicing but allows you to view a multi-dimensional subcube. You can focus on a combination of specific dimensions and their values. For instance, you might want to view sales data for a specific product category and a specific region.

Pivot (Rotate): Pivoting involves changing the orientation of data in a multidimensional cube. It allows users to view data from different perspectives or dimensions.





mysql -u root -p
SHOW DATABASES; 
CREATE DATABASE Inventoryy_Management_System;
USE Inventoryy_Management_System;

First, let's create dimension tables and a fact table:

-- Create the TIME dimension table
CREATE TABLE TIME (
    DATE_ID INT PRIMARY KEY,
    DATE DATE NOT NULL,
    YEAR INT NOT NULL,
    QUARTER VARCHAR(5) NOT NULL,
    MONTH VARCHAR(20) NOT NULL,
    DAY_OF_MONTH INT NOT NULL,
    WEEK VARCHAR(5) NOT NULL,
    DAY_OF_WEEK VARCHAR(10) NOT NULL,
    HOLIDAY_FLAG VARCHAR(2)
);

-- Create the STORE dimension table
CREATE TABLE STORE (
    STORE_ID INT PRIMARY KEY,
    STORE_NAME VARCHAR(50) NOT NULL,
    LOCATION VARCHAR(50),
    STORE_TYPE VARCHAR(50)
);

-- Create the PRODUCT dimension table
CREATE TABLE PRODUCT (
    PRODUCT_ID INT PRIMARY KEY,
    PRODUCT_NAME VARCHAR(255) NOT NULL,
    BRAND VARCHAR(50),
    CATEGORY VARCHAR(50),
    SUBCATEGORY VARCHAR(50),
    SUPPLIER_ID INT
);

-- Create the INVENTORY_FACT fact table
CREATE TABLE INVENTORY_FACT (
    DATE_ID INT,
    STORE_ID INT,
    PRODUCT_ID INT,
    TOTAL_SALES FLOAT NOT NULL,
    TOTAL_INVENTORY_COUNT INT NOT NULL,
    PROFIT FLOAT,
    REVENUE FLOAT
);


Now, let's insert some sample data into these tables.

-- Insert sample data into TIME dimension table
INSERT INTO TIME VALUES
    (1, '2023-01-01', 2023, 'Q1', 'January', 1, 'W1', 'Monday', 'N'),
    (2, '2023-02-15', 2023, 'Q1', 'February', 15, 'W3', 'Wednesday', 'N');

-- Insert sample data into STORE dimension table
INSERT INTO STORE VALUES
    (101, 'Store A', 'Location A', 'Retail'),
    (102, 'Store B', 'Location B', 'Wholesale');

-- Insert sample data into PRODUCT dimension table
INSERT INTO PRODUCT VALUES
    (301, 'Product X', 'Brand X', 'Category A', 'Subcategory 1', 201),
    (302, 'Product Y', 'Brand Y', 'Category B', 'Subcategory 2', 202);

-- Insert sample data into INVENTORY_FACT fact table
INSERT INTO INVENTORY_FACT VALUES
    (1, 101, 301, 1000, 50, 400, 6000),
    (2, 101, 302, 1500, 75, 500, 7500),
    (2, 102, 301, 2000, 100, 800, 10000);


Now, let's perform OLAP operations.

Roll-Up Operation (Sum of TOTAL_SALES by QUARTER):

SELECT TIME.QUARTER, SUM(INVENTORY_FACT.TOTAL_SALES) AS QuarterTotalSales
FROM INVENTORY_FACT
JOIN TIME ON INVENTORY_FACT.DATE_ID = TIME.DATE_ID
GROUP BY TIME.QUARTER;

Drill Down Operation (Showing details for a specific QUARTER):
SELECT TIME.MONTH, INVENTORY_FACT.TOTAL_SALES
FROM INVENTORY_FACT
JOIN TIME ON INVENTORY_FACT.DATE_ID = TIME.DATE_ID
WHERE TIME.QUARTER = 'Q1';


Slice Operation (Comparing TOTAL_INVENTORY_COUNT and STORE_TYPE):
SELECT STORE.STORE_TYPE, SUM(INVENTORY_FACT.TOTAL_INVENTORY_COUNT) AS TotalInventoryCount
FROM INVENTORY_FACT
JOIN STORE ON INVENTORY_FACT.STORE_ID = STORE.STORE_ID
GROUP BY STORE.STORE_TYPE;
