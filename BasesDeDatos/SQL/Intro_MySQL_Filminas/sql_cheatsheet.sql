-- Formatos de querys tipicas

-- Crear tabla
CREATE TABLE IF NOT EXISTS nombre (
	col1 int PRIMARY KEY NOT NULL,
    col2 varchar(50),
    FOREIGN KEY (col2) REFERENCES tabla2(colN)
);

-- Agregar columna
ALTER TABLE nombre
ADD COLUMN nombre int default 0;

-- Actualizar valores por fila
UPDATE nombre_tabla
SET columna = valor
WHERE condicion;
-- O también, actualizando las filas de t1 que sobrevivan a la condición
UPDATE t1
INNER JOIN t2
ON condicion
SET t1.columna = valor
WHERE otra_condicion;

-- Agregar valores a una tabla
INSERT INTO tabla (col1, col2, col3)
VALUES (v1, v2, v3),
	   (v1b, v2b, v3b);
-- O tambien, agregar resultado de una query a una tabla
INSERT INTO tabla (col1, col2)
SELECT val1, val2 FROM tabla2
WHERE condicion;

-- Uso de GROUP BY y funciones de agregacion
-- Agrupar por ID permite seleccionar cualquier columna.
-- Agrupar por columnas no PK sólo permite seleccionar a esas.
-- Algunos ejemplos:
-- Si tabla1 tiene una relacion uno a varios con tabla2, 
-- y queremos saber cuántos de tabla2 hay por cada valor de tabla1, podemos hacer:
SELECT col1, count(*) as cantidadDeAlgo
FROM tabla1 INNER JOIN tabla2 ON condicion
GROUP BY id_tabla_1;

-- Si queremos buscar el máximo valor para algun conjunto de valores dependientes de un id:
SELECT col1, max(colName) AS maxValueOfSmth
FROM tabla1 INNER JOIN tabla2 ON condicion
GROUP BY id_tabla_1;

-- Vista
CREATE VIEW nombre_vista (nombreCol1, nombreCol2) AS
SELECT col1, col2
FROM tabla
WHERE condicion;

-- Función
DELIMITER //
CREATE FUNCTION nombre_funcion (
	arg1 int,
    arg2 varchar(50)
) returns int
READS SQL DATA
BEGIN
	DECLARE varname int default 0; -- variable local
    
    SELECT col1 INTO varname
    FROM tabla WHERE something LIMIT 1;
    
    IF (condicion) THEN
		set varname = valor;
	END IF;
	return varname;
END //

DELIMITER ;

-- Procedimiento
DELIMITER //
CREATE PROCEDURE nombre_proc (
	in arg1 int,
    in arg2 varchar(50)
) 
BEGIN
	DECLARE varname int default 0;
    
    SELECT col1 INTO varname
    FROM tabla WHERE something LIMIT 1;
    -- Se suele utilizar una variable para luego verificar si una condicion se cumple.
    IF (condicion) THEN
		INSERT INTO tabla VALUES (a, b, c);
	END IF;
END //

DELIMITER ;


-- Roles y permisos
-- GRANT
grant [SELECT | INSERT | UPDATE | DELETE ]
on [TABLA | VISTA]
to [USUARIO | ROL]; 

-- REVOKE
revoke [SELECT | INSERT | UPDATE | DELETE ]
on [TABLA | VISTA]
from [USUARIO | ROL]; 

-- Otorgar permiso a columnas específicas
GRANT SELECT (columna1, columna2), UPDATE (columna3) ON nombre_bd.nombre_tabla TO 'usuario'@'host';

-- Crear un rol
CREATE ROLE rol;
CREATE ROLE rol2;
GRANT UPDATE (colN), DELETE ON tabla TO rol;
GRANT rol2 TO rol;
SHOW GRANTS FOR rol;

-- ON DUPLICATE KEY UPDATE
INSERT INTO tabla (SELECT * FROM tabla AS t)
ON DUPLICATE KEY UPDATE colN = (
	SELECT COUNT(*)
    FROM t2
    WHERE t2.tablaId = tabla.id
);
-- ES EQUIVALENTE A
UPDATE tabla
SET colN = (
	SELECT COUNT(*) 
    FROM t2
    WHERE t2.tablaId = tabla.id
);

-- Extras
/*
LEFT JOIN -> PUEDE DEJAR NULOS DEL LADO DERECHO (a, b, c, NULL, NULL, NULL) si no encuentra match.
INNER JOIN -> NO DEJA NULOS
SELECT id, data INTO @x, @y FROM tabla LIMIT 1; -> User-defined variables

DECIMAL(M,D) indica M digitos en total de los cuales habrá hasta D después de la coma y hasta M-D en la parte entera.
*/

