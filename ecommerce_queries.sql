sql_path = os.path.join(project_path, "sql")

sql_content = """-- ================================================
-- Ecommerce Sales Analysis - SQL Queries
-- Author: Priyanka M M
-- Dataset: Sample Superstore
-- ================================================

-- Q1: Total revenue, profit and margin
SELECT 
    ROUND(SUM(Sales), 2) AS Total_Revenue,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS Profit_Margin_Pct
FROM superstore;

-- Q2: Sales and profit by category
SELECT 
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS Profit_Margin_Pct
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Q3: Loss making sub-categories
SELECT 
    Sub_Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Sub_Category
HAVING Total_Profit < 0
ORDER BY Total_Profit ASC;

-- Q4: Sales by region
SELECT 
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM superstore
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Q5: Yearly sales growth
SELECT 
    YEAR(Order_Date) AS Year,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM superstore
GROUP BY YEAR(Order_Date)
ORDER BY Year ASC;

-- Q6: Impact of discounts on profit
SELECT 
    CASE 
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount < 0.2 THEN 'Low (< 20%)'
        WHEN Discount < 0.4 THEN 'Medium (20-40%)'
        ELSE 'High (40%+)'
    END AS Discount_Level,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Discount_Level
ORDER BY Total_Profit DESC;

-- Q7: Top 10 states by sales
SELECT 
    State,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 10;

-- Q8: Best performing customer segment
SELECT 
    Segment,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Segment
ORDER BY Total_Sales DESC;
"""

with open(os.path.join(sql_path, "ecommerce_queries.sql"), "w") as f:
    f.write(sql_content)

print("✅ SQL file saved!")