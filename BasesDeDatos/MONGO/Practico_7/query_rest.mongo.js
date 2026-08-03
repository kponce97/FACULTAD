// Tareas

// ---------------------------------------------------------------------------------------
// 10. ​Listar el id del restaurante (restaurant_id) y las calificaciones de los restaurantes donde
//     al menos una de sus calificaciones haya sido realizada entre 2014 y 2015 inclusive, y
// 	   que tenga una puntuación (score) mayor a 70 y menor o igual a 90.
// ---------------------------------------------------------------------------------------
db.restaurants.find(
	{
		grades: {
			$elemMatch: {
				date: {
					$gte: ISODate("2014-01-01T00:00:00Z"),
					$lte: ISODate("2015-12-31T23:59:59Z"),
				},
				score: { $gt: 70, $lte: 90 },
			},
		},
	},
	{
		restaurant_id: 1,
		grades: 1,
	}
);

// ---------------------------------------------------------------------------------------
// 11. ​Agregar dos nuevas calificaciones al restaurante cuyo id es "50018608". A continuación
//     se especifican las calificaciones a agregar en una sola consulta.
// ---------------------------------------------------------------------------------------
db.restaurants.updateMany(
	{ restaurant_id: '50018608' },
	{
		$push: {
			grades: {
				$each: [
					{
						date: ISODate("2019-10-10T00:00:00Z"),
						grade: "A",
						score: 18,
					},
					{
						date: ISODate("2020-02-25T00:00:00Z"),
						grade: "A",
						score: 21,
					},
				],
			},
		},
	}
);
//Chequear
db.restaurants.find({ restaurant_id: "50018608" }, { grades: 1 });
//{
//	"date" : ISODate("2019-10-10T00:00:00Z"),
//	"grade" : "A",
//	"score" : 18
//}
//{
//	"date" : ISODate("2020-02-25T00:00:00Z"),
//	"grade" : "A",
//	"score" : 21
//}
