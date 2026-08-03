--? Consultas Anidadas
-- * Una SUBQUERY es una consulta anidada en un WHERE, FROM, una COLUMNA (Subquery escalar)

SELECT ...
FROM ...
WHERE [SUBQUERY]

SELECT ...
FROM [SUBQUERY]
WHERE ..

SELECT ...,[SUBQUERY],...
FROM ...
WHERE ...


--? SET MEMBERSHIP --> "Pertenece a un conjunto" [IN | NOT IN]

SELECT ...
FROM ...
WHERE (columns) [IN | NOT IN] [SUBQUERY]
-- Ejemplo: devuelve los códigos de países donde se habla inglés, y la consulta principal lista esos países.
	SELECT Name
	FROM country
	WHERE Code IN (
	  SELECT CountryCode
	  FROM countrylanguage
	  WHERE Language = 'English'
	);


SELECT ...
FROM ...
WHERE (columns) [IN | NOT IN] [ENUMERATION] -- Numeracion explicita
-- Ejemplo: Muestra los países cuyo continente es Asia, Europa o África.
SELECT Name
FROM country
WHERE Continent IN ('Asia', 'Europe', 'Africa');


--? SET COMPARISON --> Compara una fila o conjunto de valores con el resultado de una subconsulta.
SELECT ...
FROM ...
WHERE (columns) comp [SOME | ALL] [SUBQUERY]
-- comp := <, <=, >, >=, <>, =
-- SOME : Se cumple si la condicion es verdadera para aglún valor.
-- ALL : La condicion debe cumplirse para cada valor del conjunto.
-- Ej:
	WHERE salario > ALL (SELECT salario FROM empleados WHERE departamento = 'Ventas')
	-- * 🡺 Devuelve empleados con salario mayor que todos los del depto. de Ventas.
	WHERE edad < SOME (SELECT edad FROM clientes WHERE pais = 'México')
	--* 🡺 Devuelve filas con edad menor que al menos un cliente de México.


--? EMPTY REALTIONS

SELECT ...
FROM ...
WHERE [EXISTS | NOT EXISTS] [SUBQUERY]

-- EXISTS : Devuelve TRUE si la subconsulta devuelve al menos una fila.
SELECT Name
FROM country
WHERE EXISTS (
  SELECT 1
  FROM countrylanguage
  WHERE country.Code = countrylanguage.CountryCode
  AND Language = 'English'
);
--* 🡺 Devuelve países donde se habla inglés.

-- NOT EXISTS: Devuelve TRUE si la subconsulta no devuelve ninguna fila.
SELECT Name
FROM country
WHERE NOT EXISTS (
  SELECT 1
  FROM countrylanguage
  WHERE country.Code = countrylanguage.CountryCode
  AND Language = 'Spanish'
);
--* 🡺 Devuelve países donde no se habla español.

--? CORRELATED SUBQUERIS
-- El Alias de una tabla se denomina NOMBRE DE CORRELACION , SQL permite referenciar un NC de query a una 
-- subquery (SUBQUERY REALCIONADA) anidada en el WHERE, y se 

-- Subqueris en un FROM no pueden usar NOMBRES de CORRELACION de otras tablas en el FROM.


--? SCALAR SUBQUERIS
-- 		Son subconsultas que devuelven un solo valor (una fila y una columna).
-- 🔹 Se usan donde iría un valor escalar, por ejemplo:
			-- En el SELECT
			-- En el WHERE
			-- En el SET de un UPDATE

	SELECT Name,
  		(SELECT AVG(Population) FROM country) AS AvgPop
	FROM country;
--	🔍 Devuelve cada país junto con el promedio de población global.
--	La subconsulta devuelve un único valor → ✅ escalar.


--? COMMON TABLE EXPRESSIONS (CTE)
-- Una CTE es una consulta temporal y nombrada, definida al principio con WITH,
-- que puede ser reutilizada en la consulta principal

WITH cte_nombre AS (
  SELECT ...
	)
SELECT *
FROM cte_nombre
WHERE ...;

-- Ejemplo: países con más de 200 millones de habitantes
		WITH grandes AS (
		  SELECT Name, Population
		  FROM country
		  WHERE Population > 200000000
		)

		SELECT *
		FROM grandes;

	----------------------
--	| Cláusula | Cuándo se usa          | Actúa sobre...            |
--	| -------- | ---------------------- | ------------------------- |
--	| `WHERE`  | Antes del `GROUP BY`   | Filas individuales        |
--	| `HAVING` | Después del `GROUP BY` | Grupos de datos agregados |
	----------------------

--? AGREGACIONES: SQL provee un conjunto de funciones de agregacion. Una funcion de
--?				  agregacion toma una coleccion de valores y retorna un solo valor.
--?				  Algunas funciones son:
--?				  		COUNT() → Cuenta filas
--?				  		SUM() → Suma valores
--?				  		AVG() → Promedio
--?				  		MAX() → Valor máximo
--?				  		MIN() → Valor mínimo
-- Sintaxis:
	SELECT select_expr
	FROM table_expr
	[WHERE where_condition]
	[GROUP BY {col|alias|pos}]
	[HAVING where_condition]
	[ORDER BY order_expr]

-- ✅ Ejemplo:
		SELECT Continent, COUNT(*) AS num_paises
		FROM country
		GROUP BY Continent;
--	🔍 Cuenta cuántos países hay por continente.

--? GROUP BY: Es una cláusula en SQL que se usa para agrupar filas que tienen los mismos valores en una o más columnas.
--?           Se usa junto con funciones de agregación (COUNT, SUM, AVG, etc.) para obtener resúmenes por grupo.
-- ✅ Ejemplo:
		SELECT Continent, COUNT(*) AS TotalPaises
		FROM country
		GROUP BY Continent;
--	🔍 Agrupa los países por continente y cuenta cuántos hay en cada uno.
--? HAVING: HAVING se usa para filtrar los resultados después de hacer un GROUP BY, es decir, filtra grupos, no filas 
--?         individuales (eso lo hace WHERE).
-- Ejemplo:
		SELECT region, SUM(monto) AS TotalVentas
		FROM ventas
		GROUP BY region
		HAVING SUM(monto) > 10000;
--	🔸 Muestra solo las regiones donde las ventas totales superan 10,000.