--? JOIN : Combina dos tablas en una.
-- OUTER , es opcional y no tiene efecto.
--			- INNER JOIN		-> Solo coincidencias, valores
--			- LEFT OUTER JOIN	-> Todos valores de la table de la izquierda + coincidencias de la tabla de la derecha
--			- RIGHT OUTER JOIN	-> Todos de la derecha + coincidencias, Idem
--			- INNER FULL		-> todos de ambos lados
-- * SELECT column FROM table_1 [INNER, LEFT, RIGHT, subquery1 UNION subquery2] table_2 ON join_conditon;
-- INNER JOIN
SELECT columnas
FROM tabla1
INNER JOIN tabla2 ON tabla1.col = tabla2.col;

-- LEFT OUTER JOIN
SELECT columnas
FROM tabla1
LEFT JOIN tabla2 ON tabla1.col = tabla2.col;

-- RIGHT OUTER JOIN
SELECT columnas
FROM tabla1
RIGHT JOIN tabla2 ON tabla1.col = tabla2.col;

-- FULL OUTER JOIN
SELECT ... FROM A FULL JOIN B ON join_condition


SELECT columnas
FROM tabla1
LEFT JOIN tabla2 ON tabla1.col = tabla2.col
UNION
SELECT columnas
FROM tabla1
RIGHT JOIN tabla2 ON tabla1.col = tabla2.col;

--? Operaciones de Conjuntos
--			UNION
--			INTERSECT
--			EXCEPT
SELECT ... query_1 [UNION, INTERSECT, EXCEPT] query_2
