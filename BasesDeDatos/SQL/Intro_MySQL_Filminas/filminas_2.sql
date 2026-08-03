-- TODO											Data Definition Lenguage (DDL) 
/* 
 ? Tipos de Datos:
 - CHAR(n)	 		-> STRING TAMAÑO FIJO n 
 - VARCHAR(n) 		-> STRING TAMAÑO VARIABLE CON LARGO MAXIMO n
 - INT 		 		-> ENTEROS
 - NUMERIC(P,D) 		-> NUMERO DE PUNTO FIJO, P DIGITOS Y D DECIMALES
 - DOUBLE PRECISION	-> NUMERO DE PUNTO FLOTANTE DE DOBLE PRECISION
 - JSON				-> OBJETOS JSON
 - DATE				-> FECHAS SIN COMPONENTES
 - DATETIME			-> FECHAS CON COMPONENTE
 
 ? Restricciones de Integridad:
 - PRIMARY KEY (col1) AUTO_INCREMENT	-> CLAVE PRIMARIA PK, DEBEN SER UNICAS Y NO NULLAS , SE AUTOINCREMENTA.
 - NOT NULL 							-> INDICA QUE UNA COLUMNA NO PUEDE TENER VALORES NULOS
 - UNIQUE							-> UNA COLUMNA NO PUEDO TENER VALORES REPETIDOS
 - FREING KEY (col1) REFERENCES T	-> CLAVE FORANEA DEBE CORRESPONDERSE CON LOS VALORES DE LA TABALA T
 - CHECK(condition)					-> INDICA QUE LA CONDICION 'condition'(PUEDE SER subquery) DEBE SER VERDADERA PARA TODA LA FILA DE LA TABLA 
 */

/* Crea una tabla con columnas 'col1' de tipo INT, es PK y autoincremental, y restrinccion de Integridad integrity-constraint1 */
CREATE DATABASE IF NOT EXISTS table_name (
	col1 INT AUTO_INCREMENT PRIMARY KEY,
	integrity - constraint1
);

-- ! DDL (CREATE, ALTER, DROP ) Y DML ( INSERT INTO, UPDATE, DELETE) 
-- Borra una tabla completa (estructura y datos)
DROP TABLE table_name;

-- Agrega una nueva COLUMNA a la tabla
ALTER TABLE table_name ADD COLUMN col2 type2;

-- Elimina una COLUMNA existente de la tabla
ALTER TABLE table_name
DROP COLUMN col1;

-- Inserta una nueva fila con valores en las columnas especificadas
INSERT INTO table_name (col1, ..., coln)
VALUES (val1, ..., valn);

-- Elimina filas que cumplen una condición
DELETE FROM table_name WHERE condition;

-- Actualiza valores de una o más columnas en las filas que cumplen la condición
UPDATE table_name SET col1 = val1, ...
WHERE condition;

-- TODO											Data Manipulation Lenguage (DML) 
-- * EL RESULTADO DE UNA QUERY ES UNA TABLA *
-- * SQL es Case-Insensitive *
-- SELECT DISTINCT 										 -> Elimina valores duplicados (Por defecto sql permite duplicados)
-- SELECT * 											 -> Selecciona todas las columnas
-- SELECT 'literal' AS col_new							 -> Agrega una columna col_new con valor literal
-- SELECT name AS fullname FROM table 					 -> Renombra la columna 'name' con 'fullname' de la tabla
-- SELECT salary/40 AS usd_salary 						 -> salary/40 (expresion aritmetica) y se almacena en una columna temporal (alias) usd_salary 
-- SELECT * FROM Usuarios WHERE nombre LIKE '%ana%';	 -> Busca nombres que contengan "ana"
-- SELECT * FROM Usuarios WHERE edad BETWEEN 18 AND 30;  ->  Busca usuarios con edad entre 18 y 30
-- SELECT * FROM Instructor WHERE dep_name = 'Finance' ORDER BY salary [DESC,ASC]; -> Devuelve los trabajore de 'Finance' por orden DESCENDENTE/ASCENDENTE segun 'salary'
-- select_expr 							-> una o mas columnas
-- table_expr  							-> una o mas tablas
-- where_condition 						-> predicado
-- order_expr 							-> lista de expresiones del tipo {col | alias| pos}
SELECT select_expr_1,select_expr_2 FROM table_expr_1,table_expr_2 [WHERE where_condition_1 [AND,OR,NOT] where_condition_2] [ORDER BY order_expr]; 


-- Operaciones aritméticas con NULL → siempre NULL
SELECT 10 + NULL;   -- NULL
SELECT 5 * NULL;    -- NULL

-- Operaciones booleanas con NULL
SELECT NULL AND TRUE;   -- NULL
SELECT NULL AND FALSE;  -- FALSE
SELECT NULL OR TRUE;    -- TRUE
SELECT NULL OR FALSE;   -- NULL
SELECT NOT NULL;        -- NULL

-- Crear tabla de ejemplo
CREATE TEMPORARY TABLE empleados (
  id INT,
  nombre VARCHAR(50),
  salario DECIMAL(10,2)
);

-- Insertar datos (uno con salario NULL)
INSERT INTO empleados VALUES
(1, 'Ana', 1000),
(2, 'Luis', NULL);

-- Filtrar nulos
SELECT * FROM empleados WHERE salario IS NULL;      -- devuelve a Luis
SELECT * FROM empleados WHERE salario IS NOT NULL;  -- devuelve a Ana

-- Funciones de agregación (ignoran NULL, excepto COUNT)
SELECT SUM(salario) FROM empleados;   -- suma solo valores no nulos
SELECT COUNT(salario) FROM empleados; -- cuenta solo no nulos
SELECT COUNT(*) FROM empleados;       -- cuenta todas las filas
