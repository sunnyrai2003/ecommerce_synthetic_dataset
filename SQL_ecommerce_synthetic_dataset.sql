SELECT * FROM geeksforgeeks.ecommerce_synthetic_dataset;
-- [geeksforgeeks databse name and the table name is ecommerce_synthetic_dataset]


-- 1. List all users and their purchase details:

SELECT 
    Userid,
    username,
    productid,
    productname,
    price,
    purchasedate
FROM
    geeksforgeeks.ecommerce_synthetic_dataset;

-- 2. Find all products in the "Electronics" category:

SELECT 
    userid, username, productname
FROM
    geeksforgeeks.ecommerce_synthetic_dataset
WHERE
    Category = 'Electronics'; 

-- 3. Count the number of users from each country:

SELECT 
    COUNT(username), country
FROM
    geeksforgeeks.ecommerce_synthetic_dataset
GROUP BY country;

-- 4.Find users who signed up after January 1, 2022:

SELECT 
    userid, username
FROM
    geeksforgeeks.ecommerce_synthetic_dataset
WHERE
    SignUpDate > '01-01-2022';

-- 5.Get the total revenue from all purchases, 
--  revenu == total_amount..

SELECT 
    SUM(totalamount) AS Totalrevenu
FROM
    geeksforgeeks.ecommerce_synthetic_dataset;

-- 6. Find the average price of products in each category:

SELECT 
    Category, AVG(price) AS price_avg
FROM
    geeksforgeeks.ecommerce_synthetic_dataset
GROUP BY Category;
 
-- 7.List all users who have applied a discount in their purchases: 

SELECT 
    userid, username, TotalAmount, DiscountRate
FROM
    geeksforgeeks.ecommerce_synthetic_dataset
WHERE
    HasDiscountApplied = 'true'; 
    
-- 8.Find the top 5 most expensive products:

SELECT 
    username, productname, price, country
FROM
    geeksforgeeks.ecommerce_synthetic_dataset
ORDER BY price DESC
LIMIT 5; 

-- 9.Get the total quantity sold for each product: 

SELECT 
    ProductID, productname, SUM(Quantity) total_quantity
FROM
    geeksforgeeks.ecommerce_synthetic_dataset
GROUP BY Productname , ProductID;

-- 10.Calculate the total discount given for all purchases: 

SELECT 
    SUM(totalamount / Discountrate) * 100 AS total_discount
FROM
    geeksforgeeks.ecommerce_synthetic_dataset;
    
--  check reviwrate for each product

select productname, count(ReviewScore) from geeksforgeeks.ecommerce_synthetic_dataset
group by ProductName;

-- 11.Find users who spent more than the average total amount:

SELECT 
    username, TotalAmount, productname
FROM
    geeksforgeeks.ecommerce_synthetic_dataset
WHERE
    totalamount > (SELECT 
            AVG(totalamount) AS avg_amount
        FROM
            geeksforgeeks.ecommerce_synthetic_dataset);

-- 12.Get products that are priced above the average price for their category:

SELECT 
    ProductID, ProductName, Price, Category
FROM
    geeksforgeeks.ecommerce_synthetic_dataset AS d1
WHERE
    Price > (SELECT 
            AVG(Price)
        FROM
            geeksforgeeks.ecommerce_synthetic_dataset AS d2
        WHERE
            d1.Category = d2.Category);

-- 13.List all users who have a review score below the average review score:

SELECT 
    userid, username, ReviewScore
FROM
    geeksforgeeks.ecommerce_synthetic_dataset
WHERE
    ReviewScore < (SELECT 
            AVG(ReviewScore)
        FROM
            geeksforgeeks.ecommerce_synthetic_dataset);

-- 14. Find the highest-rated product in each category: 

SELECT 
    category, productname, reviewscore
FROM
    geeksforgeeks.ecommerce_synthetic_dataset a1
WHERE
    reviewscore = (SELECT 
            MAX(reviewscore)
        FROM
            geeksforgeeks.ecommerce_synthetic_dataset a2
        GROUP BY Category
        HAVING a1.Category = a2.Category);

-- using window function.. 
select  ProductName,category,max(reviewscore) over (partition by category) from geeksforgeeks.ecommerce_synthetic_dataset;

-- 15.Get the cumulative revenue for each user ordered by purchase date:

select userid,username,purchasedate,sum(totalamount) over (partition by userid order by purchasedate) as cumulative_revenu from geeksforgeeks.ecommerce_synthetic_dataset;

-- [16.Find the users who made the largest purchase in their country: 
 
-- select country,userid,username,max(TotalAmount) over (partition by country) from geeksforgeeks.ecommerce_synthetic_dataset

-- select country,userid,username , max(totalamount) from geeksforgeeks.ecommerce_synthetic_dataset
-- group by country,userid,username;]

-- Rank users based on their total purchases within each country:

select userid,username,country,totalamount,rank() over (partition by country  order by totalamount desc) as rank_value from geeksforgeeks.ecommerce_synthetic_dataset;

-- Calculate the percentage of total revenue contributed by each user: 

-- [SELECT UserID, UserName, 
--        (SUM(TotalAmount) * 100 / (SELECT SUM(TotalAmount) FROM geeksforgeeks.ecommerce_synthetic_dataset)) AS RevenuePercentage
-- FROM geeksforgeeks.ecommerce_synthetic_dataset
-- GROUP BY UserID, UserName;]

-- Find the most popular product based on the number of purchases:

SELECT 
    productid, productname, COUNT(*) AS purchescount
FROM
    geeksforgeeks.ecommerce_synthetic_dataset
GROUP BY productid , productname
ORDER BY purchescount DESC
LIMIT 1;

-- Get the average session duration for each device type:
-- using window function.. 

select userid,username,DeviceType,avg(SessionDuration) over (partition by DeviceType) as avg_session_duration from geeksforgeeks.ecommerce_synthetic_dataset;

 

