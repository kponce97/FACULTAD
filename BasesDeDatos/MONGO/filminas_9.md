# Pipeline: 
	Un **pipeline** en MongoDB es una secuencia de etapas que procesan documentos, usada
	principalmente en **`aggregate()`** para transformar, filtrar, agrupar o resumir datos paso a paso.

## Metodo Aggregate
### Etapas de Agregacion: Son pasos secuenciales en una pipeline que permiten transformar, filtrar y resumir datos. Cada etapa usa un operador específico y recibe como entrada los documentos procesados por la etapa anterior.
db.<collection>.aggregate(pipeline, <options>)
db.<coleccion>.aggregate([
  { etapa1 },
  { etapa2 },
  ...
])

### Expresiones de Agregacion
	- { <operator>: [ { argument1 }, { argument2 }, … ] }
	- { <operator>: { argument } }
	Expresiones (Operadores) 
🔹 Booleanas:	
| Operador | Qué hace                             | Sintaxis                         |
| -------- | ------------------------------------ | -------------------------------- |
| `$and`   | Todas las condiciones deben ser true | `{ $and: [ <cond1>, <cond2> ] }` |
| `$or`    | Al menos una condición debe ser true | `{ $or: [ <cond1>, <cond2> ] }`  |
| `$not`   | Invierte la condición (true → false) | `{ $not: [ <cond> ] }`           |

🔹 De comparación:
| Operador | Qué hace               | Sintaxis                 |
| -------- | ---------------------- | ------------------------ |
| `$eq`    | Igual a                | `{ $eq: [ <a>, <b> ] }`  |
| `$ne`    | Distinto de            | `{ $ne: [ <a>, <b> ] }`  |
| `$gt`    | Mayor que              | `{ $gt: [ <a>, <b> ] }`  |
| `$gte`   | Mayor o igual que      | `{ $gte: [ <a>, <b> ] }` |
| `$lt`    | Menor que              | `{ $lt: [ <a>, <b> ] }`  |
| `$lte`   | Menor o igual que      | `{ $lte: [ <a>, <b> ] }` |
| `$cmp`   | Comparación (-1, 0, 1) | `{ $cmp: [ <a>, <b> ] }` |

🔹 Aritméticas:
| Operador    | Qué hace       | Sintaxis                      |
| ----------- | -------------- | ----------------------------- |
| `$add`      | Suma           | `{ $add: [ <a>, <b> ] }`      |
| `$subtract` | Resta          | `{ $subtract: [ <a>, <b> ] }` |
| `$divide`   | División       | `{ $divide: [ <a>, <b> ] }`   |
| `$abs`      | Valor absoluto | `{ $abs: <valor> }`           |

🔹 De arreglos:
| Operador        | Qué hace                       | Sintaxis                                    |
| --------------- | ------------------------------ | ------------------------------------------- |
| `$arrayElemAt`  | Elemento en una posición       | `{ $arrayElemAt: [ <array>, <índice> ] }`   |
| `$first`        | Primer elemento                | `{ $first: <array> }`                       |
| `$last`         | Último elemento                | `{ $last: <array> }`                        |
| `$size`         | Tamaño del array               | `{ $size: <array> }`                        |
| `$concatArrays` | Une múltiples arrays           | `{ $concatArrays: [ <array1>, <array2> ] }` |
| `$filter`       | Filtra elementos del array     | `{ $filter: { input, as, cond } }`          |
| `$map`          | Aplica función a cada elemento | `{ $map: { input, as, in } }`               |
| `$reduce`       | Reduce a un valor acumulado    | `{ $reduce: { input, initialValue, in } }`  |

🔹 De conjuntos:
| Operador         | Qué hace                                      | Sintaxis                                     |
| ---------------- | --------------------------------------------- | -------------------------------------------- |
| `$setDifference` | Elementos únicos del primero no en el segundo | `{ f$setDifference: [ <array1>, <array2> ] }` |
| `$setUnion`      | Unión sin duplicados                          | `{ $setUnion: [ <array1>, <array2> ] }`      |
| `$setIsSubset`   | Verifica si A ⊆ B                             | `{ $setIsSubset: [ <sub>, <main> ] }`        |