-- ===============================
-- 🧠 FUNCIÓN (FUNCTION)
-- ===============================
DELIMITER $$

CREATE FUNCTION nombre_funcion(param1 TIPO, ...)
RETURNS TIPO_SALIDA
DETERMINISTIC
BEGIN
    DECLARE var TIPO;
    SET var = valor;

    RETURN var;
END$$

DELIMITER ;
-- ===============================
-- ⚙️ PROCEDIMIENTO (PROCEDURE)
-- ===============================
DELIMITER $$

CREATE PROCEDURE nombre_procedimiento(IN param1 TIPO, OUT param2 TIPO)
BEGIN
    DECLARE var TIPO;
    SET var = valor;

    -- ejemplo de asignación a un parámetro OUT
    SET param2 = var;
END$$

DELIMITER ;


-- ===============================
-- 🔫 TRIGGER: Un trigger (disparador) en MySQL es un bloque de código SQL que se ejecuta automáticamente antes o después de 
--             una operación INSERT, UPDATE o DELETE sobre una tabla.
--             Es útil para: Validar datos, Mantener integridad, Generar logs, Calcular valores automáticos
-- ===============================
DELIMITER $$

CREATE TRIGGER nombre_trigger
    {BEFORE(antes) | AFTER(despues)} {INSERT | UPDATE | DELETE}
    ON nombre_tabla
    FOR EACH ROW
    BEGIN
        -- código a ejecutar
    END;

DELIMITER ;

-- ===============================
-- 👁️ VISTA (VIEW)
-- ===============================
CREATE VIEW nombre_vista AS
SELECT columnas
FROM tabla
WHERE condición;

-- Llamar a un procedimiento:
CALL nombre_procedimiento(valor1, @salida);
SELECT @salida;

-- Usar una función:
SELECT nombre_funcion(valor);

-- ===============================
-- ⚠️ MODIFICADORES DE ACCESO A DATOS
-- ===============================

-- NO SQL: no accede a la base de datos
-- READS SQL DATA: solo lee datos (SELECT)
-- MODIFIES SQL DATA: lee y escribe (INSERT, UPDATE, DELETE)
-- CONTAINS SQL: puede contener SQL, sin garantía

-- Se usan después de RETURNS o al declarar PROCEDURE/FUNCTION

-- Machete: Comandos básicos para funciones/procedimientos en MySQL
-- DECLARE: definir una variable local
DECLARE nombre_variable TIPO;

-- SET: asignar un valor a una variable
SET nombre_variable = valor;

-- SELECT ... INTO: asignar resultado de una consulta a una variable
SELECT columna INTO variable FROM tabla WHERE condición;

-- IF ... THEN ... END IF: estructura condicional
IF condición THEN
   -- instrucciones
END IF;

-- RETURN: devolver un valor desde una función
RETURN valor;

-- BEGIN ... END: agrupar instrucciones en un bloque
BEGIN
   -- instrucciones
END;

-- ===============================
-- 🪓 MACHETE MYSQL – CONTROL DE FLUJO Y CONDICIONALES
-- ===============================

-- IF-THEN-ELSE
IF condición THEN
   -- instrucciones si verdadero
ELSE
   -- instrucciones si falso
END IF;

-- WHILE
WHILE condición DO
   -- instrucciones
END WHILE;

-- REPEAT ... UNTIL
REPEAT
   -- instrucciones
UNTIL condición
END REPEAT;

-- LOOP con LEAVE para salir del ciclo
LOOP
   -- instrucciones
   IF condición_salida THEN
      LEAVE nombre_loop;
   END IF;
END LOOP nombre_loop;


-- Ver funciones creadas
SHOW FUNCTION STATUS WHERE Db = 'nombre_db';

-- Eliminar procedimientos creados
DROP FUNCTION IF EXISTS nombre_funcion;

-- Ver procedimientos creados
SHOW PROCEDURE STATUS WHERE Db = 'nombre_db';

-- Eliminar procedimientos creados
DROP PROCEDURE IF EXISTS nombre_proc;

-- Ver Triggers
SHOW TRIGGERS;

-- Eliminar Triggers
DROP TRIGGER IF EXISTS nombre_trigger;

-- Ver Vistas
SHOW FULL TABLES IN nombre_db WHERE TABLE_TYPE = 'VIEW';

-- Eliminar Vistas
DROP VIEW IF EXISTS vista_nombre;

-- Ver estructura de una tabla
DESCRIBE nombre_tabla;

