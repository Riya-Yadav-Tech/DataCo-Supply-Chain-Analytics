select  * from [dbo].[DataCoSupplyChainDataset]


--------------------------------------------------------------------------------------------------------
-----------------------------------SCHEMA AND INGESTION---------------------------------------------


--1-TOTAL RECORDS--
select count(*) AS TOTAL_RECORDS from [dbo].[DataCoSupplyChainDataset]

--2(a)--COLUMNS NAME
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DataCoSupplyChainDataset';
--2(b)--TOTAL COLUMNS
SELECT 
    COUNT(*) AS Total_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DataCoSupplyChainDataset';

--3-DATE RANGE OF ORDERS
SELECT
    MIN([order_date_DateOrders]) AS Earliest_Order_Date,
    MAX([order_date_DateOrders]) AS Latest_Order_Date,
    DATEDIFF(
        DAY,
        MIN([order_date_DateOrders]),
        MAX([order_date_DateOrders])
    ) AS Total_Days_Covered
FROM [dbo].[DataCoSupplyChainDataset];

--4-CHECK IF ORDER_ID AND ORDER_ITEM_ID HAVE DUPLICATES
SELECT
    [Order_Id],
    [Order_Item_Id],
    COUNT(*) AS Duplicate_Count
FROM [dbo].[DataCoSupplyChainDataset]
GROUP BY
    [Order_Id],
    [Order_Item_Id]
HAVING COUNT(*) > 1;

--5-Scan for Critical NULL / Missing Values

SELECT 
    SUM(CASE WHEN [Order_Id] IS NULL THEN 1 ELSE 0 END) AS Missing_Order_IDs,
    SUM(CASE WHEN [Customer_Id] IS NULL THEN 1 ELSE 0 END) AS Missing_Customer_IDs,
    SUM(CASE WHEN [Product_Card_Id] IS NULL THEN 1 ELSE 0 END) AS Missing_Product_IDs,
    SUM(CASE WHEN [Sales] IS NULL THEN 1 ELSE 0 END) AS Missing_Sales,
    SUM(CASE WHEN [Benefit_per_order] IS NULL THEN 1 ELSE 0 END) AS Missing_Profits,
    SUM(CASE WHEN [Days_for_shipping_real] IS NULL THEN 1 ELSE 0 END) AS Missing_Real_Shipping_Days
FROM [dbo].[DataCoSupplyChainDataset] ;

--6- VALUE RANGE  & ANOMALY CHECKS
-- Checks for negative quantities or abnormal financial numbers

SELECT 
    MIN([Sales]) AS Min_Sales,
    MAX([Sales]) AS Max_Sales,
    MIN([Benefit_per_order]) AS Min_Profit,
    MAX([Benefit_per_order]) AS Max_Profit,
    MIN([Order_Item_Quantity]) AS Min_Quantity,
    MAX([Order_Item_Quantity]) AS Max_Quantity,
    SUM(CASE WHEN [Sales] < 0 THEN 1 ELSE 0 END) AS Negative_Sales,
    SUM(CASE WHEN [Order_Item_Quantity] <= 0 THEN 1 ELSE 0 END) AS Invalid_Quantities
FROM [dbo].[DataCoSupplyChainDataset];

--7-Verify Delivery Status Category Values
SELECT DISTINCT 
    [Delivery_Status],
    [Shipping_Mode],
    COUNT([Order_Id]) AS Status_Count
FROM [dbo].[DataCoSupplyChainDataset]
GROUP BY [Delivery_Status], [Shipping_Mode]
ORDER BY [Shipping_Mode], Status_Count DESC;

----------------------------------------------------------------------------------------------------
----------------KPI AND BUSINESS QUERY-------------------------------------------------------------
--1. Total Revenue Business Question: What is the total gross revenue generated across all recorded sales?
SELECT 
    ROUND(SUM(Sales), 2) AS Total_Revenue
FROM [dbo].[DataCoSupplyChainDataset];