🔹 Condicionales:
| Operador  | Qué hace                       | Sintaxis                                    |
| --------- | ------------------------------ | ------------------------------------------- |
| `$cond`   | if / then / else               | `{ $cond: { if, then, else } }`             |
| `$ifNull` | Si null, usa valor alternativo | `{ $ifNull: [ <valor>, <alternativa> ] }`   |
| `$switch` | Múltiples condiciones (switch) | `{ $switch: { branches: [...], default } }` |

🔹 De fechas:
| Operador    | Qué hace                   | Sintaxis                                      |
| ----------- | -------------------------- | --------------------------------------------- |
| `$year`     | Extrae el año de una fecha | `{ $year: <fecha> }`                          |
| `$month`    | Extrae el mes de una fecha | `{ $month: <fecha> }`                         |
| `$dateAdd`  | Suma tiempo a una fecha    | `{ $dateAdd: { startDate, unit, amount } }`   |
| `$dateDiff` | Diferencia entre fechas    | `{ $dateDiff: { startDate, endDate, unit } }` |

🔹 De strings:
| Operador          | Qué hace                          | Sintaxis                                           |
| ----------------- | --------------------------------- | -------------------------------------------------- |
| `$concat`         | Concatena cadenas                 | `{ $concat: [ <str1>, <str2> ] }`                  |
| `$split`          | Divide texto en array             | `{ $split: [ <texto>, <separador> ] }`             |
| `$substr`         | Subcadena (*obsoleto*)            | `{ $substr: [ <texto>, <inicio>, <longitud> ] }`   |
| `$substrCP`       | Subcadena (por caracteres reales) | `{ $substrCP: [ <texto>, <inicio>, <longitud> ] }` |
| `$dateFromString` | String a fecha                    | `{ $dateFromString: { dateString: <str> } }`       |

🔹 De tipos:
| Operador    | Qué hace               | Sintaxis                      |
| ----------- | ---------------------- | ----------------------------- |
| `$convert`  | Convierte tipo de dato | `{ $convert: { input, to } }` |
| `$isNumber` | Verifica si es número  | `{ $isNumber: <valor> }`      |
| `$type`     | Devuelve tipo de dato  | `{ $type: <campo> }`          |

🔹 Field Path:
| Expresión    | Qué hace                                  |
| ------------ | ----------------------------------------- |
| `"$<campo>"` | Accede a un campo del documento actual    |
| `$$CURRENT`  | Referencia al documento actual (opcional) |


🔹 Booleanas:
| Operador | Qué hace                             | Sintaxis                         | Ejemplo |
| -------- | ------------------------------------ | -------------------------------- | -------- |
| $and     | Todas las condiciones deben ser true | { $and: [ <cond1>, <cond2> ] }   | { $and: [ { $gt: ["$edad", 18] }, { $lt: ["$edad", 65] } ] } |
| $or      | Al menos una condición debe ser true | { $or: [ <cond1>, <cond2> ] }    | { $or: [ { $eq: ["$rol", "Admin"] }, { $eq: ["$rol", "Editor"] } ] } |
| $not     | Invierte la condición (true → false) | { $not: [ <cond> ] }             | { $not: [ { $gt: ["$edad", 30] } ] } |

🔹 De comparación:
| Operador | Qué hace               | Sintaxis                 | Ejemplo |
| -------- | ---------------------- | ------------------------ | -------- |
| $eq      | Igual a                | { $eq: [ <a>, <b> ] }   | { $eq: ["$ciudad", "Madrid"] } |
| $ne      | Distinto de            | { $ne: [ <a>, <b> ] }   | { $ne: ["$estado", "Inactivo"] } |
| $gt      | Mayor que              | { $gt: [ <a>, <b> ] }   | { $gt: ["$precio", 100] } |
| $gte     | Mayor o igual que      | { $gte: [ <a>, <b> ] }  | { $gte: ["$puntuacion", 4.5] } |
| $lt      | Menor que              | { $lt: [ <a>, <b> ] }   | { $lt: ["$edad", 21] } |
| $lte     | Menor o igual que      | { $lte: [ <a>, <b> ] }  | { $lte: ["$descuento", 10] } |
| $cmp     | Comparación (-1,0,1)  | { $cmp: [ <a>, <b> ] }  | { $cmp: ["$precio", "$precioPromedio"] } |

