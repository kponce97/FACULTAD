CREATE DATABASE IF NOT EXISTS ventas_db;
-- Crear la base de datos

USE ventas_db;

-- Tabla de clientes
CREATE TABLE IF NOT EXISTS clientes (
	cliente_id INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100),
	correo VARCHAR(100),
	fecha_registro DATE
);

-- Tabla de productos
CREATE TABLE IF NOT EXISTS productos (
	producto_id INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100),
	precio DECIMAL(10, 2),
	stock INT
);

-- Tabla de ventas
CREATE TABLE IF NOT EXISTS ventas (
	venta_id INT AUTO_INCREMENT PRIMARY KEY,
	cliente_id INT,
	producto_id INT,
	cantidad INT,
	fecha DATE,
	FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
	FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

-- Tabal de logs
CREATE TABLE IF NOT EXISTS productos_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    stock_anterior INT,
    stock_nuevo INT,
    fecha DATETIME
);

-- Tabal de logs
CREATE TABLE IF NOT EXISTS productos_log_insert_prod (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    nombre_prod_new VARCHAR(100),
    stock_prod_new INT,
    fecha DATETIME
);


-- Datos de prueba
INSERT INTO
	clientes (nombre, correo, fecha_registro)
VALUES
	('Ana Torres', 'ana@mail.com', '2022-01-15'),
	('Luis Pérez', 'luis@mail.com', '2022-03-22'),
	('María Gómez', 'maria@mail.com', '2023-06-10');

INSERT INTO
	productos (nombre, precio, stock)
VALUES
	('Laptop', 1500.00, 10),
	('Mouse', 25.50, 100),
	('Teclado', 45.00, 50);

INSERT INTO
	ventas (cliente_id, producto_id, cantidad, fecha)
VALUES
	(1, 1, 1, '2023-10-01'),
	(2, 2, 3, '2023-10-02'),
	(3, 3, 2, '2023-10-03');

DELIMITER $$
CREATE FUNCTION IF NOT EXISTS total_venta(p_producto_id INT, cantidad INT) 
	RETURNS DECIMAL(10, 2) DETERMINISTIC 
	BEGIN 
		DECLARE precio_unitario DECIMAL(10, 2);
	SET
		precio_unitario = (
			SELECT
				precio
			FROM
				productos
			WHERE
				producto_id = p_producto_id
			LIMIT
				1
		);
	RETURN precio_unitario * cantidad;
	END $$
DELIMITER ;

-- Ideas de funciones que podés practicar
--		Calcular el total de una venta (precio × cantidad)
--		Aplicar IVA a un monto
DELIMITER $$
CREATE FUNCTION IF NOT EXISTS producto_con_iva(p_producto_id INT)
	RETURNS DECIMAL(10,2)
	DETERMINISTIC
	BEGIN
	    DECLARE precio_base DECIMAL(10,2);  -- Declaro variables
	    DECLARE precio_final DECIMAL(10,2);	-- Declaro variables
		-- Consulta que devuelve el precio de un producto
	    SELECT precio INTO precio_base
	    FROM productos
	    WHERE producto_id = p_producto_id;
		-- Asigno a prefico_final un valor
	    SET precio_final = precio_base * 1.21;

	    RETURN precio_final;
	END$$
DELIMITER ;

--		Determinar si un cliente es "nuevo" (< 1 año)
--		Calcular descuento según cantidad comprada
DELIMITER $$
CREATE FUNCTION IF NOT EXISTS aplicar_descuento_prod(p_producto_id INT)
	RETURNS INT
READS SQL DATA
	BEGIN
	    DECLARE treinta_por_ciento INT;
	    DECLARE p_cantida INT;
	    DECLARE p_precio INT;
	    DECLARE nuevo_precio INT;

	    -- Obtener cantidad comprada
	    SELECT v.cantidad INTO p_cantida
	    FROM ventas v
	    WHERE v.producto_id = p_producto_id
	    LIMIT 1;

	    -- Obtener precio del producto
	    SELECT precio INTO p_precio
	    FROM productos
	    WHERE producto_id = p_producto_id
	    LIMIT 1;

	    -- Calcular descuento si corresponde
	    IF p_cantida = 3 THEN
	        SET treinta_por_ciento = (p_precio * 30) / 100;
	    ELSE
	        SET treinta_por_ciento = 0;
	    END IF;

	    -- Calcular nuevo precio total
	    SET nuevo_precio = (p_precio * p_cantida) - treinta_por_ciento;

	    RETURN nuevo_precio;
	END $$

DELIMITER ;
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS registrar_venta (
	in p_cliente_id INT,
	in p_producto_id INT,
	in p_cantidad INT
) 
BEGIN
	DECLARE stock_actual INT;
    
    SELECT stock INTO stock_actual 
    FROM productos WHERE  producto_id = p_producto_id LIMIT 1;

    -- Se suele utilizar una variable para luego verificar si una condicion se cumple.
    IF (stock_actual >= p_cantidad) THEN
		INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha)
        VALUES (p_cliente_id, p_producto_id, p_cantidad, CURDATE());

        -- Actualizar stock
        UPDATE productos
        SET stock = stock - p_cantidad
        WHERE producto_id = p_producto_id;
	ELSE
        -- Error: stock insuficiente
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para realizar la venta.';
	END IF;
END //

DELIMITER ;
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS aumentar_stock(
	in p_producto_id INT,
	in p_cantidad_agregar INT
)
BEGIN
	DECLARE stock_actual INT;
	SELECT stock INTO stock_actual FROM productos WHERE producto_id = p_producto_id;
	IF (stock_actual IS NOT NULL)  THEN
		UPDATE productos
		SET stock = stock + p_cantidad_agregar
		WHERE producto_id = p_producto_id;
	ELSE
    	-- Error: stock insuficiente
    	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no existe.';
	END IF;

END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS aumentar_precio (
	in p_producto_id INT,
	in p_precio_nuevo INT
)
BEGIN
	DECLARE precio_actual INT;
	DECLARE stock_actual INT;
	
	SELECT stock, precio INTO stock_actual,precio_actual FROM productos WHERE producto_id = p_producto_id;
	IF(stock_actual IS NOT NULL) THEN
		UPDATE productos
		SET precio = precio + p_precio_nuevo
		WHERE producto_id = p_producto_id;
	ELSE
    	-- Error: stock insuficiente
    	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no existe.';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS agregar_nuevo_prod (
	in n_nombre VARCHAR(100),
	in n_precio DECIMAL(10, 2),
	in n_stock INT
)
	BEGIN
		INSERT INTO productos(nombre,precio,stock) VALUES (n_nombre,n_precio,n_stock);		
	END//
DELIMITER ;


-- TRIGGER de actualizacion de stock
DELIMITER //

CREATE TRIGGER IF NOT EXISTS log_actualizacion_stock 
	AFTER UPDATE ON productos FOR EACH ROW
	BEGIN
		INSERT INTO productos_log (producto_id, stock_anterior, stock_nuevo, fecha)
    	VALUES (OLD.producto_id, OLD.stock, NEW.stock, NOW());
	END//
DELIMITER ;

-- TRIGGER de actualizacion de elementos de productos
DELIMITER //

CREATE TRIGGER IF NOT EXISTS log_insert_producto 
AFTER INSERT ON productos
FOR EACH ROW
BEGIN
    INSERT INTO productos_log_insert_prod (
        producto_id, nombre_prod_new, stock_prod_new, fecha
    )
    VALUES (
        NEW.producto_id, NEW.nombre, NEW.stock, NOW()
    );
END;
//

DELIMITER ;
