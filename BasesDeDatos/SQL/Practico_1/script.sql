CREATE DATABASE Practico_1;

USE Practico_1;

CREATE TABLE
	Empleado (
		usuario_id INT AUTO_INCREMENT PRIMARY KEY,
		nombre VARCHAR(50),
		apellido VARCHAR(50),
		correo_electronico VARCHAR(100),
		contraseña VARCHAR(100),
		fecha_nacimiento DATE,
		sexo VARCHAR(1),
		nombre_usuario VARCHAR(100),
		rol VARCHAR(100)
	);

CREATE TABLE
	TelefonosEmpleados (
		numero INT AUTO_INCREMENT PRIMARY KEY,
		usuario_id INT,
		FOREIGN KEY (usuario_id) REFERENCES Empleado (usuario_id)
	);

CREATE TABLE
	Plan (
		plan_id INT AUTO_INCREMENT PRIMARY KEY,
		nombre VARCHAR(20),
		fecha_subscripcion DATE
	);

CREATE TABLE
	Cliente (
		cliente_id INT AUTO_INCREMENT PRIMARY KEY,
		nombre VARCHAR(50),
		apellido VARCHAR(50),
		correo_electronico VARCHAR(100),
		contraseña VARCHAR(100),
		fecha_nacimiento DATE,
		sexo VARCHAR(1),
		nombre_usuario VARCHAR(40),
		numero_telefono INT,
		plan_id INT,
		FOREIGN KEY (plan_id) REFERENCES Plan (plan_id)
	);

CREATE TABLE
	ReviewsPeliculas (
		review_id INT AUTO_INCREMENT PRIMARY KEY,
		cliente_id INT,
		contenido_id INT,
		titulo VARCHAR(100),
		descripcion TEXT,
		fecha DATE,
		calificacion INT,
		FOREIGN KEY (cliente_id) REFERENCES Cliente (cliente_id)
	);

CREATE TABLE
	Generos (
		genero_id INT AUTO_INCREMENT PRIMARY KEY,
		nombre VARCHAR(50) NOT NULL
	);

CREATE TABLE
	Contenido (
		contenido_id INT AUTO_INCREMENT PRIMARY KEY,
		titulo VARCHAR(100) NOT NULL,
		descripcion TEXT,
		duracion INT,
		fecha_lanzamiento DATE,
		genero_id INT,
		productora VARCHAR(100),
		FOREIGN KEY (genero_id) REFERENCES Generos (genero_id)
	);

CREATE TABLE
	Subtitulos (
		subtitulo_id INT AUTO_INCREMENT PRIMARY KEY,
		contenido_id INT,
		idioma VARCHAR(50),
		FOREIGN KEY (contenido_id) REFERENCES Contenido (contenido_id)
	);

CREATE TABLE
	Productora (
		productora_id INT AUTO_INCREMENT PRIMARY KEY,
		nombre VARCHAR(100)
	);

CREATE TABLE
	ActorPorPelicula (
		pelicula_id INT,
		persona_id INT,
		actor_tipo VARCHAR(50),
		PRIMARY KEY (pelicula_id, persona_id),
		FOREIGN KEY (pelicula_id) REFERENCES Contenido (contenido_id)
	);

CREATE TABLE
	DirectorPorPelicula (
		pelicula_id INT,
		persona_id INT,
		PRIMARY KEY (pelicula_id, persona_id),
		FOREIGN KEY (pelicula_id) REFERENCES Contenido (contenido_id)
	);

CREATE TABLE
	Peliculas (
		pelicula_id INT AUTO_INCREMENT PRIMARY KEY,
		contenido_id INT,
		FOREIGN KEY (contenido_id) REFERENCES Contenido (contenido_id)
	);

CREATE TABLE
	CadenaTelevision (
		cadena_tel_id INT AUTO_INCREMENT PRIMARY KEY,
		nombre VARCHAR(100)
	);

CREATE TABLE
	ProgramaTelevision (
		programa_id INT AUTO_INCREMENT PRIMARY KEY,
		contenido_id INT,
		cadena_tel_id INT,
		FOREIGN KEY (contenido_id) REFERENCES Contenido (contenido_id),
		FOREIGN KEY (cadena_tel_id) REFERENCES CadenaTelevision (cadena_tel_id)
	);

CREATE TABLE
	Temporadas (
		temporada_id INT AUTO_INCREMENT PRIMARY KEY,
		numero INT,
		año DATE,
		programa_id INT,
		FOREIGN KEY (programa_id) REFERENCES ProgramaTelevision (programa_id)
	);

CREATE TABLE
	Capitulos (
		capitulo_id INT AUTO_INCREMENT PRIMARY KEY,
		titulo VARCHAR(100),
		descripcion TEXT,
		duracion INT,
		fecha_lanzamiento DATE,
		temporada_id INT,
		FOREIGN KEY (temporada_id) REFERENCES Temporadas (temporada_id)
	);

INSERT INTO
	Plan (nombre, fecha_subcripcion)
VALUES
	('Básico', '2024-01-15'),
	('Estándar', '2024-02-10'),
	('Premium', '2024-03-05');

INSERT INTO
	Cliente (
		nombre,
		apellido,
		correo_electrónico,
		contraseña,
		fecha_nacimiento,
		sexo,
		nombre_usuario,
		numero_telefono,
		plan_id
	)
VALUES
	(
		'Juan',
		'Pérez',
		'juanperez@gmail.com',
		'1234seguro',
		'1990-05-12',
		'M',
		'juancho90',
		'1123456789',
		1
	),
	(
		'María',
		'López',
		'maria.lopez@hotmail.com',
		'claveSegura',
		'1985-09-23',
		'F',
		'marial85',
		'1145678910',
		2
	),
	(
		'Carlos',
		'Gómez',
		'carlos.gomez@yahoo.com',
		'pass2024',
		'2000-02-10',
		'M',
		'carlitox',
		'1167891234',
		3
	);

INSERT INTO
	ReviewsPeliculas (
		cliente_id,
		contenido_id,
		titulo,
		descripcion,
		fecha,
		calificacion
	)
VALUES
	(
		1,
		1,
		'Muy buena película',
		'Me encantó la trama y la actuación.',
		'2024-04-01',
		5
	),
	(
		2,
		2,
		'Regular',
		'La película tuvo buenos efectos pero floja en historia.',
		'2024-04-05',
		3
	),
	(
		3,
		3,
		'Excelente',
		'Sin dudas una de las mejores del año.',
		'2024-04-10',
		5
	);

/* 
● Listar los datos de los clientes suscritos al plan PREMIUM con una
determinada fecha de suscripción.
● Listar los datos de las películas donde el actor ‘X’ fue protagonista.
● Listar los episodios correspondientes a un programa de televisión X y un
número de temporada N. Listar ordenados por fecha de lanzamiento.
● Listar los reviews hechos por un cliente X dentro de un rango de fechas.
● Dada una película X, calcular su “calificación promedio”.
● Listar las películas dirigidas por dos o más directoras femeninas.
 */

SELECT Cliente 