--2. Total Net Profit & Profit Margin % Business Question: What is the net profit and overall profit margin percentage across global operations?
SELECT 
    ROUND(SUM([Benefit_per_order]), 2) AS Total_Net_Profit,
    ROUND((SUM([Benefit_per_order]) / NULLIF(SUM(Sales), 0)) * 100, 2) AS Profit_Margin_Pct
FROM [dbo].[DataCoSupplyChainDataset] ;

--3. Order & Item Volume Business Question: How many total orders were placed, how many total items were sold, and what is the average item count per order?
SELECT 
    COUNT(DISTINCT [Order_Id]) AS Total_Distinct_Orders,
    SUM([Order_Item_Quantity]) AS Total_Items_Sold,
    ROUND(CAST(SUM([Order_Item_Quantity]) AS DECIMAL(10,2)) / COUNT(DISTINCT [Order_Id]), 2) AS Avg_Items_Per_Order
FROM [dbo].[DataCoSupplyChainDataset];

-- 4. OVERALL DELIVERY PERFORMANCE
-- Business Question:
-- What percentage of orders were delivered on time, late, or cancelled?
SELECT
    COUNT(DISTINCT [Order_Id]) AS Total_Orders,
    COUNT(DISTINCT CASE
        WHEN [Delivery_Status] IN ('Advance shipping', 'Shipping on time')
        THEN [Order_Id]
    END) AS On_Time_Orders,
    COUNT(DISTINCT CASE
        WHEN [Delivery_Status] = 'Late delivery'
        THEN [Order_Id]
    END) AS Late_Orders,

    COUNT(DISTINCT CASE
        WHEN [Delivery_Status] = 'Shipping canceled'
        THEN [Order_Id]
    END) AS Cancelled_Orders,

    ROUND(
        CAST(
            COUNT(DISTINCT CASE
                WHEN [Delivery_Status] IN ('Advance shipping', 'Shipping on time')
                THEN [Order_Id]
            END)
            AS DECIMAL(10,2)
        )
        / NULLIF(COUNT(DISTINCT [Order_Id]), 0) * 100,
        2
    ) AS On_Time_Rate_Pct,

    ROUND(
        CAST(
            COUNT(DISTINCT CASE
                WHEN [Delivery_Status] = 'Late delivery'
                THEN [Order_Id]
            END)
            AS DECIMAL(10,2)
        )
        / NULLIF(COUNT(DISTINCT [Order_Id]), 0) * 100,
        2) AS Late_Rate_Pct,
        
    ROUND(
        CAST(
            COUNT(DISTINCT CASE
                WHEN [Delivery_Status] = 'Shipping canceled'
                THEN [Order_Id]
            END)
            AS DECIMAL(10,2) )
        / NULLIF(COUNT(DISTINCT [Order_Id]), 0) * 100,
        2) AS Cancellation_Rate_Pct
FROM [dbo].[DataCoSupplyChainDataset];

-- 5. SHIPPING MODE PERFORMANCE
-- Business Question:
-- Which shipping modes have the highest delivery risk
-- and longest shipping time?

SELECT 
    [Shipping_Mode],

    COUNT(DISTINCT [Order_Id]) AS Total_Orders,

    COUNT(DISTINCT CASE
        WHEN [Late_delivery_risk] = 1
        THEN [Order_Id]
    END) AS Late_Risk_Orders,

    ROUND(
        CAST(
            COUNT(DISTINCT CASE
                WHEN [Late_delivery_risk] = 1
                THEN [Order_Id]
            END)
            AS DECIMAL(10,2)
        )
        / NULLIF(COUNT(DISTINCT [Order_Id]), 0) * 100,
        2
    ) AS Late_Risk_Rate_Pct,

    ROUND(
        AVG([Days_for_shipping_real]), 
        2
    ) AS Avg_Actual_Shipping_Days,

    ROUND(
        AVG([Days_for_shipment_scheduled]), 
        2
    ) AS Avg_Scheduled_Shipping_Days

FROM [dbo].[DataCoSupplyChainDataset]

GROUP BY [Shipping_Mode]

ORDER BY Late_Risk_Rate_Pct DESC;

