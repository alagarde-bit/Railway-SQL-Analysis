-- If count of input records are EVEN then keep as s and if count of input records are ODD then flip the values in column 2


-- Common Table Expression (CTE) for Ranking and Counting
WITH RankedData AS (
    -- Select all columns, a row number, and a total count of rows
    SELECT 
        *,
        ROW_NUMBER() OVER (ORDER BY [YourPrimaryKeyOrOtherColumn]) AS rn, -- Assigns a unique row number to each row
        COUNT(*) OVER() AS total_count,
        Column2 -- Counts the total number of rows in the table
    FROM 
        YourTable
),
FlippedData AS (
    -- CTE to flip the values based on the row count being odd or even
    SELECT rn,
        CASE 
            WHEN MOD(total_count, 2) != 0 AND MOD(rn, 2) = 0 THEN 
                LEAD(Column2, 1) OVER (ORDER BY [YourPrimaryKeyOrOtherColumn]) -- Get next row's value for even row numbers when total count is odd
            WHEN MOD(total_count, 2) != 0 AND MOD(rn, 2) != 0 THEN 
                LAG(Column2, 1) OVER (ORDER BY [YourPrimaryKeyOrOtherColumn]) -- Get previous row's value for odd row numbers when total count is odd
            ELSE 
                Column2 -- Keep the value as is when total count is even
        END AS Column2
    FROM 
        RankedData
)
-- Final SELECT to display the results
SELECT 
    rn,
    Column2
FROM 
    FlippedData;
