WITH quarter_volume AS (
    SELECT
        c.algorithm, 
        quarter(dt) as q,
        sum(t.volume) as volume
    FROM coins c
    LEFT JOIN transactions t 
        ON c.code = t.coin_code
    WHERE 1=1
        AND year(dt) = 2020
    GROUP BY
        1,2
)

SELECT
       c.algorithm,
       qv1.volume as transactions_Q1,
       qv2.volume as transactions_Q2,
       qv3.volume as transactions_Q3,
       qv4.volume as transactions_Q4
FROM coins c 
LEFT JOIN quarter_volume qv1 
    ON c.algorithm = qv1.algorithm
    AND qv1.q = 1  
LEFT JOIN quarter_volume qv2 
    ON c.algorithm = qv2.algorithm
    AND qv2.q = 2  
LEFT JOIN quarter_volume qv3 
    ON c.algorithm = qv3.algorithm
    AND qv3.q = 3
LEFT JOIN quarter_volume qv4 
    ON c.algorithm = qv4.algorithm
    AND qv4.q = 4
    
WHERE c.code NOT LIKE 'DOGE'
ORDER BY 1
;