--6.Revenue & Profitability by Market Region
SELECT 
    [Market],
    [Order_Region],
    COUNT(DISTINCT [Order_Id]) AS Total_Orders,
    ROUND(SUM([Sales]), 2) AS Total_Sales,
    ROUND(SUM([Benefit_per_order]), 2) AS Total_Profit
FROM [dbo].[DataCoSupplyChainDataset]
GROUP BY [Market], [Order_Region]
ORDER BY Total_Sales DESC;

--7. Top 10 Revenue-Generating Product Categories
SELECT TOP 10
    [Category_Name],
    SUM([Order_Item_Quantity]) AS Total_Quantity_Sold,
    ROUND(SUM([Sales]), 2) AS Total_Revenue,
    ROUND(SUM([Benefit_per_order]), 2) AS Total_Profit
FROM [dbo].[DataCoSupplyChainDataset]
GROUP BY [Category_Name]
ORDER BY Total_Revenue DESC;

--8. Customer Segment Revenue Breakdown
WITH Order_Revenue AS
(SELECT
        [Customer_Segment],
        [Order_Id],
        [Customer_Id],
        SUM([Sales]) AS Order_Revenue
    FROM [dbo].[DataCoSupplyChainDataset]
    GROUP BY
        [Customer_Segment],
        [Order_Id],
        [Customer_Id]
)
SELECT
    [Customer_Segment],
    COUNT(DISTINCT [Customer_Id]) AS Unique_Customers,
    COUNT(DISTINCT [Order_Id]) AS Total_Orders,
    ROUND(SUM(Order_Revenue), 2) AS Total_Revenue,
    ROUND(AVG(Order_Revenue), 2) AS Avg_Revenue_Per_Order
