//*****************************************************************************************
//*1. 	Especificar en la colección users las siguientes reglas de validación: El campo name
//*	  	(requerido) debe ser un string con un máximo de 30 caracteres, email (requerido) debe
//*	  	ser  un  string  que  matchee  con  la expresión  regular: "^(.*)@(.*)\\.(.{2,4})$" ,
//*	  	password (requerido) debe ser un string con al menos 50 caracteres.

import { text } from "express";

//****************************************************************************************
db.runCommand({
	collMod: "users",
	validator: {
		$jsonSchema: {
			bsonType: "object",
			required: ["name", "email", "password"],
			properties: {
				name: {
					bsonType: "string",
					maxLength: 30,
					description:
						"debe ser un string de maximo 30 caracteres y es requerido",
				},
				email: {
					bsonType: "string",
					pattern: "^(.*)@(.*)\\.(.{2,4})$",
					description:
						"debe ser un string tal tiene un nombre de usuario seguido de @, un dominio con una extensión de 2 a 4 caracteres y es requerido",
				},
				password: {
					bsonType: "string",
					minLength: 50,
					description:
						"debe ser un string de minimo 50 caracteres y es requerido",
				},
			},
		},
	},
});

//****************************************************************************************
//* 2. 	Obtener  metadata  de  la colección users  que garantice que las reglas de validación
//*    	fueron correctamente aplicadas.
//****************************************************************************************
db.getCollectionInfos({ name: "users" });

//****************************************************************************************
//* 3.  Especificar  en  la  colección  theaters  las  siguientes  reglas  de  validación:  El  campo
//* 	theaterId (requerido) debe ser un int y location (requerido) debe ser un object con:
//* 		a.  un campo address (requerido) que sea un object con campos street1, city, state
//* 		    y zipcode todos de tipo string y requeridos
//* 		b.  un campo geo (no requerido) que sea un object con un campo type, con valores
//* 		    posibles “Point” o null y coordinates que debe ser una lista de 2 doubles
//* 	Por último, estas reglas de validación no deben prohibir la inserción o actualización de
//* 	documentos que no las cumplan sino que solamente deben advertir.
//****************************************************************************************
db.runCommand({
	collMod: "theaters",
	validator: {
		$jsonSchema: {
			bsonType: "object",
			required: ["theaterId", "location"],
			properties: {
				theaterId: {
					bsonType: "int",
				},
				location: {
					bsonType: "object",
					required: ["address"],
					properties: {
						address: {
							bsonType: "object",
							required: ["street1", "city", "state", "zipcode"],
							properties: {
								street1: {
									bsonType: "string",
									description: "debe ser un string y es requerido",
								},
								city: {
									bsonType: "string",
									description: "debe ser un string y es requerido",
								},
								state: {
									bsonType: "string",
									description: "debe ser un string y es requerido",
								},
								zipcode: {
									bsonType: "string",
									description: "debe ser un string y es requerido",
								},
							},
						},
						geo: {
							bsonType: "object",
							required: ["type", "coordinates"],
							properties: {
								type: {
									enum: ["Point", null],
									description: "debe ser Point o null y no es requerido",
								},
								coordinates: {
									bsonType: "array",
									minItems: 2,
									maxItems: 2,
									items: {
										bsonType: "double",
									},
									description:
										"debe ser una lista que contenga exactamente 2 doubles y no es requerido",
								},
							},
						},
					},
				},
			},
		},
	},
	validationAction: "error",
});

// db.theaters.findOne();
// db.getCollectionInfos({ "name": "theaters" });
// db.theaters.getIndexes();

// Casos validos
db.theaters.insertOne({
	theaterId: 99999,
	location: {
		address: {
			street1: "340asd W Market",
			city: "Bloasdomington",
			state: "MNasd",
			zipcode: "55sad425",
		},
		geo: {
			type: "Point",
			coordinates: [-83.24565, 42.85466],
		},
	},
});

// Casos no validos
db.theaters.insertOne({
	theaterId: "99999",
	location: {
		address: {
			street1: "340asd W Market",
			city: "Bloasdomington",
			state: "MNasd",
			zipcode: "55sad425",
		},
		geo: {
			type: "Point",
			coordinates: [-83.24565, 42.85466],
		},
	},
});
db.theaters.insertOne({
	theaterId: 99999,
	location: {
		address: {
			street1: 1,
			city: "Bloasdomington",
			state: "MNasd",
			zipcode: "55sad425",
		},
		geo: {
			type: "Point",
			coordinates: [-83.24565, 42.85466],
		},
	},
});
db.theaters.insertOne({
	theaterId: 99999,
	location: {
		address: {
			street1: 1,
			city: "Bloasdomington",
			state: "MNasd",
			zipcode: "55sad425",
		},
		geo: {
			type: "Point",
			coordinates: [-83.24565],
		},
	},
});

