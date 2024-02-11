/* Write SQL code to find the number of occurence of letter 'E' in 
   Name column without regex */
SELECT 
    Name,
    (LENGTH(Name) - LENGTH(REPLACE(Name, 'E', ''))) AS E_Count
FROM 
    YourTableName;

    