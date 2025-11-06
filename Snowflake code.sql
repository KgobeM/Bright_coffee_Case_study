--- Check day classification---
SELECT product_category,

        DAYNAME (transaction_date) AS day_name,
        CASE 
        WHEN day_name IN ('Sun', 'Sat') THEN 'weekend'
        ELSE 'Weekday'
        END AS day_classification,
        
---Check month and time---
        
        MONTHNAME(transaction_date) AS month_name, 

        CASE    
            WHEN transaction_time BETWEEN '05:00:00' AND '12:00:00' THEN '5am-12am - Morning'
            WHEN transaction_time BETWEEN '13:00:00' AND '15:59:59' THEN '13pm-Afternoon'
            WHEN transaction_time >= '18:00:00' THEN 'Evening'
            END AS day_classification,
            
        HOUR(transaction_time) AS hour_of_day,
        
---Date of category---
       store_location,
       product_category,
       product_detail,
       product_type,

       ---ID's---
       
    COUNT(DISTINCT transaction_id) AS number_of_sales,
    SUM(transaction_qty*unit_price) AS revenue,
    
    CASE
        WHEN revenue = 0 THEN 'None Spender'
        WHEN revenue BETWEEN 1 AND 50 THEN 'Low Spender'
        WHEN revenue >100 THEN 'High Spender'
        END AS spend_bucket, 
        
FROM sales.retail.bright_coffee
GROUP BY ALL;