//****************************************************************************************
//*	4.  Especificar en la colección movies  las siguientes reglas de validación:  El campo title
//*		(requerido) es de tipo string, year (requerido) int con mínimo en 1900 y máximo en 3000,
//*		y  que  tanto  cast,  directors,  countries,  como  genres  sean  arrays  de  strings  sin
//*		duplicados.
//*		a.  Hint: Usar el constructor NumberInt() para especificar valores enteros a la hora
//*		de insertar documentos. Recordar que mongo shell es un intérprete javascript y
//*		en javascript los literales numéricos son de tipo Number (double).
//****************************************************************************************
db.runCommand({
	collMod: "movies",
	validator: {
		$jsonSchema: {
			bsonType: "object",
			required: ["title", "year"],
			properties: {
				title: {
					bsonType: "string",
					maxLength: 40,
					description: "Campo requerido de maximo 40 caracteres",
				},
				year: {
					bsonType: "int",
					minimum: 1900,
					maximum: 3000,
					description: "Campo requerido, 1900 valor minimo y 3000 valor maximo",
				},
				cast: {
					bsonType: "array",
					uniqueItems: true,
					items: {
						bsonType: "string",
					},
					description: "debe ser un array de strings sin duplicados",
				},
				directors: {
					bsonType: "array",
					uniqueItems: true,
					items: {
						bsonType: "string",
					},
					description: "debe ser un array de strings sin duplicados",
				},
				countries: {
					bsonType: "array",
					uniqueItems: true,
					items: {
						bsonType: "string",
					},
					description: "debe ser un array de strings sin duplicados",
				},
				genres: {
					bsonType: "array",
					uniqueItems: true,
					items: {
						bsonType: "string",
					},
					description: "debe ser un array de strings sin duplicados",
				},
			},
			validationAction: "stritc",
			validationLevel: "errror",
		},
	},
});
// Casos que cumplen
// 1
db.movies.insertOne({
	title: "Inception",
	year: 2010,
	cast: ["Leonardo DiCaprio", "Elliot Page"],
	directors: ["Christopher Nolan"],
	countries: ["USA"],
	genres: ["Sci-Fi", "Thriller"],
});

// 2
db.movies.insertOne({
	title: "Toy Story",
	year: 1995,
	cast: ["Tom Hanks", "Tim Allen"],
	directors: ["John Lasseter"],
	countries: ["USA"],
	genres: ["Animation", "Family"],
});

// 3
db.movies.insertOne({
	title: "Parasite",
	year: 2019,
	cast: ["Song Kang-ho", "Choi Woo-shik"],
	directors: ["Bong Joon-ho"],
	countries: ["South Korea"],
	genres: ["Drama", "Thriller"],
});

// 4
db.movies.insertOne({
	title: "Up",
	year: 2009,
});

// 5
db.movies.insertOne({
	title: "Amélie",
	year: 2001,
	countries: ["France"],
	genres: ["Romance", "Comedy"],
});

// Casos que NO cumplen
// 1 title demasiado largo
db.movies.insertOne({
	title:
		"This Movie Title Is Way Too Long To Be Accepted By The Schema Validation Rule",
	year: 2020,
});

// 2 year fuera de rango
db.movies.insertOne({
	title: "Ancient Movie",
	year: 1850,
});

// 3 cast con valores duplicados
db.movies.insertOne({
	title: "Duplicated Cast",
	year: 2022,
	cast: ["Actor1", "Actor1"],
});

// 4 genres contiene un número en lugar de string
db.movies.insertOne({
	title: "Wrong Genre Type",
	year: 2021,
	genres: ["Action", 123],
});

// 5 falta campo requerido 'year'
db.movies.insertOne({
	title: "Missing Year",
});
//db.getCollectionInfos({ name: "movies" })

