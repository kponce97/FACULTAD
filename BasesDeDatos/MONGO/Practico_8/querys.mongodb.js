//******************************************************************************************************* */
//*1.  Cantidad de cines (theaters) por estado.
//******************************************************************************************************* */
db.theaters.aggregate([
	{
		$group: {
			_id: "$location.address.state",
			totalTheaters: {
				$sum: 1,
			},
		},
	},
]);
//******************************************************************************************************* */
//*2.  Cantidad de estados con al menos dos cines (theaters) registrados.
//******************************************************************************************************* */
db.theaters.aggregate([
	{
		$group: {
			_id: "$location.address.state",
			totalTheaters: {
				$sum: 1,
			},
		},
	},
	{
		$match: { totalTheaters: { $gte: 2 } },
	},
	{ $count: "Estados_con_dos_o_mas_cines" },
]);
//******************************************************************************************************* */
//*3.  Cantidad de películas dirigidas por "Louis Lumière". Se puede responder sin pipeline de
//*	   agregación, realizar ambas queries.
//******************************************************************************************************* */
db.movies.countDocuments({ directors: "Louis Lumière" });

db.movies.aggregate([
	{
		$match: { directors: "Louis Lumière" },
	},
	{
		$count: "Cantidad_peliculas_de_Luis",
	},
]);
//******************************************************************************************************* */
//*4.  Cantidad de películas estrenadas en los años 50 (desde 1950 hasta 1959). Se puede
//*    responder sin pipeline de agregación, realizar ambas queries.
//******************************************************************************************************* */
db.movies.countDocuments({
	year: {
		$gte: 1950,
		$lte: 1959,
	},
});
db.movies.aggregate([
	{
		$match: {
			year: {
				$gte: 1950,
				$lte: 1959,
			},
		},
	},
	{
		$count: "Cant_movies_1950_1959",
	},
]);

//******************************************************************************************************* */
//*5.  Listar los 10 géneros con mayor cantidad de películas (tener en cuenta que las películas
//*	  pueden tener más de un género). Devolver el género y la cantidad de películas. Hint:
//*	  unwind puede ser de utilidad
//******************************************************************************************************* */
db.movies.aggregate([
	{ $unwind: "$genres" },
	{
		$group: {
			_id: "$genres",
			totalPorGenero: {
				$sum: 1,
			},
		},
	},
	{
		$sort: {
			totalPorGenero: -1,
		},
	},
	{ $limit: 10 },
]);

//******************************************************************************************************* */
//*6.  Top 10 de usuarios con mayor cantidad de comentarios, mostrando Nombre, Email y
//*    Cantidad de Comentarios.
//******************************************************************************************************* */
db.comments.aggregate([
	{
		$group: {
			_id: { name: "$name", email: "$email" },
			cantidadCommentariosPorUs: { $sum: 1 },
		},
	},
	{ $sort: { cantidadCommentariosPorUs: -1 } },
	{ $limit: 10 },
	{
		$project: {
			_id: 0,
			name: "$_id.name",
			email: "$_id.email",
			cantidadCommentariosPorUs: 1,
		},
	},
]);

//******************************************************************************************************* */
//*7.  Ratings de IMDB promedio, mínimo y máximo por año de las películas estrenadas en
//*    los años 80 (desde 1980 hasta 1989), ordenados de mayor a menor por promedio del año.
//******************************************************************************************************* */
db.movies.aggregate([
	{ $match: { year: { $gte: 1980, $lte: 1989 } } },
	{
		$group: {
			_id: "$year",
			promedio: { $avg: "$imdb.rating" },
			maximo: { $max: "$imdb.rating" },
			minimo: { $min: "$imdb.rating" },
		},
	},
	{ $sort: { promedio: -1 } },
]);