🔹 Aritméticas:
| Operador    | Qué hace       | Sintaxis                      | Ejemplo |
| ----------- | -------------- | ----------------------------- | -------- |
| $add        | Suma           | { $add: [ <a>, <b> ] }        | { $add: ["$ventas", "$impuestos"] } |
| $subtract   | Resta          | { $subtract: [ <a>, <b> ] }   | { $subtract: ["$total", "$descuento"] } |
| $divide     | División       | { $divide: [ <a>, <b> ] }     | { $divide: ["$precioTotal", "$cantidad"] } |
| $abs        | Valor absoluto | { $abs: <valor> }             | { $abs: "$diferencia" } |

🔹 De arreglos:
| Operador        | Qué hace                       | Sintaxis                                    | Ejemplo |
| --------------- | ------------------------------ | ------------------------------------------- | -------- |
| $arrayElemAt    | Elemento en una posición       | { $arrayElemAt: [ <array>, <índice> ] }    | { $arrayElemAt: ["$tags", 0] } |
| $first          | Primer elemento                | { $first: <array> }                         | { $first: "$comentarios" } |
| $last           | Último elemento                | { $last: <array> }                          | { $last: "$historial" } |
| $size           | Tamaño del array               | { $size: <array> }                          | { $size: "$productos" } |
| $concatArrays   | Une múltiples arrays           | { $concatArrays: [ <array1>, <array2> ] }  | { $concatArrays: ["$favoritos", "$vistos"] } |
| $filter         | Filtra elementos del array     | { $filter: { input, as, cond } }           | { $filter: { input: "$scores", as: "s", cond: { $gt: ["$$s", 80] } } } |
| $map            | Aplica función a cada elemento | { $map: { input, as, in } }                | { $map: { input: "$precios", as: "p", in: { $multiply: ["$$p", 1.21] } } } |
| $reduce         | Reduce a un valor acumulado    | { $reduce: { input, initialValue, in } }   | { $reduce: { input: "$valores", initialValue: 0, in: { $add: ["$$value", "$$this"] } } } |

🔹 De conjuntos:
| Operador         | Qué hace                                      | Sintaxis                                     | Ejemplo |
| ---------------- | --------------------------------------------- | -------------------------------------------- | -------- |
| $setDifference   | Elementos únicos del primero no en el segundo | { $setDifference: [ <array1>, <array2> ] }  | { $setDifference: ["$tags", ["borrador","oculto"]] } |
| $setUnion        | Unión sin duplicados                          | { $setUnion: [ <array1>, <array2> ] }       | { $setUnion: ["$categoriasA","$categoriasB"] } |
| $setIsSubset     | Verifica si A ⊆ B                             | { $setIsSubset: [ <sub>, <main> ] }         | { $setIsSubset: [["A","B"],"$letrasPermitidas"] } |

🔹 Condicionales:
| Operador  | Qué hace                       | Sintaxis                                    | Ejemplo |
| --------- | ------------------------------ | ------------------------------------------- | -------- |
| $cond     | if / then / else               | { $cond: { if, then, else } }              | { $cond: { if: { $eq: ["$ciudad","Madrid"] }, then: "España", else: "Otro" } } |
| $ifNull   | Si null, usa valor alternativo | { $ifNull: [ <valor>, <alternativa> ] }    | { $ifNull: ["$telefono", "Sin teléfono"] } |
| $switch   | Múltiples condiciones (switch) | { $switch: { branches: [...], default } }  | { $switch: { branches: [ { case: { $eq: ["$rol","A"] }, then: "Admin" } ], default: "Invitado" } } |

🔹 De fechas:
| Operador    | Qué hace                   | Sintaxis                                      | Ejemplo |
| ----------- | -------------------------- | --------------------------------------------- | -------- |
| $year       | Extrae el año de una fecha | { $year: <fecha> }                            | { $year: "$fecha" } |
| $month      | Extrae el mes de una fecha | { $month: <fecha> }                           | { $month: "$fecha" } |
| $dateAdd    | Suma tiempo a una fecha    | { $dateAdd: { startDate, unit, amount } }     | { $dateAdd: { startDate: "$fecha", unit: "day", amount: 7 } } |
| $dateDiff   | Diferencia entre fechas    | { $dateDiff: { startDate, endDate, unit } }   | { $dateDiff: { startDate: "$inicio", endDate: "$fin", unit: "hour" } } |

