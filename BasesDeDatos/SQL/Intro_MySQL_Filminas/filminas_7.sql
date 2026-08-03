/* 
* 	¿Qué es una transacción?
*		Una transacción es una secuencia de instrucciones SQL que se trata como una sola operación atómica. Esto significa que:
*			- Todas las operaciones dentro de la transacción deben completarse correctamente.
*			- Si alguna falla, se revierte todo y la base de datos queda como estaba antes de empezar. 
* ✅ Características de una Transacción (ACID)
		* Atomicidad (Atomicity): Todas las operaciones de una transacción se completan, o ninguna lo hace.
		* Consistencia (Consistency): La base de datos pasa de un estado válido a otro estado válido después de la transacción.
		* Aislamiento (Isolation):Las transacciones no interfieren entre sí.
		* Durabilidad (Durability): Una vez que la transacción se confirma, los cambios son permanentes, incluso si ocurre una falla del sistema.			
*/

-- Ejemplo de Transacción
-- Se confirma con COMMIT
BEGIN TRANSACTION;
	UPDATE cuentas SET saldo = saldo - 100 WHERE id = 1;
	UPDATE cuentas SET saldo = saldo + 100 WHERE id = 2;
COMMIT;

-- Se aborta con ROLLBACK
BEGIN TRANSACTION;
	UPDATE Producto SET stock = stock - 1 WHERE id = 5;
	UPDATE Pedido SET estado ='Enviado' WHERE id = 100;
	-- SUpongamos que aqui ocurre un error
ROLLBACK;


/* 
*	Tipos de transacciones:
	✅	Planas: simples, todo o nada.
	✅	Anidadas: contienen subtransacciones con SAVEPOINT.
			👉 Se puede hacer ROLLBACK TO <SAVEPOINT>, si falla un paso se puede deshacer solo ese paso sin afectar a los demas.
	✅	Distribuidas: involucran múltiples bases de datos, requieren coordinación entre sistemas.
 */

-- Plana
BEGIN;
	UPDATE cuentas SET saldo = saldo - 100 WHERE id = 1;
	UPDATE cuentas SET saldo = saldo + 100 WHERE id = 2;
COMMIT;

-- Anidada
BEGIN;
  SAVEPOINT paso1;
  UPDATE inventario SET stock = stock - 1 WHERE id_producto = 10;

  SAVEPOINT paso2;
  UPDATE pagos SET estado = 'procesado' WHERE id_pago = 55;

  ROLLBACK TO paso2;  -- Deshace solo el pago, no el inventario
COMMIT;

/*
	Distribuida:
		🔸 Una reserva de viaje que actualiza:
		Base de datos del vuelo ✈️
		Base de datos del hotel 🏨
			Ambas deben confirmarse juntas; si una falla, se revierte la otra.
*/

/* 
   *⚠️ Problemas de Concurrencia
		Lectura sucia: leer datos no confirmados.
		Lectura no repetible: Lee el mismo dato y obtiene diferentes resultados.
		Lectura fantasma: Re-ejecuta una consulta y obtiene filas diferentes
		
	*	🧁 Ejemplos del “croissant”:
			Lectura sucia: leer precio temporal modificado y revertido.
			Lectura no repetible: precio cambia con la demanda.
			Lectura fantasma: producto desaparece antes de comprarlo. 
*/

/* 
?	🧩 Niveles de Aislamiento
*		Read Uncommitted: puede leer datos no confirmados.
*		Read Committed: solo lee datos confirmados.
*		Repeatable Read: evita modificaciones mientras se lee.
*		Serializable: máxima seguridad, sin lecturas concurrentes.
*		Snapshot Isolation: ve los datos tal como estaban al inicio de la transacción.
*		RCSI (Read Committed Snapshot Isolation): usa versiones RC, (snapshots) en lugar de bloqueos.
 */
-- Sintaxis General
SET [GLOBAL | SESSION] TRANSACTION 
  ISOLATION LEVEL nivel | access_mode
-- ISOLATION LEVEL : define el grado de protección frente a lecturas sucias, no repetibles o fantasmas.
-- nilve: [READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ (por defecto en MySQL) | SERIALIZABLE (el más estricto) ]  
-- access_mode: [READ WRITE | READ ONLY]

-- Ejemplo: la transacción no permitirá ninguna lectura o escritura concurrente sobre los mismos datos.
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;


/* 
?	🧠 Técnicas de Control de Concurrencia
*	Bloqueos (Locks): Compartidos (lectura) y exclusivos (escritura).
		Ejemplo:
			SELECT ... FOR UPDATE bloquea filas para escritura.
			SELECT ... FOR SHARE bloquea filas para lectura.
			Riesgo: deadlocks.
*	Marcas de Tiempo (Timestamping):
		Cada transacción tiene una marca temporal única.
		Evita deadlocks, pero puede causar muchos abortos.
*	Control Multiversión (MVCC):
		Mantiene múltiples versiones de los datos.
		Permite leer sin bloquear escrituras (usado en PostgreSQL y Oracle).
 */