//******************************************************************************************************* */
//*8.  Título, año y cantidad de comentarios de las 10 películas con más comentarios.
//******************************************************************************************************* */
db.comments.aggregate([
	{
		$group: {
			_id: "$movie_id",
			cantidadComentarios: {
				$sum: 1,
			},
		},
	},
	{
		$lookup: {
			from: "movies",
			localField: "_id",
			foreignField: "_id",
			as: "movie",
		},
	},
	{
		$unwind: "$movie",
	},
	{
		$project: {
			title: "$movie.title",
			year: "$movie.year",
			cant_comments: 1,
		},
	},
	{
		$sort: {
			cant_comments: -1,
		},
	},
	{
		$limit: 10,
	},
]);
//******************************************************************************************************* */
//*9.  Crear una vista con los 5 géneros con mayor cantidad de comentarios, junto con la
//*    cantidad de comentarios.
//******************************************************************************************************* */
db.createView("generosMayCantComments", "comments", [
	{
		$lookup: {
			from: "movies",
			localField: "movie_id", // id de la película en comments
			foreignField: "_id",
			as: "movie",
		},
	},
	{ $unwind: "$movie" },
	{ $unwind: "$movie.genres" }, // descomponer arreglo de géneros
	{
		$group: {
			_id: "$movie.genres",
			CantComentGenero: { $sum: 1 },
		},
	},
	{ $sort: { CantComentGenero: -1 } },
	{ $limit: 5 },
	{ $project: { _id: 0, genre: "$_id", CantComentGenero: 1 } },
]);

//uso
db.generosMayCantComments.find();

//******************************************************************************************************* */
//*10. Listar los actores (cast) que trabajaron en 2 o más películas dirigidas por "Jules Bass".
//*	  Devolver el nombre de estos actores junto con la lista de películas (solo título y año)
//*	  dirigidas por “Jules Bass” en las que trabajaron.
//*		a.  Hint1: addToSet
//*		b.  Hint2:  {'name.2':  {$exists:  true}}  permite filtrar arrays con al menos 2
//*		elementos, entender por qué.
//*		c.  Hint3: Puede que tu solución no use Hint1 ni Hint2 e igualmente sea correcta
//******************************************************************************************************* */
db.movies.aggregate([
	{
		$match: {
			directors: { $elemMatch: { $regex: /Jules Bass/i } },
		},
	},
	{
		$unwind: "$cast",
	},
	{
		$group: {
			_id: "$cast",
			movies: {
				$addToSet: {
					// NOTE: notar que si no agregamos el id y hay 2 peliculas con el
					// mismo nombre, pero distintos directores no lo vamos a detectar porque
					// addToSet es un conjunto => si matchea el titulo y el año no lo agrega.
					_id: "$_id",

					title: "$title",
					year: "$year",
				},
			},
		},
	},
	{
		$match: {
			// NOTE: Para que exista el elemento 1 debe
			// exitstir el elemento 0 => movies.length >= 2
			"movies.1": { $exists: true },
		},
	},
	{
		$project: {
			actor_name: "$_id",
			movies: 1,
			_id: 0,
		},
	},
]);

//******************************************************************************************************* */
//*11. Listar los usuarios que realizaron comentarios durante el mismo mes de lanzamiento de
//*    la  película  comentada, mostrando Nombre, Email, fecha del comentario, título de la
//*    película, fecha de lanzamiento. HINT: usar $lookup con multiple condiciones
//******************************************************************************************************* */
db.comments.aggregate([
	{
		$lookup: {
			from: "users",
			localField: "email",
			foreignField: "email",
			as: "user",
		},
	},
	{
		$lookup: {
			from: "movies",
			let: { movieID: "$movie_id", commentDate: "$date" },
			pipeline: [
				{
					$match: {
						$expr: {
							$and: [
								{ $eq: ["$_id", "$$movieID"] },
								{ $eq: [{ $month: "$released" }, { $month: "$$commentDate" }] },
								{ $eq: [{ $year: "$released" }, { $year: "$$commentDate" }] },
							],
						},
					},
				},
			],
			as: "movie",
		},
	},
	{ $unwind: "$user" }, // opcional, para acceder a los campos directamente
	{ $unwind: "$movie" }, // opcional, si solo quieres un resultado por comentario
	{
		$project: {
			"user.name": 1,
			"user.email": 1,
			text: 1,
			"movie.title": 1,
			"movie.released": 1,
		},
	},
]);