🔹 De strings:
| Operador          | Qué hace                          | Sintaxis                                           | Ejemplo |
| ----------------- | --------------------------------- | -------------------------------------------------- | -------- |
| $concat           | Concatena cadenas                 | { $concat: [ <str1>, <str2> ] }                   | { $concat: ["$nombre"," ","$apellido"] } |
| $split            | Divide texto en array             | { $split: [ <texto>, <separador> ] }             | { $split: ["$email","@"] } |
| $substr           | Subcadena (*obsoleto*)            | { $substr: [ <texto>, <inicio>, <longitud> ] }   | { $substr: ["$nombre",0,3] } |
| $substrCP         | Subcadena (por caracteres reales) | { $substrCP: [ <texto>, <inicio>, <longitud> ] } | { $substrCP: ["$mensaje",0,10] } |
| $dateFromString   | String a fecha                    | { $dateFromString: { dateString: <str> } }       | { $dateFromString: { dateString: "$fechaTexto" } } |

🔹 De tipos:
| Operador    | Qué hace               | Sintaxis                      | Ejemplo |
| ----------- | ---------------------- | ----------------------------- | -------- |
| $convert    | Convierte tipo de dato | { $convert: { input, to } }   | { $convert: { input: "$edad", to: "int" } } |
| $isNumber   | Verifica si es número  | { $isNumber: <valor> }        | { $isNumber: "$precio" } |
| $type       | Devuelve tipo de dato  | { $type: <campo> }            | { $type: "$nombre" } |

🔹 Field Path:
| Expresión    | Qué hace                                  | Ejemplo |
| ------------ | ----------------------------------------- | -------- |
| "$<campo>"   | Accede a un campo del documento actual    | "$nombre" |
| $$CURRENT    | Referencia al documento actual (opcional) | $$CURRENT.precio |

### ver todos los valores únicos de un campo en cualquier colección
  db.NOMBRE_DE_LA_COLECCION.distinct("NOMBRE_DEL_CAMPO")
### Stages de agregación
* $match 		--> Filtra los documentos que pasan a la siguiente etapa
	{ $match: { <query filter> } } -- Con 
	{ $match:  { $expr: <aggregation expression> } }
		$expr permite filtrar documentos usando lógica o comparaciones entre campos dentro de una etapa $match.

* $project		--> Cambia la forma de cada documento, incluir/exluir campos, transformar campos(usando expresiones)
	{ 
	  $project: { 
	    <campo1>: 1 o true,   // incluir campo
	    <campo2>: 0 o false,  // excluir campo
	    <campo3>: <expresión de agregación> // transformar campo
	  } 
	}
	{ $project: { <specifications> } }
	{ $project:  { <field1>: < 1 or true>,  <field2>: < 0 or false>, <field3>: < aggregation expression>, … } }

* $skip			--> Omite los primero N documentos
* $limit		--> Limita el resultado a los primeros N documentos
* $sort			--> Ordena el flujo de documentos por uno o más campos
db.monthlyBudget.aggregate( [
    { $match: { $expr: { $gt: [ "$spent" , "$budget" ] } } },
    { 
      $project: { cat_prefix: { $substr: [ "$category", 0, 3 ] },
          excess: { $subtract: [ "$spent" , "$budget" ] }, _id: 0 }  
    },
    { $sort: { excess: -1, cat_prefix: 1 } }, 	-- SORT [1 ascendente | -1 descendente ]
    { $skip: 0 },								-- SKIP
    { $limit: 1 }								-- LIMIT
] )

* $count		--> Retorna la cantidad de documentos
db.monthlyBudget.aggregate( [ { $count: "numOfItems" } ] )

* $addFields o $set	--> Agrega nuevos campos a cada documento o modifica existentes
{ 
  $addFields: { 
    <nuevoCampo>: <expresión>,
    <campoExistente>: <nuevaExpresión> 
  } 
}
db.usuarios.aggregate([
  {
    $addFields: {
      mayorEdad: { $gte: [ "$edad", 18 ] },         // true si edad ≥ 18
      primerHobby: { $first: "$hobbies" }           // primer hobby del array
    }
  }
])

* $unwind -> Deconstruye un campo arreglo en el documento y crea documentos separados para cada elemento en el arreglo
	{ $unwind: "<campoArray>" }

* $replaceRoot -> 	Reemplaza el documento por un documento anidado especificado,solo para modificar la salida de aggregate()
					No cambia ni divide los documentos guardados en la colección
{ 
  $replaceRoot: { newRoot: <documento_o_campo> } 
}

