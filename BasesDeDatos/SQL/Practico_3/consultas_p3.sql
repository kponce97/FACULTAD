-- 1.​ Lista el nombre de la ciudad, nombre del país, región y forma de gobierno de las 10 ciudades más pobladas del mundo.
SELECT
	cy.Name,
	c.Name,
	c.Region,
	c.GovernmentForm
FROM
	country c
	INNER JOIN city cy ON c.Code = cy.CountryCode
ORDER BY
	cy.Population DESC
LIMIT
	10;

-- 2.​ Listar los 10 países con menor población del mundo, junto a sus ciudades capitales (Hint: puede que uno de estos países no tenga ciudad capital asignada, en este caso deberá mostrar "NULL").
SELECT
	country.Name,
	city.Name,
	country.Population
FROM
	country
	LEFT JOIN city ON city.ID = country.Capital
ORDER BY
	country.Population ASC
LIMIT
	10;

-- 3.​ Listar el nombre, continente y todos los lenguajes oficiales de cada país. (Hint: habrá más de una fila por país si tiene varios idiomas oficiales).
SELECT
	c.Name,
	c.Continent,
	cl.Language
FROM
	country c
	INNER JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE
	cl.IsOfficial = 'T';

-- 4.​ Listar el nombre del país y nombre de capital, de los 20 países con mayor superficie del mundo.
SELECT
	country.Name AS CountryName,
	city.Name AS CapitalName,
	country.Population
FROM
	country
	LEFT JOIN city ON city.ID = country.Capital
ORDER BY
	country.SurfaceArea DESC
LIMIT
	20;

-- 5.​ Listar las ciudades junto a sus idiomas oficiales (ordenado por la población de la ciudad) y el porcentaje de hablantes del idioma.
SELECT
	city.Name AS CityName,
	countrylanguage.Language AS CityLenguage,
	countrylanguage.Percentage AS CityPercentage
FROM
	city
	JOIN countrylanguage ON (
		city.CountryCode = countrylanguage.CountryCode
		AND countrylanguage.IsOfficial = 'T'
	)
ORDER BY
	city.Population DESC;

-- 6.​ Listar los 10 países con mayor población y los 10 países con menor población (que tengan al menos 100 habitantes) en la misma consulta.
(
	SELECT
		Name,
		Population
	FROM
		country
	WHERE
		Population >= 100 -- Al menos 100 habitantes
	ORDER BY
		Population ASC -- Mayor poblacion
	LIMIT
		10
)
UNION
(
	SELECT
		Name,
		Population
	FROM
		country
	WHERE
		Population >= 100 -- Al menos 100 habitantes
	ORDER BY
		Population DESC -- Menor poblacion
	LIMIT
		10
);

-- 7.​ Listar aquellos países cuyos lenguajes oficiales son el Inglés y el Francés (hint: no debería haber filas duplicadas).
SELECT
	DISTINCT country.Name
FROM
	country
	JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
	AND countrylanguage.IsOfficial = 'T'
	AND (
		countrylanguage.Language = "English"
		OR countrylanguage.Language = "France"
	);

-- 8.​ Listar aquellos países que tengan hablantes del Inglés pero no del Español en su población.
SELECT
	DISTINCT c.Name
FROM
	country c
	JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE
	cl.Language = 'English'
	AND c.Code NOT IN (
		SELECT
			CountryCode
		FROM
			countrylanguage
		WHERE
			Language = 'Spanish'
	);

-- ? Parte 2
-- 1.​ ¿Devuelven los mismos valores las siguientes consultas? --> Si 
-- ¿Por qué? --> Con agregar la condicion AND country.Name = 'Argentina' 
SELECT
	city.Name,
	country.Name
FROM
	city
	INNER JOIN country ON city.CountryCode = country.Code
	AND country.Name = 'Argentina';

SELECT
	city.Name,
	country.Name
FROM
	city
	INNER JOIN country ON city.CountryCode = country.Code
WHERE
	country.Name = 'Argentina';

-- 2.​ ¿Y si en vez de INNER JOIN fuera un LEFT JOIN?

/* 
	No devuelve el mismo resultado.
	Condición en ON: devuelve todas las ciudades, con info de Argentina o NULL.
	Condición en WHERE: devuelve solo las ciudades con país Argentina (pierde efecto LEFT JOIN).
 */