//******************************************************************************************************* */
//*12. Listar el id y nombre de los restaurantes junto con su puntuación máxima, mínima y la
//*    suma total. Se puede asumir que el restaurant_id es único.
//*		a.  Resolver con $group y accumulators.
//*		b.  Resolver con expresiones sobre arreglos (por ejemplo, $sum) pero sin $group.
//*		c.  Resolver como en el punto b) pero usar $reduce para calcular la puntuación total.
//*		d.  Resolver con find.
//******************************************************************************************************* */
// a.
db.restaurants.aggregate([
	// Descomponemos el array grades para poder trabajar con cada score individualmente
	{ $unwind: "$grades" },

	// Agrupamos por restaurant_id y calculamos max, min y suma de scores
	{
		$group: {
			_id: "$restaurant_id",
			name: { $first: "$name" }, // tomamos el nombre del restaurante
			maxGrade: { $max: "$grades.score" },
			minGrade: { $min: "$grades.score" },
			totalScore: { $sum: "$grades.score" },
		},
	},

	// Proyectamos los campos finales
	{
		$project: {
			_id: 1,
			name: 1,
			maxGrade: 1,
			minGrade: 1,
			totalScore: 1,
		},
	},
]);
//b.
db.restaurants.aggregate([
	{
		$match: {
			"grades.score": { $exists: true, $type: "number" },
		},
	},
	{
		$project: {
			restaurant_id: 1,
			name: 1,
			grade_sum: {
				$sum: "$grades.score",
			},
			grade_max: {
				$max: "$grades.score",
			},
			grade_min: {
				$min: "$grades.score",
			},
			_id: 0,
		},
	},
]);

//c.
db.restaurants.aggregate([
	{
		$project: {
			restaurant_id: 1,
			name: 1,
			totalScore: {
				$reduce: {
					input: "$grades",
					initialValue: 0,
					in: { $add: ["$$value", "$$this.score"] },
				},
			},
		},
	},
]);

//d.
db.restaurants.find(
	// NOTE: Usando reduce, no hace falta matchear si el score es un numero
	//       porque si esta el campo o no es un numero, reduce no lo va a sumar.
	//       dando como resultado el de initialValue.
	{},
	{
		restaurant_id: 1,
		name: 1,
		grade_stats: {
			$reduce: {
				input: "$grades",
				initialValue: {
					sum: 0,
					max: -Infinity,
					min: Infinity,
				},
				in: {
					sum: { $add: ["$$value.sum", "$$this.score"] },
					max: { $max: ["$$value.max", "$$this.score"] },
					min: { $min: ["$$value.min", "$$this.score"] },
				},
			},
		},
		_id: 0,
	}
);

//******************************************************************************************************** */
//*13. Actualizar los datos de los restaurantes añadiendo dos campos nuevos.
//*	  	a.  "average_score": con la puntuación promedio
//*	  	b.  "grade": con "A" si "average_score" está entre 0 y 13,
//*  				 con "B" si "average_score" está entre 14 y 27
//*  				 con "C" si "average_score" es mayor o igual a 28
//*    Se debe actualizar con una sola query.
//*		a.  HINT1. Se puede usar pipeline de agregación con la operación update
//*		b.  HINT2. El operador $switch o $cond pueden ser de ayuda.
//******************************************************************************************************** */
//a.
db.restaurants.updateMany(
	{}, // todos los documentos
	[
		{
			$set: {
				average_score: { $avg: "$grades.score" },
			},
		},
		{
			$set: {
				grade: {
					$switch: {
						branches: [
							{
								case: {
									$and: [
										{ $gte: ["$average_score", 0] },
										{ $lte: ["$average_score", 13] },
									],
								},
								then: "A",
							},
							{
								case: {
									$and: [
										{ $gte: ["$average_score", 14] },
										{ $lte: ["$average_score", 27] },
									],
								},
								then: "B",
							},
							{ case: { $gte: ["$average_score", 28] }, then: "C" },
						],
						default: "Sin calificación",
					},
				},
			},
		},
	]
);
