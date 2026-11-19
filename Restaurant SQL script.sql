-- Question 7-Show me the total number of orders and total revenue generated on each day. I want to understand how our sales are performing day by day?

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