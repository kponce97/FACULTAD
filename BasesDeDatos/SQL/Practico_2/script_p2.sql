CREATE DATABASE world;

-- CREATE DATABASE `world` DEFAULT CHARACTER SET utf8mb4;
USE `world`;

-- Country table
DROP TABLE IF EXISTS `country`;

CREATE TABLE `country` (
  `Code` char(3) NOT NULL DEFAULT '',
  `Name` char(52) NOT NULL DEFAULT '',
  `Continent` VARCHAR(20),
  `Region` char(26) NOT NULL DEFAULT '',
  `SurfaceArea` decimal(10, 2) NOT NULL DEFAULT '0.00',
  `IndepYear` smallint DEFAULT NULL,
  `Population` int NOT NULL DEFAULT '0',
  `LifeExpectancy` decimal(3, 1) DEFAULT NULL,
  `GNP` decimal(10, 2) DEFAULT NULL,
  `GNPOld` decimal(10, 2) DEFAULT NULL,
  `LocalName` char(45) NOT NULL DEFAULT '',
  `GovernmentForm` char(45) NOT NULL DEFAULT '',
  `HeadOfState` char(60) DEFAULT NULL,
  `Capital` int DEFAULT NULL,
  `Code2` char(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`Code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Modifico columna Continent
ALTER TABLE
  country
MODIFY
  COLUMN `Continent` VARCHAR(20);

-- Agrego FK
ALTER TABLE
  country
ADD
  CONSTRAINT `country_fkC` FOREIGN KEY (`Continent`) REFERENCES `continent` (`NameContinent`);

-- City table
DROP TABLE IF EXISTS `city`;

CREATE TABLE `city` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` char(35) NOT NULL DEFAULT '',
  `CountryCode` char(3) NOT NULL DEFAULT '',
  `District` char(80) NOT NULL DEFAULT '',
  `Population` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `CountryCode` (`CountryCode`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`CountryCode`) REFERENCES `country` (`Code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Country language table
DROP TABLE IF EXISTS `countrylanguage`;

CREATE TABLE `countrylanguage` (
  `CountryCode` char(3) NOT NULL DEFAULT '',
  `Language` char(30) NOT NULL DEFAULT '',
  `IsOfficial` enum('T', 'F') NOT NULL DEFAULT 'F',
  `Percentage` decimal(4, 1) NOT NULL DEFAULT '0.0',
  PRIMARY KEY (`CountryCode`, `Language`),
  KEY `CountryCode` (`CountryCode`),
  CONSTRAINT `countryLanguage_ibfk_1` FOREIGN KEY (`CountryCode`) REFERENCES `country` (`Code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- RENAME TABLE Continent TO continent;
-- Continent table 
DROP TABLE IF EXISTS continent;

CREATE TABLE continent (
  NameContinent VARCHAR(50) NOT NULL UNIQUE PRIMARY KEY,
  Area DECIMAL(12, 2),
  PercentTotalMass float,
  MostPopulous VARCHAR(50)
);

ALTER TABLE
  continent DROP COLUMN CodeISO;

INSERT INTO
  continent
VALUES
  ('Africa', 30370000, 20.4, 'Cairo, Egypt'),
  ('Antartica', 14000000, 9.2, 'McMurdo Station'),
  ('Asia', 44579000, 29.5, 'Mumbai, India'),
  ('Europe', 10180000, 6.8, 'Instanbul, Turquia'),
  (
    'North America',
    24709000,
    16.5,
    'Ciudad de México, Mexico'
  ),
  ('Oceania', 8600000, 5.9, 'Sydney, Australia'),
  (
    'South America',
    17840000,
    12.0,
    'São Paulo, Brazil'
  );

-- ? Consultas
-- Devuelva una lista de los nombres y las regiones a las que pertenece cada país ordenada alfabéticamente.
SELECT
  Name,
  Region
FROM
  country
WHERE
ORDER BY
  Name,
  Region ASC;

-- Liste el nombre y la población de las 10 ciudades más pobladas del mundo.
SELECT
  Name,
  Population
FROM
  city
ORDER BY
  Population DESC
LIMIT
  10;

-- Liste el nombre, región, superficie y forma de gobierno de los 10 países con menor superficie.
SELECT
  Name,
  Region,
  SurfaceArea,
  GovernmentForm
FROM
  country
ORDER BY
  SurfaceArea ASC
LIMIT
  10;

-- Liste todos los países que no tienen independencia (hint: ver que define la independencia de un país en la BD).
SELECT
  Name
FROM
  country
WHERE
  IndepYear IS NOT NULL;

SELECT
  c.Name,
  cl.Percentage
FROM
  country c
  JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE
  cl.IsOfficial = 'T';

-- ? Adicionales:
-- Actualizar el valor de porcentaje del idioma inglés en el país con código 'AIA' a 100.0
UPDATE
  country c,
  countrylanguage cl
SET
  cl.Percentage = 100.0
WHERE
  c.Code = 'AIA';

-- Chequeo si se actualizo el dato
select
  c.Name,
  cl.Percentage
from
  country c
  JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE
  Code = 'AIA';

-- Listar las ciudades que pertenecen a Córdoba (District) dentro de Argentina.
SELECT
  cy.District.Name
FROM
  country c
  INNER JOIN city cy ON c.Code = cy.CountryCode
WHERE
  c.Name = 'Argentina'
  AND cy.District = 'Cordoba';

-- Eliminar todas las ciudades que pertenezcan a Córdoba fuera de Argentina.
-- Listar los países cuyo Jefe de Estado se llame John.
SELECT
  Name
FROM
  country
WHERE
  HeadOfState LIKE '%John%';

-- Listar los países cuya población esté entre 35 M y 45 M ordenados por población de forma descendente.
SELECT
  *
FROM
  `country`
WHERE
  `Population` BETWEEN 35000000
  AND 45000000;

-- Identificar las redundancias en el esquema final.
/*  
 En la tabla city tenemos que en los `District` tenemos redundancia.
 En general hay muy poca redundancia en el esquema final.
 */