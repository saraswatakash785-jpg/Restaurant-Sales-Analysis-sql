# Restaurant Sales Analysis (SQL)

A SQL project in MySQL that answers 11 business questions about a restaurant's orders, revenue, menu items and busy hours. The full write-up with every query and result is in [Restaurant Sales Analysis PDF.pdf](Restaurant%20Sales%20Analysis%20PDF.pdf).

## Dataset

- Source: Restaurant Orders dataset from Maven Analytics
- Two tables: `order_details` and `menu_items`. `menu_item_id` is the primary key of `menu_items`, and `item_id` in `order_details` is the foreign key that links to it.
- 5,370 unique orders, from January to March 2023
- 137 of the 12,234 order lines have no item ID, so they do not match a menu item. The JOIN queries leave them out of the revenue and item counts, while the hours query (Q8) counts all orders.
- 32 menu items in 4 categories: American (6), Asian (8), Mexican (9) and Italian (9)
- Tool: MySQL Workbench

## Questions answered

1. How many unique orders did the restaurant receive?
2. List all menu items with their category and price, and the number of items in each category.
3. Which are the 5 most expensive menu items?
4. How many items were sold from each category?
5. Which 10 menu items were ordered the most?
6. How much revenue did each category generate?
7. What were the orders and revenue on each day?
8. At what times of the day do customers order the most?
9. Which menu items generated more than $2,000 in revenue?
10. What are the top 3 most-ordered items within each category?
11. What was the revenue in each month, ranked from highest to lowest?

## SQL concepts used

`JOIN`, `GROUP BY`, `HAVING`, `COUNT(DISTINCT ...)`, `SUM`, `ROUND`, `ORDER BY`, `LIMIT`, `HOUR()`, `MONTH()`, CTEs (`WITH`) and the `RANK()` window function.

## What I found

- Total revenue across the three months was **$159,217.90** from 5,370 orders.
- **Italian** was the top revenue category ($49,462.70), followed by Asian ($46,720.65), Mexican ($34,796.80) and American ($28,237.75).
- **Asian** was the category with the most items sold (3,470), ahead of Italian (2,948), Mexican (2,945) and American (2,734).
- The most-ordered items were Hamburger (622), Edamame (620) and Korean Beef Bowl (588).
- **Korean Beef Bowl** earned the most revenue of any item ($10,554.60), followed by Spaghetti & Meatballs ($8,436.50), Tofu Pad Thai ($8,149.00), Cheeseburger ($8,132.85) and Hamburger ($8,054.90).
- Top 3 items in each category by number of orders:
  - American: Hamburger (622), Cheeseburger (583), French Fries (571)
  - Asian: Edamame (620), Korean Beef Bowl (588), Tofu Pad Thai (562)
  - Italian: Spaghetti & Meatballs (470), Eggplant Parmesan (420), Spaghetti (367)
  - Mexican: Steak Torta (489), Chips & Salsa (461), Chicken Burrito (455)
- **March** was the best month ($54,610.60), then January ($53,816.95) and February ($50,790.35).
- Busiest hours by number of orders: 12 PM (647 orders), then 5 PM (623) and 6 PM (596). The 1 PM hour had 595. Lunch and early evening are both busy, and the 12 PM hour is the single busiest.

## Files

| File | What it is |
|---|---|
| `Restaurant Sales Analysis PDF.pdf` | the full project with all queries and results |
| `restaurant_analysis.sql` | my 11 queries in one script |
| `create_restaurant_db.sql` | setup script that comes with the Maven Analytics dataset (not written by me). It creates the `restaurant_db` database and loads the data in MySQL |
| `menu_items.csv` | the 32 menu items |
| `order_details.csv` | every order line (12,234 rows) |
| `README.md` | this summary |

## Author

Akash Saraswat
[LinkedIn](https://www.linkedin.com/in/akash-saraswat-085533273/) | saraswatakash785@gmail.com
