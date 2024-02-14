-- Day 4 write a query that retrieves the product name and price 
-- formatted as a string with two decimal places and a dollar sign (E.G, "$10.99). 
-- However if the price is 0, output should be "FREE"

SELECT 
    prd_name,
    CASE
        WHEN prd_price = 0 THEN 'FREE'
        ELSE CONCAT('$', FORMAT(prd_price, 2))
    END AS formatted_price
FROM 
    product;