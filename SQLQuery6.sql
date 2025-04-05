
select * from Product_data;

select * from product_saless;

select * from discount_data ;

--Join
select * 
from
	Product_data d
join product_saless b on d.product_id =b.Product;


select 
	d.Product,d.Category, d.Brand,
	d.Description,d.Cost_Price,
	d.Image_url,b.Date,
	b.Customer_Type,b.Discount_Band,
	b.Units_Sold,
	(Sale_Price*Units_Sold)as revenue,
	(Cost_Price*Units_Sold)as total_cost,
format(date,'mmmm')as month,
format(date,'yyyy')as year
from 
	Product_data d
join product_saless b on d.product_id =b.Product;

--Understand the Data Structure

select top 6* from Product_data ;

SELECT TOP 5* FROM product_saless;

SELECT TOP 5* FROM discount_data ;

--Calculate Total Revenue

SELECT 
	ROUND(SUM(D.Cost_Price*S.Units_Sold),2) AS TOTAL_REVENUE 
FROM 
	Product_data D
JOIN product_saless S ON D.Product_ID =S.Product

--Monthly Sales Trend and country

SELECT 
S.Country,
    FORMAT(S.Date, 'yyyy-MMMM') AS Month,
    (D.Cost_Price * S.Units_Sold) AS Monthly_Revenue
FROM 
    Product_data D
JOIN 
    product_saless S ON D.Product_ID = S.Product
order by MONTH

--MONTHLY BY TOTAL SALES TREND

SELECT 
    S.Country,
    FORMAT(S.Date, 'yyyy-MMMM') AS Month,
    ROUND(SUM(D.Cost_Price * S.Units_Sold), 2) AS Monthly_Revenue
FROM 
    Product_data D
JOIN 
    product_saless S ON D.Product_ID = S.Product
GROUP BY 
    S.Country ,FORMAT(S.DATE, 'yyyy-MMMM'), MONTH (S.DATE)
ORDER BY 
    MONTH(S.Date);


--Top 5 Products by Revenue

SELECT TOP 5 
	S.Product,
ROUND(SUM(D.Cost_Price * Units_Sold),2) AS REVENUE
FROM 
	Product_data D
JOIN product_saless S ON D.Product_ID =S.Product
GROUP BY 
	S.Product
ORDER BY REVENUE;


---Top Customers by Spending

SELECT 
	S.Customer_Type,
	ROUND(SUM(D.Cost_Price *S.Units_Sold),2) AS REVENUE
FROM Product_data D
JOIN
	product_saless S ON D.Product_ID = S.Product
GROUP BY S.Customer_Type
ORDER BY REVENUE DESC;


SELECT 
	S.Customer_Type,
	ROUND((D.Cost_Price *S.Units_Sold),2) AS REVENUE
FROM Product_data D
JOIN
	product_saless S ON D.Product_ID = S.Product
ORDER BY REVENUE DESC 


-- Category-Wise Revenue

SELECT 
	D.Category, D.Brand,
	ROUND(SUM(D.Cost_Price *S.Units_Sold),2) AS REVENUE
FROM Product_data D
JOIN
	product_saless S ON D.Product_ID = S.Product
GROUP BY D.Category ,D.Brand
ORDER BY REVENUE DESC 


--Repeat Customers

SELECT 
	S.Customer_Type
FROM 
	Product_data D
JOIN product_saless S ON D.Product_ID =S.Product
GROUP BY S.Customer_Type


---Average Order Value

SELECT  
 ROUND (AVG(AVERAGE),2) AS AVERAGE_VALUEA
    FROM
(
    SELECT 
        D.Category, 
        D.Brand,
        ROUND(AVG(D.Cost_Price * S.Units_Sold), 2) AS AVERAGE
    FROM Product_data D
    JOIN product_saless S ON D.Product_ID = S.Product
    GROUP BY D.Category, D.Brand
	)
	AS orderSum;


---same 2

SELECT		
	D.Category, 
    D.Brand,
ROUND(AVG(D.Cost_Price * S.Units_Sold), 2) AS AVERAGE
FROM 
	Product_data D
JOIN 
	product_saless S 
ON 
D.Product_ID = S.Product
GROUP BY 
	D.Category, D.Brand
ORDER BY 
	AVERAGE DESC