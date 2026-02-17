-- taking a look through every table fully to check for upload errors first
SELECT *
FROM data_dictionary

SELECT *
FROM order_item_refunds

SELECT *
FROM order_items

SELECT *
FROM orders

SELECT *
FROM products

SELECT * 
FROM website_pageviews

SELECT * 
FROM website_sessions

-- Checking how many records there are overall
SELECT COUNT (*) AS total_orders
FROM orders;

SELECT COUNT (*) AS total_order_items
FROM order_items;

SELECT COUNT (*) AS total_order_item_refunds
FROM order_item_refunds;

-- Checking time period of data in orders
SELECT
	MIN(created_at) AS earliest_order,
	MAX(created_at) AS latest_order
FROM orders;

-- cogs means Cost of Goods so need to subtract it from price
-- how much made in total (1216139.5753231)
SELECT
	SUM(price_usd) AS gross_profit,
	SUM(cogs_usd) AS total_cost,
	SUM(price_usd) -SUM(cogs_usd) AS total_profit
FROM orders;

-- see what tables can be joined together, replacing primary_product_id with the product name in the orders table using  the products table
SELECT 
    o.order_id,
    o.created_at,
    p.product_name,
    o.items_purchased,
    o.price_usd
FROM orders o
JOIN products p 
    ON o.primary_product_id = p.product_id;

-- can't see product_id 5 so doing a count of items sold per product_id
	SELECT 
    OI.product_id,
    P.product_name,
    COUNT(OI.order_item_id) AS total_sold_items
FROM order_items OI
JOIN products P 
    ON OI.product_id = P.product_id
GROUP BY OI.product_id, P.product_name
ORDER BY OI.product_id;
