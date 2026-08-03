// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

const { text } = require("express");

// The current database to use.
use("mflix");

// Tareas
// ---------------------------------------------------------------------------------------
// 1.Insertar 5 nuevos usuarios en la colección users. Para cada nuevo usuario creado,
//   insertar al menos un comentario realizado por el usuario en la colección comments. 
// ---------------------------------------------------------------------------------------

db.users.insertMany([
	{
		name: "Usuario Uno",
		email: "usuarioUno@gameofthron.es",
		password: "asdasd123123",
	},
	{
		name: "Usuario Dos",
		email: "usuarioDos@gameofthron.es",
		password: "asdasd11223123",
	},
	{
		name: "Usuario Tres",
		email: "usuarioTres@gameofthron.es",
		password: "asdasd123333123",
	},
	{
		name: "Usuario Cuatro",
		email: "usuarioCuatro@gameofthron.es",
		password: "asdasd11222223123",
	},
	{
		name: "Usuario Cinco",
		email: "usuarioCinco@gameofthron.es",
		password: "asdasd11222223123",
	},
]);
db.comments.insertMany([
	{
		name: "Usuario Uno",
		email: "usuarioUno@gameofthron.es",
		movie_id: "ObjectId(573a1390f29313caabcd418c)",
		text: "Buena peli bro 1",
	},
	{
		name: "Usuario Dos",
		email: "usuarioDos@gameofthron.es",
		movie_id: "ObjectId(573a1390f29313caabcd418c)",
		text: "Buena peli bro 2",
	},
	{
		name: "Usuario Tres",
		email: "usuarioTres@gameofthron.es",
		movie_id: "ObjectId(573a1390f29313caabcd418c)",
		text: "Buena peli bro 3",
	},
	{
		name: "Usuario Cuatro",
		email: "usuarioCuatro@gameofthron.es",
		movie_id: "ObjectId(573a1390f29313caabcd418c)",
		text: "Buena peli bro 4",
	},
	{
		name: "Usuario Cinco",
		email: "usuarioCinco@gameofthron.es",
		movie_id: "ObjectId(573a1390f29313caabcd418c)",
		text: "Buena peli bro 5",
	},
]);

// --------------------------------------------------------------------------------------- 
// 2.​  Listar el título, año, actores (cast), directores y rating de las 10 películas con mayor
// 	rating (“imdb.rating”) de la década del 90. ¿Cuál es el valor del rating de la película que
// 	tiene mayor rating? (Hint: Chequear que el valor de “imdb.rating” sea de tipo “double”).
// ---------------------------------------------------------------------------------------
 
db.movies
	.find({
		year: 1990,
		"imdb.rating": { $type: "double" },
	})
	.sort({ "imdb.rating": -1 })
	.limit(10);

// ---------------------------------------------------------------------------------------
//  3.​  Listar el nombre, email, texto y fecha de los comentarios que la película con id
// 	(movie_id) ObjectId("573a1399f29313caabcee886") recibió entre los años 2014 y 2016
// 	inclusive. Listar ordenados por fecha. Escribir una nueva consulta (modificando la
// 	anterior) para responder ¿Cuántos comentarios recibió?
// ---------------------------------------------------------------------------------------
db.comments
	.find(
		{
			movie_id: ObjectId("573a1399f29313caabcee886"),
			date: {
				$gte: ISODate("2014-01-01T00:00:00Z"),
				$lte: ISODate("2016-12-31T23:59:59Z"),
			},
		},
		{
			name: 1,
			email: 1,
			text: 1,
			date: 1,
			_id: 0,
		}
	)
	.sort({ date: 1 });

// Recibio 34 comentarios, uso countDocuments
db.comments.countDocuments({
	movie_id: ObjectId("573a1399f29313caabcee886"),
	date: {
		$gte: ISODate("2014-01-01T00:00:00Z"),
		$lte: ISODate("2016-12-31T23:59:59Z"),
	},
});

// ---------------------------------------------------------------------------------------
// 4.​  Listar el nombre, id de la película, texto y fecha de los 3 comentarios más recientes
// 	realizados por el usuario con email patricia_good@fakegmail.com. 
//
db.comments
	.find(
		{ email: "patricia_good@fakegmail.com" },
		{ name: 1, movie_id: 1, text: 1, _id: 0 }
	)
	.sort({ date: -1 })
	.limit(3);
