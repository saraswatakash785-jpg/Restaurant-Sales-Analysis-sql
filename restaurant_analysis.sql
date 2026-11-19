-- Restaurant Sales Analysis (MySQL)
-- Dataset: Restaurant Orders (Maven Analytics), Jan-Mar 2023
-- Tables: menu_items (menu_item_id, item_name, category, price)
--         order_details (order_details_id, order_id, order_date, order_time, item_id)
-- Run create_restaurant_db.sql first; it creates the restaurant_db database.

USE restaurant_db;

-- Q1. How many unique orders did the restaurant receive during the entire period?
Select count(distinct order_id)
from order_details;

-- Q2. List all menu items with their category and price. Also, how many items are in each category?
Select
    item_name,
    category,
    price
From menu_items;

SELECT
    category,
    COUNT(menu_item_id) As items_each_category
FROM menu_items
GROUP BY category;

-- Q3. Which are the 5 most expensive menu items? Show the item name, category, and price.
SELECT
    item_name, category, price
FROM
    menu_items
ORDER BY price DESC
LIMIT 5;

-- Q4. How many items have we sold from each food category? Which categories are most popular?
SELECT
    menu_items.category,
    Count(order_details.item_id) As items_sold
From order_details
JOIN menu_items
    on order_details.item_id = menu_items.menu_item_id
group by menu_items.category
Order by items_sold DESC;

-- Q5. Which 10 menu items have been ordered the most? Show the item name and total quantity sold.
Select
    menu_items.item_name,
    COUNT(order_details.item_id) As total_quantity_sold
FROM order_details
Join menu_items
    ON order_details.item_id = menu_items.menu_item_id
Group by menu_items.item_name
Order by total_quantity_sold desc
Limit 10;

-- Q6. How much revenue has each food category generated? Rank the categories from highest to lowest.
SELECT
    menu_items.category,
    Round( SUM(menu_items.price),2) AS revenue_generated
FROM menu_items
JOIN order_details
    ON menu_items.menu_item_id = order_details.item_id
GROUP BY menu_items.category
ORDER BY revenue_generated DESC;

-- Q7. Total number of orders and total revenue generated on each day.
Select
   COUNT(DISTINCT order_details.order_id) AS Total_Num_of_orders,
    order_details.order_date,
   ROUND (SUM(menu_items.price),2) AS Total_revenue_generated
From
    order_details
        JOIN
    menu_items ON order_details.item_id = menu_items.menu_item_id
GROUP BY order_details.order_date
Order by order_details.order_date;

-- Q8. At what times of the day are customers ordering the most? Break the orders down by hour.
Select
    HOUR(order_time) As order_hour,
    COUNT(DISTINCT order_id) As total_orders
FROM order_details
GROUP BY HOUR(order_time)
ORDER BY order_hour desc;

-- Q8 (busiest hours first): same query sorted by number of orders
Select
    HOUR(order_time) As order_hour,
    COUNT(DISTINCT order_id) As total_orders
FROM order_details
GROUP BY HOUR(order_time)
ORDER BY total_orders desc;

-- Q9. Which menu items have generated more than $2,000 in total revenue?
SELECT
    menu_items.item_name,
    menu_items.category,
    COUNT(order_details.item_id) AS quantity_sold,
    Round(SUM(menu_items.price),2) AS total_revenue
FROM menu_items
Join order_details
    ON menu_items.menu_item_id = order_details.item_id
GROUP BY
    menu_items.item_name,
    menu_items.category
Having SUM(menu_items.price) > 2000
ORDER BY total_revenue DESC;

-- Q10. Top 3 most-ordered menu items within each food category.
WITH item_sales AS
(Select menu_items.category,
        menu_items.item_name,
        COUNT(order_details.item_id) AS quantity_sold
    From menu_items
    Join order_details
        ON menu_items.menu_item_id = order_details.item_id
    Group by
        menu_items.category,
        menu_items.item_name),
ranked_items AS
(SELECT category, item_name, quantity_sold,
        RANK() OVER (
            Partition by category
            ORDER BY quantity_sold DESC
        ) AS item_rank
    FROM item_sales )
SELECT category, item_name, quantity_sold, item_rank
From ranked_items
Where item_rank <= 3
Order by category, item_rank;

-- Q11. Total revenue for every month, ranked from highest to lowest.
WITH monthly_revenue As
(Select Month(order_date) AS order_month,
        SUM(menu_items.price) AS total_revenue
    From order_details
    JOIN menu_items
        ON order_details.item_id = menu_items.menu_item_id
    Group by Month(order_date))
SELECT order_month,
    ROUND(total_revenue, 2) AS total_revenue,
    RANK()  Over(ORDER BY total_revenue desc) AS revenue_rank
From monthly_revenue
ORDER BY revenue_rank;
