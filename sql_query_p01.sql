CREATE DATABASE Sql_Project_01;

USE Sql_Project_01;
CREATE TABLE Retail_Sales (
	transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id	INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(15),
    quantiy	INT,
    price_per_unit INT,
    cogs FLOAT,
    total_sale	FLOAT
);
SELECT * FROM Retail_Sales;
SELECT 
    COUNT(*)
FROM
    Retail_Sales;
-- How Many Sales We Have--
SELECT COUNT(*) AS Total_Sales FROM Retail_Sales;

-- How Many Unique Coutomers We Have--
SELECT COUNT(DISTINCT customer_id) AS Total_Customer FROM Retail_Sales;

-- How Many Unique category We Have--
SELECT COUNT(DISTINCT category) AS Total_Category FROM Retail_Sales;

-- How Many Unique category name We Have--
SELECT DISTINCT category AS Total_Category FROM Retail_Sales;

-- DATA ANALYSIS AND BUSINESS PROBLEMS

-- Q1. Write SQL Query to retrieve all columns for sales made on '2022-11-05' --
SELECT 
    *
FROM
    Retail_Sales
WHERE
    sale_date = '2022-11-05';

 -- Q2. Write a SQL query to retrieve all transaction where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022.
SELECT 
    *
FROM
    Retail_Sales
WHERE
    TRIM(category) = 'Clothing'
        AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
        AND quantiy >= 1;

-- Q3. Write a SQL query to calculate the total sales (total_sales) for each Category.
SELECT 
    category,
    SUM(total_sale) AS Net_Sale,
    COUNT(*) AS Total_order
FROM
    Retail_Sales
GROUP BY category;

-- Q4. Write a SQL query to find the average age of customer who purchased items form the 'Beauty' category.
SELECT 
    AVG(age) AS Average_Age
FROM
    Retail_Sales
WHERE
    TRIM(category) = 'Beauty';
    
-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT 
    *
FROM
    Retail_Sales
WHERE
    total_sale >= 1000;
    
-- Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    COUNT(transactions_id) AS Total_Transc,
    gender,
    category
FROM
    Retail_Sales
GROUP BY
    category,gender;

-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
	YEAR,
	MONTH,
	Avg_sale
FROM (
SELECT 
	YEAR(sale_date) AS YEAR,
	MONTH(sale_date) AS MONTH,
    ROUND(AVG(total_sale), 2) AS Avg_sale,
    RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS BEST
FROM
    Retail_Sales
GROUP BY
	1, 2
    ) as t
    where best = 1;
    
    
-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales

SELECT 
    customer_id, 
    SUM(total_sale) AS Total_Sales
FROM
    Retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    COUNT(DISTINCT customer_id) AS Unique_Customer, category
FROM
    Retail_sales
GROUP BY 2;


-- Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH Hourly_sale
AS
(
SELECT 
    *,
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'AfterNoon'
        ELSE 'Evening'
    END AS Shift
FROM
    Retail_sales
    )
SELECT
	shift,
    COUNT(*) AS total_orders
    FROM hourly_sale
    GROUP BY shift
    
    
-- END OF PROJECT --