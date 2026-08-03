db.usuarios.insertMany([
	{
		nombre: "Ana Torres",
		email: "ana.torres@gmail.com",
		direccion: { calle: "Av. Siempre Viva 123", ciudad: "Lima" },
		hobbies: ["lectura", "ciclismo", "viajar"],
		activos: true,
		edad: 28,
	},
	{
		nombre: "Carlos Gómez",
		email: "carlos.gomez@hotmail.com",
		direccion: { calle: "Calle Falsa 456", ciudad: "Bogotá" },
		hobbies: ["fútbol", "videojuegos"],
		activos: false,
		edad: 34,
	},
	{
		nombre: "Laura Méndez",
		email: "laura.m@gmail.com",
		direccion: { calle: "Ruta 9 km 12", ciudad: "Buenos Aires" },
		hobbies: ["pintura", "música", "lectura"],
		activos: true,
		edad: 22,
	},
	{
		nombre: "José Martínez",
		email: "jmartinez@yahoo.com",
		direccion: { calle: "Calle Central 89", ciudad: "Ciudad de México" },
		hobbies: ["ajedrez"],
		activos: false,
		edad: 45,
	},
	{
		nombre: "María López",
		email: "marialopez@gmail.com",
		direccion: { calle: "Av. del Sol 300", ciudad: "Santiago" },
		hobbies: ["senderismo", "viajar"],
		activos: true,
		edad: 31,
	},
	{
		nombre: "Pedro Salazar",
		email: "pedro.salazar@gmail.com",
		direccion: { calle: "Calle Norte 111", ciudad: "Medellín" },
		hobbies: ["guitarra", "ciclismo"],
		activos: true,
		edad: 29,
	},
	{
		nombre: "Lucía Fernández",
		email: "luciaf@yahoo.com",
		direccion: { calle: "Av. Las Palmas 67", ciudad: "Quito" },
		hobbies: ["lectura", "yoga", "cocina"],
		activos: false,
		edad: 38,
	},
	{
		nombre: "Andrés Rojas",
		email: "andres.r@gmail.com",
		direccion: { calle: "Pasaje Sur 44", ciudad: "La Paz" },
		hobbies: ["escalada", "videojuegos"],
		activos: true,
		edad: 26,
	},
	{
		nombre: "Valentina Castro",
		email: "valen.castro@hotmail.com",
		direccion: { calle: "Camino Real 500", ciudad: "San José" },
		hobbies: ["baile", "viajar", "música"],
		activos: true,
		edad: 30,
	},
	{
		nombre: "Diego Navarro",
		email: "diego.n@gmail.com",
		direccion: { calle: "Av. Libertad 98", ciudad: "Asunción" },
		hobbies: ["ajedrez", "lectura", "series"],
		activos: false,
		edad: 40,
	},
	{
		nombre: "Pedro Salazar",
		email: "pedro.salazar@gmail.com",
		direccion: { calle: "Calle Norte 111", ciudad: "Medellín" },
		hobbies: ["guitarra", "ciclismo"],
		activos: true,
		edad: 29,
	},
	{
		nombre: "Lucía Fernández",
		email: "luciaf@yahoo.com",
		direccion: { calle: "Av. Las Palmas 67", ciudad: "Quito" },
		hobbies: ["lectura", "yoga", "cocina"],
		activos: false,
		edad: 38,
	},
	{
		nombre: "Andrés Rojas",
		email: "andres.r@gmail.com",
		direccion: { calle: "Pasaje Sur 44", ciudad: "La Paz" },
		hobbies: ["escalada", "videojuegos"],
		activos: true,
		edad: 26,
	},
	{
		nombre: "Valentina Castro",
		email: "valen.castro@hotmail.com",
		direccion: { calle: "Camino Real 500", ciudad: "San José" },
		hobbies: ["baile", "viajar", "música"],
		activos: true,
		edad: 30,
	},
	{
		nombre: "Diego Navarro",
		email: "diego.n@gmail.com",
		direccion: { calle: "Av. Libertad 98", ciudad: "Asunción" },
		hobbies: ["ajedrez", "lectura", "series"],
		activos: false,
		edad: 40,
	},
]);

db.usuarios.aggregate([
	{ $match: { $and: [{ edad: { $gte: 18 } }, { activos: false }] } },
]);

db.usuarios.aggregate([
	{
		$match: { activos: true },
	},
	{
		$project: {
			nombre: 1,
			"direccion.ciudad": 1,
			_id: 0,
		},
	},
]);

db.usuarios.aggregate([
	{
		$match: { activos: true },
	},
	{
		$project: {
			_id: 0,
			nombre: 1,
			email: 1,
			ciudad: "$direccion.ciudad",
			edadDoble: { $multiply: ["$edad", 2] },
		},
	},
]);

db.usuarios.aggregate([
	{
		$match: { edad: { $gte: 18 } },
	},
	{
		$project: {
			_id: 0,
			nombre: 1,
			email: 1,
			ciudad: "$direccion.ciudad",
			IncialNombre: { $substr: ["$nombre", 0, 1] },
		},
	},
]);

db.usuarios.aggregate([
	{
		$match: { edad: { $gte: 18 } },
	},
	{
		$project: {
			_id: 0,
			nombre: 1,
			primerElem: { $first: "$hobbies" },
		},
	},
]);

db.usuarios.aggregate([
	{
		$addFields: {
			mayorEdad: { $gte: ["$edad", 18] }, // true si edad ≥ 18
			primerHobby: { $first: "$hobbies" }, // primer hobby del array
		},
	},
]);

db.usuarios.aggregate([
	{
		$project: {
			_id: 0,
			nombre: 1,
			ciudad: 1,
			avg_hobbies: 1,
		},
	},
	{
		$addFields: {
			avg_hobbies: { $avg: "$hobbies" },
		},
	},
]);

db.usuarios.aggregate([
  {
    $group: {
      _id: "$direccion.ciudad",           // agrupamos por ciudad
      promedioEdad: { $avg: "$edad" },    // promedio de edad
      totalUsuarios: { $sum: 1 }          // cantidad de usuarios
    }
  }
])

db.usuarios.aggregate([
  {
    // Agrega el campo "estado" con valor "activo" a cada usuario
    $addFields: { estado: "activo" }
  },
  {
    // Une los documentos de la colección "usuarios_inactivos"
    $unionWith: {
      coll: "usuarios_inactivos",
      pipeline: [
        // Filtra solo los usuarios inactivos con edad > 30
        { $match: { edad: { $gt: 30 } } },
        // Agrega el campo "estado" con valor "inactivo"
        { $addFields: { estado: "inactivo" } }
      ]
    }
  },
  {
    // Proyecta (muestra) solo los campos necesarios
    $project: {
      _id: 0,         // Oculta el campo _id
      nombre: 1,      // Muestra el nombre
      edad: 1,        // Muestra la edad
      estado: 1       // Muestra el estado (activo/inactivo)
    }
  }
])
°