FROM Order_Revenue
GROUP BY [Customer_Segment]
ORDER BY Total_Revenue DESC;
--------------------------------------------------------------------------------------------------------
-----------------   ADVANCED WINDOW FUNCTION------------------------------------------------------
-- 1. MOVING AVERAGES & TIME-SERIES TRENDS
-- ----------------------------------------------------------------------------
-- Calculates Monthly Sales, 3-Month Moving Average Sales, and Month-over-Month Growth %
WITH Monthly_Sales_CTE AS (
    SELECT 
        DATEFROMPARTS(YEAR([order_date_DateOrders]), MONTH([order_date_DateOrders]), 1) AS Order_Month,
        ROUND(SUM([Sales]), 2) AS Monthly_Revenue
    FROM [dbo].[DataCoSupplyChainDataset]
    GROUP BY DATEFROMPARTS(YEAR([order_date_DateOrders]), MONTH([order_date_DateOrders]), 1)
)
SELECT 
    Order_Month,
    Monthly_Revenue,
    ROUND(AVG(Monthly_Revenue) OVER(
        ORDER BY Order_Month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS [3_Month_Moving_Avg_Sales],
    ROUND((Monthly_Revenue - LAG(Monthly_Revenue, 1) OVER(ORDER BY Order_Month)) 
        / NULLIF(LAG(Monthly_Revenue, 1) OVER(ORDER BY Order_Month), 0) * 100, 2) AS MoM_Growth_Pct
FROM Monthly_Sales_CTE
ORDER BY Order_Month;

-- 2. RANKING ALGORITHMS (Dense Rank & Partitioning)
-- ----------------------------------------------------------------------------
-- Ranks Products by Revenue within each Market Region
WITH Product_Regional_Rank_CTE AS (
    SELECT 
        [Order_Region],
        [Product_Name],
        [Category_Name],
        ROUND(SUM([Sales]), 2) AS Total_Product_Revenue,
        DENSE_RANK() OVER(
            PARTITION BY [Order_Region] 
            ORDER BY SUM([Sales]) DESC
        ) AS Revenue_Rank_In_Region
    FROM [dbo].[DataCoSupplyChainDataset]
    GROUP BY [Order_Region], [Product_Name], [Category_Name]
)
SELECT 
    [Order_Region],
    Revenue_Rank_In_Region,
    [Product_Name],
    [Category_Name],
    Total_Product_Revenue
FROM Product_Regional_Rank_CTE
WHERE Revenue_Rank_In_Region <= 3
ORDER BY [Order_Region], Revenue_Rank_In_Region;

-- 3. COMPLEX CTE & WINDOW FUNCTIONS: CUSTOMER RFM & DELAY RISK EXPOSURE
-- ----------------------------------------------------------------------------
-- Segments Customers and flags high-risk delayed shipments using NTILE and Cumulative Aggregates
WITH Customer_Order_Metrics AS (
    SELECT 
        [Customer_Id],
        CONCAT([Customer_Fname], ' ', [Customer_Lname]) AS Customer_Name,
        COUNT(DISTINCT [Order_Id]) AS Total_Customer_Orders,
        ROUND(SUM([Sales]), 2) AS Total_Customer_Spend,
        SUM(CASE WHEN [Late_delivery_risk] = 1 THEN 1 ELSE 0 END) AS Total_Late_Orders,
        NTILE(4) OVER (ORDER BY SUM([Sales]) DESC) AS Spend_Quartile
    FROM [dbo].[DataCoSupplyChainDataset]
    GROUP BY [Customer_Id], [Customer_Fname], [Customer_Lname]
)
SELECT 
    [Customer_Id],
    Customer_Name,
    Total_Customer_Orders,
    Total_Customer_Spend,
    Total_Late_Orders,
    CASE 
        WHEN Spend_Quartile = 1 THEN 'VIP Tier'
        WHEN Spend_Quartile = 2 THEN 'High Value'
        WHEN Spend_Quartile = 3 THEN 'Mid Value'
        ELSE 'Low Value'
    END AS Customer_Tier,
    ROUND(SUM(Total_Customer_Spend) OVER(ORDER BY Total_Customer_Spend DESC), 2) AS Cumulative_Spend_Total
FROM Customer_Order_Metrics
ORDER BY Total_Customer_Spend DESC;

----------------------------------------------------------------------------------------------------------
------------------ADVANCED SUPPLY CHAIN OPERATIONL DIAGNOSTICS--------------------------------------
-- 1. SHIPPING DELAY VARIANCE ANALYSIS
-- Business Question:
-- Which shipping modes experience the largest delay
-- compared with their scheduled shipping time?
SELECT 
    [Shipping_Mode],
    COUNT(DISTINCT [Order_Id]) AS Total_Orders,
    ROUND(
        AVG([Days_for_shipping_real]), 
        2
    ) AS Avg_Real_Days,
    ROUND(
        AVG([Days_for_shipment_scheduled]), 
        2
    ) AS Avg_Scheduled_Days,
    ROUND(
        AVG(
            [Days_for_shipping_real] 
            - [Days_for_shipment_scheduled]
        ),2) AS Avg_Delay_Days_Variance
FROM [dbo].[DataCoSupplyChainDataset]
GROUP BY [Shipping_Mode]
ORDER BY Avg_Delay_Days_Variance DESC;
-- 2. ORDER CANCELLATION & REVENUE EXPOSURE
-- Business Question:
-- How much revenue is associated with cancelled,
-- suspected-fraud, and payment-review orders?
SELECT 
    [Order_Status],
COUNT(DISTINCT [Order_Id]) AS Total_Orders,
ROUND(
        SUM([Sales]), 
        2
    ) AS Impacted_Revenue
FROM [dbo].[DataCoSupplyChainDataset]
WHERE [Order_Status] IN 
(
    'CANCELED',
    'SUSPECTED_FRAUD',
    'PAYMENT_REVIEW'
)
GROUP BY [Order_Status]
ORDER BY Impacted_Revenue DESC;

--3.Regional Negative Profit (Loss Leakage) Analysis
SELECT TOP 10
    [Order_Region],
    [Category_Name],
    COUNT([Order_Item_Id]) AS Loss_Order_Items,
    ROUND(SUM([Sales]), 2) AS Total_Sales,
    ROUND(SUM([Benefit_per_order]), 2) AS Net_Loss
FROM [dbo].[DataCoSupplyChainDataset]
WHERE [Benefit_per_order] < 0
GROUP BY [Order_Region], [Category_Name]
ORDER BY Net_Loss ASC;

--4. DELIVERY PERFORMANCE BY REGION
-- Business Question:
-- Which regions have the highest delivery delays and lowest on-time performance?

SELECT
    [Order_Region],
    COUNT(DISTINCT [Order_Id]) AS Total_Orders,

    COUNT(DISTINCT CASE
        WHEN [Delivery_Status] = 'Late delivery'
        THEN [Order_Id]
    END) AS Late_Orders,

    COUNT(DISTINCT CASE
        WHEN [Delivery_Status] <> 'Late delivery'
        THEN [Order_Id]
    END) AS On_Time_Orders,

    ROUND(
        CAST(
            COUNT(DISTINCT CASE
                WHEN [Delivery_Status] = 'Late delivery'
                THEN [Order_Id]
            END
        ) AS DECIMAL(10,2))
        / NULLIF(COUNT(DISTINCT [Order_Id]),0) * 100,
        2
    ) AS Late_Rate_Pct,

    ROUND(AVG([Days_for_shipping_real]), 2) AS Avg_Real_Shipping_Days,

    ROUND(
        AVG(
            [Days_for_shipping_real]
            - [Days_for_shipment_scheduled]
        ),
        2
    ) AS Avg_Delay_Days

FROM [dbo].[DataCoSupplyChainDataset]

GROUP BY [Order_Region]

ORDER BY Late_Rate_Pct DESC;

-- 5. DELIVERY PERFORMANCE BY PRODUCT CATEGORY
-- Business Question:
-- Which product categories experience the highest delivery delays?

SELECT
    [Category_Name],
    COUNT(DISTINCT [Order_Id]) AS Total_Orders,
    COUNT(DISTINCT CASE
        WHEN [Delivery_Status] = 'Late delivery'
        THEN [Order_Id]
    END) AS Late_Orders,
    COUNT(DISTINCT CASE
        WHEN [Delivery_Status] IN ('Advance shipping', 'Shipping on time')
        THEN [Order_Id]
    END) AS On_Time_Orders,
    COUNT(DISTINCT CASE
        WHEN [Delivery_Status] = 'Shipping canceled'
        THEN [Order_Id]
    END) AS Cancelled_Orders,
    ROUND(
        CAST(
            COUNT(DISTINCT CASE
                WHEN [Delivery_Status] = 'Late delivery'
                THEN [Order_Id]
            END)
            AS DECIMAL(10,2)
        )
        / NULLIF(COUNT(DISTINCT [Order_Id]), 0) * 100,
        2
    ) AS Late_Rate_Pct,
    ROUND(
        AVG([Days_for_shipping_real]),
        2
    ) AS Avg_Real_Shipping_Days,
    ROUND(
        AVG([Days_for_shipment_scheduled]),
        2
    ) AS Avg_Scheduled_Shipping_Days,
    ROUND(
        AVG(
            [Days_for_shipping_real]
            - [Days_for_shipment_scheduled]
        ),2 ) AS Avg_Delay_Days,
    SUM([Order_Item_Quantity]) AS Total_Quantity_Sold,
    ROUND(SUM([Sales]),
        2
    ) AS Total_Revenue
FROM [dbo].[DataCoSupplyChainDataset]
GROUP BY [Category_Name]
ORDER BY Late_Rate_Pct DESC;

-- 6. SHIPPING MODE × REGION PERFORMANCE
-- Business Question:
-- Which combination of shipping mode and region has
-- the highest delivery risk?

SELECT
    [Shipping_Mode],
    [Order_Region],

    COUNT(DISTINCT [Order_Id]) AS Total_Orders,

    COUNT(DISTINCT CASE
        WHEN [Delivery_Status] = 'Late delivery'
        THEN [Order_Id]
    END) AS Late_Orders,

    COUNT(DISTINCT CASE
        WHEN [Delivery_Status] IN ('Advance shipping', 'Shipping on time')
        THEN [Order_Id]
    END) AS On_Time_Orders,

    COUNT(DISTINCT CASE
        WHEN [Delivery_Status] = 'Shipping canceled'
        THEN [Order_Id]
    END) AS Cancelled_Orders,

    ROUND(
        CAST(
            COUNT(DISTINCT CASE
                WHEN [Delivery_Status] = 'Late delivery'
                THEN [Order_Id]
            END)
            AS DECIMAL(10,2)
        )
        / NULLIF(COUNT(DISTINCT [Order_Id]), 0) * 100,
        2
    ) AS Late_Rate_Pct,

    ROUND(
        AVG([Days_for_shipping_real]),
        2
    ) AS Avg_Real_Shipping_Days,

    ROUND(
        AVG([Days_for_shipment_scheduled]),
        2
    ) AS Avg_Scheduled_Shipping_Days,

    ROUND(
        AVG(
            [Days_for_shipping_real]
            - [Days_for_shipment_scheduled]
        ),
        2
    ) AS Avg_Delay_Days

FROM [dbo].[DataCoSupplyChainDataset]

GROUP BY
    [Shipping_Mode],
    [Order_Region]

HAVING COUNT(DISTINCT [Order_Id]) >= 10

ORDER BY Late_Rate_Pct DESC;

--7. MONTHLY DELIVERY PERFORMANCE TREND
-- Business Question:
-- Is delivery performance improving or worsening over time?

SELECT
    DATEFROMPARTS(
        YEAR([order_date_DateOrders]),
        MONTH([order_date_DateOrders]),
        1
    ) AS Order_Month,

    COUNT(DISTINCT [Order_Id]) AS Total_Orders,
    COUNT(DISTINCT CASE
        WHEN [Delivery_Status] = 'Late delivery'
        THEN [Order_Id]
    END) AS Late_Orders,

    ROUND(
        CAST(
            COUNT(DISTINCT CASE
                WHEN [Delivery_Status] = 'Late delivery'
                THEN [Order_Id]
            END
        ) AS DECIMAL(10,2))
        / NULLIF(COUNT(DISTINCT [Order_Id]),0) * 100,
        2
    ) AS Late_Rate_Pct,

 ROUND(AVG([Days_for_shipping_real]), 2)
        AS Avg_Real_Shipping_Days,
ROUND(
        AVG(
            [Days_for_shipping_real]
            - [Days_for_shipment_scheduled]
        ),
        2
    ) AS Avg_Delay_Days
FROM [dbo].[DataCoSupplyChainDataset]
GROUP BY
    DATEFROMPARTS(
        YEAR([order_date_DateOrders]),
        MONTH([order_date_DateOrders]),
        1
    )
    ORDER BY Order_Month;



--8. TOP PRODUCTS WITH DELIVERY RISK
-- Business Question:
-- Which high-revenue products have significant delivery problems?

WITH Product_Performance AS
(
    SELECT
        [Product_Name],
        [Category_Name],
        COUNT(DISTINCT [Order_Id]) AS Total_Orders,
        SUM([Order_Item_Quantity]) AS Total_Quantity_Sold,
        ROUND(SUM([Sales]), 2) AS Total_Revenue,
        ROUND(SUM([Benefit_per_order]), 2) AS Total_Profit,
        COUNT(DISTINCT CASE
            WHEN [Delivery_Status] = 'Late delivery'
            THEN [Order_Id]
        END) AS Late_Orders,

        ROUND(
            CAST(
                COUNT(DISTINCT CASE
                    WHEN [Delivery_Status] = 'Late delivery'
                    THEN [Order_Id]
                END
            ) AS DECIMAL(10,2))
            / NULLIF(COUNT(DISTINCT [Order_Id]),0) * 100,
            2
        ) AS Late_Rate_Pct,

        ROUND(
            AVG(
                [Days_for_shipping_real]
                - [Days_for_shipment_scheduled]
            ),
            2
        ) AS Avg_Delay_Days
        FROM [dbo].[DataCoSupplyChainDataset]
    GROUP BY
        [Product_Name],
        [Category_Name]
)
SELECT TOP 20
    [Product_Name],
    [Category_Name],
    Total_Orders,
    Total_Quantity_Sold,
    Total_Revenue,
    Total_Profit,
    Late_Orders,
    Late_Rate_Pct,
    Avg_Delay_Days
FROM Product_Performance
WHERE Total_Orders >= 10
ORDER BY Late_Rate_Pct DESC;
