USE Practico_1;

/* 
 Consultas:
 - Listar los datos de los clientes suscritos al plan PREMIUM con una determinada fecha de suscripción.
 - Listar los datos de las películas donde el actor ‘X’ fue protagonista.
 - Listar los episodios correspondientes a un programa de televisión X y un número de temporada N. Listar ordenados por fecha de lanzamiento.
 - Listar los reviews hechos por un cliente X dentro de un rango de fechas.
 - Dada una película X, calcular su “calificación promedio”.
 - Listar las películas dirigidas por dos o más directoras femeninas.
 */

-- 1) Clientes con plan PREMIUM en fecha dada
SELECT *
FROM Cliente c
    JOIN Plan p ON c.plan_id = p.id
WHERE p.nombre = 'PREMIUM'
    AND c.fecha_suscripcion = '2025-01-01';

    