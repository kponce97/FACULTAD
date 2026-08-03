USE `bicyclestores`;

--	1. Crear la tabla `stocks` que almacena la información de inventario, es decir, la
--	cantidad de un producto en particular en una store específica, deberá constar
--	con los siguientes campos:
--	a. `quantity`: representa la cantidad de un producto
--	Tener en cuenta a la hora de elegir los tipos de datos que sean lo más eficientes
--	posibles. Además, deberán coordinar con los valores que se definen en el
--	archivo `data_stocks.sql`, que deberán cargar mediante el siguiente
--	comando:
--	mysql -h <host> -u <user> -p<password> < data_stocks.sql

CREATE TABLE IF NOT EXISTS `stocks` (
	store_id INT NOT NULL,
	product_id INT NOT NULL, 
	quantity INT NOT NULL,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) REFERENCES stores (store_id) ,
	FOREIGN KEY (product_id) REFERENCES products (product_id) 
);

--	2. Listar los precios de lista máximos y mínimos en cada categoría retornando
--	solamente aquellas categorías que tiene el precio de lista máximo superior a
--	5000 o el precio de lista mínimo inferior a 400.

SELECT c.category_name,MAX(p.list_price) AS max_price_list, MIN(p.list_price) AS min_price_list 
	FROM products AS p INNER JOIN categories c  ON p.category_id = c.category_id
	GROUP BY c.category_name
	HAVING max_price_list > 5000 OR  min_price_list < 400;

--	3. Crear un procedimiento `add_product_stock_to_store` que tomará un
--	nombre de store, un nombre de producto y una cantidad entera donde
--	actualizará la cantidad del producto en la store especificada (i.e., solo sumará el
--	valor de entrada al valor corriente en la tabla `stocks`).
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS `add_product_stock_to_store`(
	in a_name_store VARCHAR (255),
	in a_name_product VARCHAR (255),
	in a_quantity INT
)
	BEGIN
		DECLARE var_store_id INT;
		DECLARE var_product_id INT;

		SELECT store_id INTO var_store_id
		FROM stores
		WHERE store_name = a_name_store;

		SELECT product_id INTO var_product_id
		FROM products
		WHERE product_name = a_name_product;

		UPDATE stocks SET quantity = quantity + a_quantity WHERE store_id = var_store_id AND product_id = var_product_id;
	END//

DELIMITER ;

--	4. Crear un trigger llamado `decrease_product_stock_on_store` que decrementará el valor del 
--	campo `quantity` de la tabla `stocks` con el valor del campo `quantity` de la tabla `order_items`.
--	El trigger se ejecutará luego de un `INSERT` en la tabla `order_items` y deberá
--	actualizar el valor en la tabla `stocks` de acuerdo al valor correspondiente.


DELIMITER //
CREATE TRIGGER `decrease_product_stock_on_store`
AFTER INSERT ON `order_items`
FOR EACH ROW
BEGIN
    UPDATE `stocks`
    SET quantity = quantity - NEW.quantity
    WHERE store_id = NEW.store_id
      AND product_id = NEW.product_id;
END//
DELIMITER ;

--	5. Devuelva el precio de lista promedio por brand para todos los productos con
--	modelo de año (`model_year`) entre 2016 y 2018.
SELECT  b.brand_name,AVG(p.list_price) AS avg_list_price 
	FROM products p INNER JOIN brands AS b ON p.brand_id = b.brand_id 
	WHERE p.model_year BETWEEN 2016 AND 2018
	GROUP BY b.brand_name;

--	6. Liste el número de productos y ventas para cada categoría de producto.
--	Tener en cuenta que una venta (`orders` table) es completada cuando la
--	columna `order_status` = 4.
SELECT 
    c.category_name,
    COUNT(DISTINCT p.product_id) AS num_products,
    COUNT(oi.order_id) AS num_sales
FROM categories c
JOIN products p ON p.category_id = c.category_id
LEFT JOIN order_items oi ON oi.product_id = p.product_id
LEFT JOIN orders o ON o.order_id = oi.order_id AND o.order_status = 4
GROUP BY c.category_name;

--	7. Crear el rol `human_care_dept` y asignarle permisos de creación sobre la tabla
--	`staffs` y permiso de actualización sobre la columna `active` de la tabla
--	`staffs`.
CREATE ROLE `human_care_dept`;
GRANT CREATE ON `bicyclestores`. TO `human_care_dept`;
GRANT  UPDATE (active) ON `bicyclestores`.`staffs` TO `human_care_dept`;
