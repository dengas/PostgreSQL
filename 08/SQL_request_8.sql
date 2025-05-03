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

№2b
CREATE OR REPLACE FUNCTION getStudentHierarchyByLevel(
    p_manager_id INTEGER,
    p_level INTEGER
)
RETURNS TABLE (
    "студент" TEXT,
    "роль" TEXT,
    "уровень" INTEGER,
    "путь от лидера" TEXT
) AS $$
BEGIN
    RETURN QUERY
    WITH RECURSIVE employee_hierarchy AS (
        -- Базовый случай: начальный менеджер (или все корневые элементы, если p_manager_id = null)
        SELECT 
            e.id,
            e.name,
            e.роль,
            e.уровень,
            e.name::TEXT AS path,
            1 AS hierarchy_depth
        FROM employees e
        WHERE 
            (p_manager_id IS NULL AND e.parent_id IS NULL) OR
            (p_manager_id IS NOT NULL AND e.id = p_manager_id)
        
        UNION ALL
        
        -- Рекурсивный случай: подчиненные
        SELECT 
            e.id,
            e.name,
            e.роль,
            e.уровень,
            (eh.path || ' -> ' || e.name)::TEXT,
            eh.hierarchy_depth + 1
        FROM employees e
        JOIN employee_hierarchy eh ON e.parent_id = eh.id
        WHERE p_level IS NULL OR eh.hierarchy_depth < p_level  -- Продолжаем рекурсию только если не достигли нужного уровня
    )
    SELECT 
        eh.name::TEXT AS "студент",
        eh.роль::TEXT AS "роль",
        eh.уровень AS "уровень",
        eh.path::TEXT AS "путь от лидера"
    FROM employee_hierarchy eh
    WHERE 
        p_level IS NULL OR  -- Если уровень не указан, возвращаем всех
        eh.hierarchy_depth = p_level  -- Иначе только указанный уровень
    ORDER BY eh.уровень, eh.hierarchy_depth, eh.id;
END;
$$ LANGUAGE plpgsql;