//****************************************************************************************
//*	5.  Crear  una  colección  userProfiles  con  las  siguientes  reglas  de validación: Tenga un
//*		campo user_id (requerido) de tipo “objectId”, un campo language (requerido) con alguno
//*		de  los  siguientes  valores  [  “English”,  “Spanish”,  “Portuguese”  ]  y  un  campo
//*		favorite_genres (no requerido) que sea un array de strings sin duplicados.
//****************************************************************************************
db.createCollection("userProfiles", {
	validator: {
		$jsonSchema: {
			bsonType: "object",
			required: ["user_id", "language"],
			properties: {
				user_id: {
					bsonType: "objectId",
					description: "Campo requerido de tipo objectId",
				},
				language: {
					enum: ["English", "Spanish", "Portuguese"],
					description:
						"Campo requerido de con valores posibles : “English”,  “Spanish”,  “Portuguese”",
				},
				favorite_genres: {
					bsonType: "array",
					uniqueItems: true,
					items: {
						bsonType: "string",
					},
					description:
						"Campo no requerido con tipo array de strings, sin duplicados",
				},
			},
		},
	},
});
// Ejemplos que cumplen
// 1
db.userProfiles.insertOne({
  user_id: ObjectId("656f1f8a2f8f2e0012345678"),
  language: "English",
  favorite_genres: ["Action", "Comedy"]
});

// 2
db.userProfiles.insertOne({
  user_id: ObjectId("656f1f8a2f8f2e0012345679"),
  language: "Spanish"
});

// 3
db.userProfiles.insertOne({
  user_id: ObjectId("656f1f8a2f8f2e0012345680"),
  language: "Portuguese",
  favorite_genres: ["Drama"]
});

// 4
db.userProfiles.insertOne({
  user_id: ObjectId("656f1f8a2f8f2e0012345681"),
  language: "English",
  favorite_genres: []
});

// 5
db.userProfiles.insertOne({
  user_id: ObjectId("656f1f8a2f8f2e0012345682"),
  language: "Spanish",
  favorite_genres: ["Horror", "Thriller", "Sci-Fi"]
});

//Ejemplos que No cumplen
// 1 language no válido
db.userProfiles.insertOne({
  user_id: ObjectId("656f1f8a2f8f2e0012345683"),
  language: "French"
});

// 2 falta user_id
db.userProfiles.insertOne({
  language: "English",
  favorite_genres: ["Action"]
});

// 3 favorite_genres tiene duplicados
db.userProfiles.insertOne({
  user_id: ObjectId("656f1f8a2f8f2e0012345684"),
  language: "Spanish",
  favorite_genres: ["Comedy", "Comedy"]
});

// 4 user_id de tipo incorrecto (string en lugar de ObjectId)
db.userProfiles.insertOne({
  user_id: "123456",
  language: "English"
});

// 5 language faltante
db.userProfiles.insertOne({
  user_id: ObjectId("656f1f8a2f8f2e0012345685"),
  favorite_genres: ["Drama"]
});

//****************************************************************************************
//*	6.  Identificar los distintos tipos de relaciones (One-To-One, One-To-Many) en las
//*		colecciones movies y comments. Determinar si se usó documentos anidados o
//*		referencias en cada relación y justificar la razón.
//****************************************************************************************
/* 
Respuesta: 	Se utilizó una relación One-to-Many (uno a muchos) entre movies y 	
			comments, implementada mediante referencias (a través del campo movie_id). No se emplea un esquema anidado 
			porque una película puede tener muchos comentarios, lo que haría que los documentos 
			fueran demasiado grandes y afectaría la eficiencia.
 */
//****************************************************************************************
//* 7.  Dado el diagrama de la base de datos shop junto con las queries más importantes.
//* 	Queries
//* 		I.  Listar el id, titulo, y precio de los libros y sus categorías de un autor en 
//*				particular
//* 		II.  Cantidad de libros por categorías
//* 		III.  Listar el nombre y dirección entrega y el monto total (quantity * price) de sus
//* 			  pedidos para un order_id dado.
//*
//* Debe crear el modelo de datos en mongodb aplicando las estrategias “Modelo de datos
//* anidados” y Referencias. El modelo de datos debe permitir responder las queries de
//* manera eficiente.
//*
//* Inserte algunos documentos para las colecciones del modelo de datos. Opcionalmente
//* puede especificar una regla de validación de esquemas para las colecciones.
//*
//* Se  provee el archivo shop.tar.gz que contiene algunos datos que puede usar como
//* ejemplo para los inserts en mongodb.
//****************************************************************************************
// ===========================================
// Entidades: "books" y "categories"
// Relación: One-To-One (cada libro pertenece a una categoría)
// Estrategia: Anidar la categoría dentro del documento de cada libro
// ===========================================