// ---------------------------------------------------------------------------------------
// 5.​  Listar el título, idiomas (languages), géneros, fecha de lanzamiento (released) y número
// 	de votos (“imdb.votes”) de las películas de géneros Drama y Action (la película puede
// 	tener otros géneros adicionales), que solo están disponibles en un único idioma y por
// 	último tengan un rating (“imdb.rating”) mayor a 9 o bien tengan una duración (runtime)
// 	de al menos 180 minutos. Listar ordenados por fecha de lanzamiento y número de
// 	votos 
// ---------------------------------------------------------------------------------------

db.movies
	.find(
		{
			genres: { $all: ["Drama", "Action"] },
			countries: { $size: 1 },
			$or: [{ "imdb.rating": { $gt: 9 } }, { runtime: { $lte: 180 } }],
			released: { $type: "date" },
			"imdb.votes": { $type: "number" },
			// NOTE: Si usamos el valor, mejor verificar que sea valido el campo?
			//       es decir del tipo que queremos.
			// RESPUESTA: no hace falta aunque si vemos algun comportamiento raro, lo podemos hacer.
		},
		{
			title: 1,
			genres: 1,
			released: 1,
			"imdb.votes": 1,
			countries: 1,
		}
	)
	.sort({ released: -1, "imdb.votes": -1 });

// ---------------------------------------------------------------------------------------
// 6. Listar el id del teatro (theaterId), estado (“location.address.state”), ciudad
// (“location.address.city”), y coordenadas (“location.geo.coordinates”) de los teatros que
// se encuentran en algunos de los estados "CA", "NY", "TX" y el nombre de la ciudades
// comienza con una ‘F’. Listar ordenados por estado y ciudad.
// ---------------------------------------------------------------------------------------
db.theaters
	.find(
		{
			"location.address.state": { $in: ["CA", "NY", "TX"] },
			"location.address.city": { $regex: /^F/ },
		},
		{
			theaterId: 1,
			"location.address.state": 1,
			"location.address.city": 1,
			"location.geo.coordinates": 1,
			_id: 0,
		}
	)
	.sort({ "location.address.state": 1, "location.address.city": 1 });

// ---------------------------------------------------------------------------------------
// 7. Actualizar los valores de los campos texto (text) y fecha (date) del comentario cuyo id es
// ObjectId("5b72236520a3277c015b3b73") a "mi mejor comentario" y fecha actual
// respectivamente.
// ---------------------------------------------------------------------------------------
db.comments.updateOne(
	{ _id: ObjectId("5b72236520a3277c015b3b73") },
	{
		$set: {
			text: "mi mejor comentario",
		},
		$currentDate: { date: true },
	}
);
// ---------------------------------------------------------------------------------------
// 8. Actualizar el valor de la contraseña del usuario cuyo email es joel.macdonel@fakegmail.com a
// "some password". La misma consulta debe poder insertar un nuevo usuario en caso que el usuario no
// exista. Ejecute la consulta dos veces. ¿Qué operación se realiza en cada caso? (Hint: usar upserts).
// ---------------------------------------------------------------------------------------
// db.users.findOne();
// db.users.findOne({ email: "joel.macdonel@fakegmail.com" }); // -> El user no existe = null

db.users.updateOne(
	{ email: "joel.macdonel@fakegmail.com" },
	{ $set: { password: "some password" } },
	{ upsert: true } // -> ESTE CAMPO ME PERMITE INSETAR SI NO EXISTE EL DOCUMENTO.
);

// ¿Qué operación se realiza en cada caso ?
// Respuesta: La primera vez como no existia el usuario (documento), creo uno nuevo.
//            La segunda vex como si existia el usuario, simplemente actualizo la data.

// ---------------------------------------------------------------------------------------
// 9. Remover todos los comentarios realizados por el usuario cuyo email es
// victor_patel@fakegmail.com durante el año 1980.
// ---------------------------------------------------------------------------------------
db.comments.deleteMany({
  email: "victor_patel@fakegmail.com",
  date: {
    $gte: ISODate("1980-01-01"),
    $lte: ISODate("1980-12-31"),
  },
});

