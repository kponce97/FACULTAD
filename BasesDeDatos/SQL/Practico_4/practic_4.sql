--	Parte I - Consultas 
--	1.  Listar el nombre de la ciudad y el nombre del país de todas las ciudades que 
--	pertenezcan a países con una población menor a 10000 habitantes. 
SELECT
	city.Name AS CityName,
	country.Name AS CountryName
FROM
	country
	INNER JOIN city ON country.Code = city.CountryCode
WHERE
	country.Code IN (
		SELECT
			Code
		FROM
			country
		WHERE
			Population < 10000
	);

--	2.  Listar todas aquellas ciudades cuya población sea mayor que la población promedio 
--	entre todas las ciudades. 
SELECT
	city.Name,
	city.Population
FROM
	city
WHERE
	Population > ALL (
		SELECT
			AVG(Population) AS AvgCitys
		FROM
			city
	);

--	3.  Listar todas aquellas ciudades no asiáticas cuya población sea igual o mayor a la 
--	población total de algún país de Asia. 
SELECT
	*
FROM
	country
WHERE
	(Continent != "Asia")
	AND (
		Population >= (
			SELECT
				min(Population)
			FROM
				country
			WHERE
				Continent = "Asia"
		)
	);

--	4.  Listar aquellos países junto a sus idiomas no oficiales, que superen en porcentaje de 
--	hablantes a cada uno de los idiomas oficiales del país. 
SELECT
	c.Name,
	cl.Language
FROM
	country c
	JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE
	cl.IsOfficial = 'F'
	AND cl.Percentage > ALL (
		SELECT
			Percentage
		FROM
			countrylanguage
		WHERE
			IsOfficial = 'T'
			AND cl.CountryCode = CountryCode
	);

--	5.  Listar (sin duplicados) aquellas regiones que tengan países con una superficie menor 
--	a 1000 km2 y exista (en el país) al menos una ciudad con más de 100000 habitantes. 
--	(Hint: Esto puede resolverse con o sin una subquery, intenten encontrar ambas 
--	respuestas). 
-- Con SUBQUERY
SELECT
	DISTINCT c.Region
FROM
	country c
	JOIN city cy ON c.Code = cy.CountryCode
WHERE
	c.SurfaceArea < 1000
	AND EXISTS (
		SELECT
			1
		FROM
			city ci
		WHERE
			ci.CountryCode = c.Code
			AND ci.Population > 100000
	);

-- Sin SUBQUERY
SELECT
	c.Region
FROM
	country c
	INNER JOIN city cy ON c.Code = cy.CountryCode
WHERE
	c.SurfaceArea < 1000
	AND (cy.Population > 100000);

--	6.  Listar el nombre de cada país con la cantidad de habitantes de su ciudad más 
--	poblada. (Hint: Hay dos maneras de llegar al mismo resultado. Usando consultas 
--	escalares o usando agrupaciones, encontrar ambas). 
-- Con AGRUPACIONES
SELECT
	c.Name,
	MAX(cy.Population) AS PopulationMaxCity
FROM
	country c
	JOIN city cy ON c.Code = cy.CountryCode
GROUP BY
	c.Name;

-- Con CONSULTAS ESCALARES 
SELECT
	Name,
	(
		SELECT
			DISTINCT Population
		FROM
			city
		WHERE
			city.CountryCode = country.Code
			AND city.Population >= ALL (
				SELECT
					Population
				FROM
					city
				WHERE
					city.CountryCode = country.Code
			)
	) AS country_more_population
FROM
	country;

--	7.  Listar aquellos países y sus lenguajes no oficiales cuyo porcentaje de hablantes sea 
--	mayor al promedio de hablantes de los lenguajes oficiales. 
SELECT
	c.Name,
	cl.Percentage
FROM
	country c
	JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE
	cl.IsOfficial = 'F'
	AND cl.Percentage > ALL (
		SELECT
			AVG(Percentage)
		FROM
			countrylanguage cl2
		WHERE
			cl2.IsOfficial = 'T'
			AND cl2.CountryCode = c.Code
	);

--	8.  Listar la cantidad de habitantes por continente ordenado en forma descendente. 
SELECT
	Continent,
	SUM(Population) AS TotalPopulation
FROM
	country
GROUP BY
	Continent
ORDER BY
	TotalPopulation ASC;

--	9.  Listar el promedio de esperanza de vida (LifeExpectancy) por continente con una 
--	esperanza de vida entre 40 y 70 años. 
SELECT
	Continent,
	AVG(LifeExpectancy) AS AVGLifeExpectancy
FROM
	country
GROUP BY
	Continent
HAVING
	AVG(LifeExpectancy) BETWEEN 40
	AND 70;

--	10. Listar la cantidad máxima, mínima, promedio y suma de habitantes por continente.
SELECT
	Continent,
	MAX(Population) AS MAXPopulation,
	MIN(Population) AS MINPopulation,
	AVG(Population) AS AVGPopulation,
	SUM(Population) AS SUMPopulation
FROM
	country
GROUP BY
	Continent;