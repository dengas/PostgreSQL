№2a
CREATE OR REPLACE FUNCTION getStudentHierarchy(p_manager_id INT DEFAULT NULL)
RETURNS TABLE (
    студент TEXT,
    роль TEXT,
    уровень INT,
    "путь от менеджера" TEXT
) AS $$
WITH RECURSIVE temp1 AS (
    SELECT 
        id,
        name AS "студент",
        роль,
        уровень,
        CAST(name AS TEXT) AS "путь от менеджера"
    FROM employees 
    WHERE id = COALESCE(p_manager_id, (SELECT id FROM employees WHERE parent_id IS NULL LIMIT 1))
    
    UNION ALL

    SELECT 
        e.id,
        e.name,
        e.роль,
        e.уровень,
        CAST(temp1."путь от менеджера" || ' -> ' || e.name AS TEXT)
    FROM employees e
    JOIN temp1 ON e.parent_id = temp1.id
)
SELECT студент, роль, уровень, "путь от менеджера"
FROM temp1
ORDER BY уровень, id;
$$ LANGUAGE sql;