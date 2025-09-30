--SELECT *
--FROM Retail_sales

--Data Cleaning

SELECT *
FROM Retail_sales
WHERE transactions_id IS NULL
OR
 sale_date IS NULL
OR
 sale_time IS NULL
OR
 customer_id IS NULL
OR
 gender IS NULL
OR
 category IS NULL
OR
 quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR 
total_sale IS NULL


DELETE 
FROM Retail_sales
WHERE transactions_id IS NULL
OR
 sale_date IS NULL
OR
 sale_time IS NULL
OR
 customer_id IS NULL
OR
 gender IS NULL
OR
 category IS NULL
OR
 quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR 
total_sale IS NULL

SELECT *
FROM Retail_sales

--Data Exploration

--How Many Unique Customers We have?

SELECT COUNT(DISTINCT customer_id)
FROM Retail_sales

--Unique category we have

SELECT DISTINCT category
FROM Retail_sales


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM Retail_sales
WHERE sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

SELECT *
FROM Retail_sales
WHERE category = 'Clothing' AND quantiy > 3 AND YEAR(sale_date) = 2022 AND MONTH(sale_date) = 11


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category,SUM(total_sale)
FROM Retail_sales
GROUP BY category


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT AVG(Age) AS Avg_Age
FROM Retail_sales
WHERE category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM Retail_sales
WHERE total_sale >1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT COUNT(*) AS Total_Number_of_Transactions,category,gender
FROM Retail_sales
GROUP BY category,gender
ORDER BY category ASC

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year


SELECT Month_Name,Year,Avg_Sale
FROM (
SELECT AVG(total_sale) AS Avg_Sale,DATENAME(MONTH,sale_date) AS Month_Name,YEAR(sale_date) AS Year,
RANK () OVER ( PARTITION BY YEAR(sale_date)
ORDER BY AVG(total_sale) DESC )
AS RANK
FROM Retail_sales
GROUP BY YEAR(sale_date),DATENAME(MONTH,sale_date)
) AS t1

WHERE RANK = '1'
--ORDER BY Year,Avg_Sale DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT TOP 5 customer_id,SUM(total_sale) AS Highest_total_sale
FROM Retail_sales
GROUP BY customer_id
ORDER BY Highest_total_sale DESC

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category,COUNT(DISTINCT customer_id) AS Unique_customers
FROM Retail_sales
GROUP BY category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


WITH hourly_sale
AS
(
SELECT *,
CASE 
	WHEN DATEPART(HOUR,sale_time) < '12' THEN 'Morning'
	WHEN DATEPART(HOUR ,sale_time) BETWEEN '12' AND '17' THEN 'AfterNoon'
	ELSE 'Evening'
END AS Shift
FROM Retail_sales
)
SELECT Shift,COUNT(*) AS Total_orders
FROM hourly_sale
GROUP BY Shift


--END OF PROJECT
