-- Day 3 Given num_ID and Value Columns, write a query that concatenates the values of the 'Value' column, Even or Odd depending on the number

-- Start of the recursive Common Table Expression (CTE)
WITH RECURSIVE NumberSplit AS (
    -- Initial query: This part gets the first digit of each 'Value' and determines if it's even or odd
    SELECT
        num_ID,  -- Select the identifier
        CAST(SUBSTRING(Value, 1, 1) AS INT) AS Digit,  -- Extract the first digit and convert to integer
        CASE  -- Determine if the digit is even or odd
            WHEN CAST(SUBSTRING(Value, 1, 1) AS INT) % 2 = 0 THEN 'even'  -- If divisible by 2, it's even
            ELSE 'odd'  -- Otherwise, it's odd
        END AS EvenOdd,
        SUBSTRING(Value, 2, LEN(Value)) AS RemainingValue,  -- Remove the first digit from 'Value'
        1 as Iteration  -- Start an iteration counter
    FROM
        YourTable  -- From your source table

    UNION ALL

    -- Recursive query: This part processes the remaining digits of each 'Value'
    SELECT
        ns.num_ID,  -- Select the identifier
        CAST(SUBSTRING(ns.RemainingValue, 1, 1) AS INT),  -- Extract the next digit and convert to integer
        CASE  -- Determine if this next digit is even or odd
            WHEN CAST(SUBSTRING(ns.RemainingValue, 1, 1) AS INT) % 2 = 0 THEN 'even'  -- If divisible by 2, it's even
            ELSE 'odd'  -- Otherwise, it's odd
        END,
        SUBSTRING(ns.RemainingValue, 2, LEN(ns.RemainingValue)),  -- Remove the processed digit from 'RemainingValue'
        ns.Iteration + 1  -- Increment the iteration counter
    FROM
        NumberSplit ns  -- Recurse on the CTE
    WHERE
        ns.RemainingValue <> ''  -- Continue until no more digits are left
)

-- Final SELECT statement to aggregate the results
SELECT 
    num_ID,  -- Select the identifier
    STRING_AGG(CAST(Digit AS VARCHAR) + EvenOdd, '') AS ConcatenatedValue  -- Concatenate digits with 'even'/'odd' labels
FROM 
    NumberSplit  -- From the CTE
GROUP BY 
    num_ID;  -- Group by the identifier to aggregate each 'Value'