{
  _id: ObjectId(),
  title: "MongoDB Book",
  author: "Kevin Ponce",
  price: 36,
  category: { 
    id: 1, 
    name: "Web Development" 
  }
}

// ===========================================
// Entidades: "orders" y "order_details"
// Relación: One-To-Many (una orden tiene varios detalles)
// Estrategia: Anidar los detalles dentro del documento de cada orden
// ===========================================

{
  _id: ObjectId(),
  order_id: 1,
  delivery_name: "José López",
  delivery_address: "Av. Central 123",
  items: [
    { title: "Learning MySQL", quantity: 2, price: 34.31 },
    { title: "Learning MySQL II", quantity: 1, price: 40 }
  ]
}

//****************************************************************************************
//* 8.  Dado el siguiente diagrama que representa los datos de un blog de artículos
//* Se pide:
//* 	a.  Crear 3 modelos de datos distintos en mongodb aplicando solo las estrategias
//* 	“Modelo de datos anidad<os” y Referencias (es decir, sin considerar queries).
//* 	b.  Crear un modelo de datos en mongodb aplicando las estrategias “Modelo de
//* 	datos anidados” y Referencias y considerando las siguientes queries.
//* 	i.  Listar título y url, tags y categorías de los artículos dado un user_id
//* 	ii.  Listar título, url y comentarios que se realizaron en un rango de fechas.
//* 	iii.  Listar nombre y email dado un id de usuario
//* Inserte  algunos  documentos  para  las  colecciones  del  modelo  de  datos.
//* Opcionalmente puede especificar una regla de validación de esquemas  para las
//* colecciones..
//****************************************************************************************
//a.)
// ==========================================
// Modelo 1 – Totalmente anidado
// ==========================================
// Todos los datos (usuario, tags, categorías, comentarios) 
// están dentro del documento principal "articles".
// No se usan IDs ni referencias externas.
{
  article_id: 1,
  title: "Aprendiendo MongoDB",
  url: "aprendiendo-mongodb",
  author: {
    name: "Juan López",
    email: "juanlopez@gmail.com"
  },
  tags: ["database", "MongoDB"],
  categories: ["Database", "NoSQL"],
  comments: [
    { user: "Ana", date: "25-10-2025", text: "Very good" }
  ]
}

// ==========================================
// Modelo 2 – Totalmente con referencias
// ==========================================
// Todos los datos relacionados (usuario, categorías, tags, comentarios)
// están en colecciones separadas, referenciadas por su ID.
{
  _id: 1,
  user_id: 9,
  title: "Aprendiendo MongoDB",
  url: "aprendiendoMongo.com",
  date: "25-10-2025",
  text: "Muy bueno",
  categories_ids: [88],
  tags_ids: [111],
  comments_ids: [12, 13]
}

// ==========================================
// Modelo 3 – Mixto (anidado + referencias)
// ==========================================
// Se anidan los datos que siempre se consultan junto con el artículo 
// (autor, tags, categorías) y se referencian los que pueden crecer mucho 
// o se consultan por separado (comentarios).
{
  article_id: 1,
  title: "Aprendiendo MongoDB",
  url: "aprendiendo-mongodb",
  author: {
    name: "Juan López",
    email: "juanlopez@gmail.com"
  },
  tags: ["database", "MongoDB"],
  categories: ["Database", "NoSQL"],
  comments_ids: [19, 20]
}

//b.)
// I. Listar título y url, tags y categorías de los artículos dado un user_id
{
	_id:1,
	user_id:2,
	title:"Hola Mundo",
	url:"aprendiendoMondo.com",
	tags:["NoSQL", "MongoDB"],
	categories: ["Hola mundo - Web"]
}
// Se mantiene user_id para filtrar los articulos por usuario (Query I)
// Tags y categories se anidan porque se muestran siempre junto al articulo

// II. Listar título, url y comentarios que se realizaron en un rango de fechas.
// Colección: articles
{
  _id: 1,
  title: "Hola Mundo",
  url: "aprendiendoMongo.com",
  comments: [
    { text: "Mi primer Hola Mundo", date: "2023-10-20" },
    { text: "Excelente post!", date: "2025-10-20" }
  ]
}
// Los comentarios se anidan porque son parte del articulo.

// III. Listar nombre y email dado un id de usuario
{
	user_id:1,
	name: "Jose Lopez",
	email: "joselopez@gmail.com"
}
// Esta informacion es propia del usuario, independientemente de los articulos.