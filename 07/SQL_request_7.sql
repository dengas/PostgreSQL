№2b,c Иерархический (рекурсивный) запрос
WITH RECURSIVE temp1 AS (
    SELECT 
        id,
        name AS "студент",
        роль,
        уровень,
        CAST(name AS TEXT) AS "путь от лидера"
    FROM employees 
    WHERE parent_id IS NULL  
    UNION ALL
    SELECT 
        e.id,
        e.name,
        e.роль,
        e.уровень,
        CAST(temp1."путь от лидера" || ' -> ' || e.name AS TEXT)
    FROM employees e
    JOIN temp1 ON e.parent_id = temp1.id
)
SELECT студент, роль, уровень, "путь от лидера" 
FROM temp1
ORDER BY уровень, id