* $group -> Agrupa los documentos por una expresión especificada y aplica las expresiones acumuladoras
{
  $group: {
    _id: <clave_de_agrupación>,    // Por qué campo agrupar (puede ser null)
    <campoNuevo>: { <acumulador>: <expresión> },
    ...
  }
}
| Acumulador  | ¿Qué hace?                           |
| ----------- | ------------------------------------ |
| `$sum`      | Suma valores                         |
| `$avg`      | Promedio                             |
| `$max`      | Máximo                               |
| `$min`      | Mínimo                               |
| `$first`    | Primer valor del grupo               |
| `$last`     | Último valor del grupo               |
| `$push`     | Mete valores en un array             |
| `$addToSet` | Mete valores únicos en un array      |
| `$count`    | Cuenta documentos (usando `$sum: 1`) |

* $count --> Se usa para contar los documentos que llegan a esa etapa. 
{ $count: "<nombre_del_campo_de_resultado>" }


* $unionWith -> Realiza la unión de dos colecciones
	👉 Devuelve los documentos de la colección actual y de la otra colección indicada.
	{ $unionWith: "<otraColeccion>" }  

	👉 Te permite aplicar una pipeline personalizada a la segunda colección antes de unirla.
	{
	  $unionWith: {
	    coll: "<otraColeccion>",
	    pipeline: [ { <etapa1> }, { <etapa2> }, ... ]
	  }
	}

<!-- db.usuarios.aggregate([
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
]) -->

* $out -> 	Almacena el resultado del pipeline en una colección, solo puede usarse como última etapa de la pipeline.
			✅ Crea base y colección si no existen
			⚠️ Sobrescribe si ya existen
	
	🔹 Básica (misma base de datos):
		{ $out: "nuevaColeccion" }  
	🔹 Con base de datos específica:
	{ $out: { db: "miBaseDeDatos", coll: "nuevaColeccion" } }


* $lookup -> - Realiza un left join a otra colección (Trae **todos** los documentos de la colección base, y agrega los datos coincidentes de la otra colección (o un array vacío si no hay coincidencias).)

			 - El resultado va en un array (as: ...)
			 - Si no hay coincidencias, el array queda vacío
			 - Ideal para relaciones simples uno a uno o uno a muchos
		Para que $lookup funcione y junte documentos, el valor del campo local (localField) debe ser
		igual al valor del campo externo (foreignField).
		Si no coinciden, el resultado será un array vacío en el campo definido por as.
🔗 $lookup
{
  $lookup: {
    from: "<coleccion_destino>",        // La colección con la que querés hacer join
    localField: "<campo_local>",        // Campo de la colección actual
    foreignField: "<campo_externo>",    // Campo en la colección externa
    as: "<campo_resultado>"             // Nombre del nuevo campo donde se guarda el resultado (es un array)
  }
}

🔗 $lookup con let y pipeline
{
  $lookup: {
    from: "<coleccion_destino>",      // colección para unir
    let: { var1: <expresión>, ... },  // variables que podés usar en pipeline
    pipeline: [ <pipeline para filtrar/transformar la colección destino> ],
    as: "<campo_salida>"              // campo donde se guarda el resultado (array)
  }
}

Ej:
Collecion Usuarios
	{ _id: 1, nombre: "Ana", ciudad_id: 10 }
Colección ciudades:
	{ _id: 10, nombre: "Buenos Aires" }
	{ _id: 11, nombre: "Rosario" }

db.usuarios.aggregate([
  {
    $lookup: {
      from: "ciudades",
      let: { ciudadUsuario: "$ciudad_id" },    // define variable con valor del usuario
      pipeline: [
        { $match: { $expr: { $eq: ["$_id", "$$ciudadUsuario"] } } }
      ],
      as: "infoCiudad"
    }
  }
])


## 'db.createView': Crea una vista, que es como una colección virtual basada en el resultado de una pipeline de agregación sobre otra colección.
db.createView("<nombreVista>", "<colecciónOrigen>", [ <pipeline> ])
	<nombreVista>: nombre de la vista que vas a crear
	<colecciónOrigen>: la colección sobre la que se aplica la pipeline
	[ <pipeline> ]: arreglo con etapas de agregación que transforman los datos
	