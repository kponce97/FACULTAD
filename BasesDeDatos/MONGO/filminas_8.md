📘 Resumen de MongoDB (breve y completo):

# Estructura:
	MongoDB almacena colecciones, que contienen documentos.
	Un documento es un objeto BSON (JSON extendido) con pares campo–valor.
	El campo _id es la clave primaria y se genera automáticamente si no se define.
	Ejemplo de documento:
		{
		  "_id": "153499",
		  "name": "Joe Moore",
		  "age": 22,
		  "phones": ["1234455", "1244555"],
		  "address": { "street": "Joe", "state": "Moore" }
		}

# Mongo DB Shell (mongosh y mongo)
	Comandos Basicos
		- show dbs 	--> Lista todas las BD del servidor
		- use <db> 	--> Cambia la BD actual a <db>
		- db 		--> Variable que representa la BD actual 
		- show collections --> Lista todas la colecciones de la BD actual
		- db.createColletion(name,<options>) --> Crea una nueva colecciones
		- db.<collection>.help() --> Muestra ayuda sobre metodos de coleccion
 

# Operaciones CRUD
## 	Insertar:
	insertOne(doc) / insertMany([doc1, doc2])
##	Leer (find):
		find(filter, projection) → devuelve un cursor, 
		findOne(filter, projection) → devuelve el primer resultado
		Proyección: define qué campos incluir/excluir (1 mostrar, 0 ocultar).
		Campos anidados con "campo.subcampo".
##	Actualizar:
		updateOne(filtro, { $set: { campo: valor } })
		Operadores: $set, $inc, $unset, $rename, $mul
		upsert:true → si no existe, lo crea.
##	Eliminar:
		deleteOne(filtro) / deleteMany(filtro)
		db.<coleccion>.drop() → borra toda la colección

# Filtros y operadores
	**Comparación**: 			$eq, $ne, $gt, $gte, $lt, $lte, $in, $nin 	| db.<collection>.find({ <field>: { <operator>: <value> }, ... })
	**Lógicos**: 				$and, $or, $not, $nor						| db.<collection>.find( { <operator>: [ { clause1 }, { clause2 }, … ] })
	**Arreglos**: 				$all, $elemMatch, $size						| db.<collection>.find( { <array field>: { <operator>: <value> }, ... })
	**Campos anidados**: 		"campo.subcampo": valor						| db.inventory.find( { "size.w": { $gte: 16 } } )
	**Nulos / existencia**: 	$exists, $type, campo: null					| db.<collection>.find( { <campo>: <valor> } ) || .find({ item: { $type: "string" } })
	**Regex**: 					búsquedas por expresiones regulares.		

-- MongoDB: Almacena los datos como documentos BSON, y almacena los documentos 
--			en COLECCIONES, una BD almacena una o mas colecciones de doc.
-- 			Un documento es una estructura de datos compuesta de pares CAMPO - VALOR
	MongoDB almacena colecciones
	Cada colección contiene documentos
	Los documentos son objetos JSON (BSON) con datos y campos
-- Bases de Datos No Relacionales (NoSQL)

/* 
Campo _id -> Actua como clave primaria, es inmutable, si se omite al insertar un doc, se 
autogenera
 */

# -- Documento
{
	"_id": "153499", -- field: value
	"name": "Joe Moore", 
	"age": 22,
	"phones":["1234455","1244555"], -- Arreglo
	"address": {
		"street":"Joe",
		"phones": "Moore", -- Documento Anidado
		"state": "Moore"
	}
}

/* 
# Mongo DB Shell (mongosh y mongo)
	Comandos Basicos
		- show dbs 	--> Lista todas las BD del servidor
		- use <db> 	--> Cambia la BD actual a <db>
		- db 		--> Variable que representa la BD actual 
		- show collections --> Lista todas la colecciones de la BD actual
		- db.createColletion(name,<options>) --> Crea una nueva colecciones
		- db.<collection>.help() --> Muestra ayuda sobre metodos de coleccion
 */

/* 
# Operaciones CRUD
> db.<collection>.insertOne(<document>) // Inserta un solo documento en la colección
> db.<collection>.insertMany([ <doc1>, ..., <docN> ])  // Inserta varios documentos a la vez
> db.<collection>.findOne(<query filter>, <projection>) // Busca y devuelve el primer documento que cumpla el filtro
> db.<collection>.find(<query filter>, <projection>)    // Busca y devuelve todos los documentos que cumplan el filtro
> db.<collection>.updateOne(<query filter>, <update>, <options>) // Actualiza el primer documento que cumpla el filtro
> db.<collection>.updateMany(<query filter>, <update>, <options>) // Actualiza todos los documentos que cumplan el filtro
> db.<collection>.deleteOne(<query filter>)  // Elimina el primer documento que cumpla el filtro
> db.<collection>.deleteMany(<query filter>) // Elimina todos los documentos que cumplan el filtro
 */
--Ver todos los valores únicos de "campo" en una colección:
>	db.coleccion.distinct("campo", { filtro_opcional }) { filtro_opcional }: (opcional) para filtrar documentos antes.

 
# CRUD - FIND 
>	db.<collection>.find( 
>		<query filter>,
>		<projection>
>	)
	- find retorna los doc que matchean con el criterio, el resultado es un CURSOR
	- projection especifica los campos a devolver de los doc que matchean con el filtro

# FIND: Controlas qué campos quieres mostrar en los resultados. Eso es lo que se llama proyección (1 = mostrar, 0 = ocultar).
## Campos anidados:
		db.inventory.find({}, { "size.uom": 1, _id: 0 }) | db.inventory.find({},{ "size":{"uom": 1}, _id: 0})
		db.bios.find({}, { "name.last": 1 }) | db.bios.find({}, { "name": { "last": 1 } })


## Proyección con expresiones de agregación (más avanzado):
Permite calcular nuevos campos o transformar existentes. Esto no se hace con .find() directamente, sino dentro del pipeline de agregación:
db.coleccion.aggregate([
  {
    $project: {
      nuevoCampo: { $concat: ["$nombre", " ", "$apellido"] }
    }
  }
])
## Operadores de SELECCION:

###	Operadores de Comparación
	          db.<collection>.find({ <campo>: { <operador>: <valor> }, ... })
			  	-- Devuelve los menores a 30: db.inventory.find( { qty: { $lt: 30 } })

 _______________________________________________________________________
| Operadores  | Función       | Ejemplo                          		|
|-------------|---------------|-----------------------------------------|
| $eq         | igual         | { edad: { $eq: 25 } }            		|
| $gte        | mayor_igual   | { edad: { $gte: 18 } }           		|
| $ne         | distinto      | { nombre: { $ne: "Juan" } }      		|
| $lt         | menor         | { precio: { $lt: 100 } }         		|
| $gt         | mayor         | { precio: { $gt: 50 } }          		|
| $lte        | menor_igual   | { edad: { $lte: 65 } }           		|
| $in         | incluido      | { ciudad: { $in: ["Lima", "Quito"] } }  |
| $nin        | excluido      | { pais: { $nin: ["Chile", "Perú"] } }   |
 -----------------------------------------------------------------------|

###	Operadores Logicos
    db.<collection>.find( { <operador>: [ { clause1 }, { clause2 }, … ] })
    db.<collection>.find( { <operador>: { clause } })
	
	-- Devuelve los que tienen estado A y menores a 30: 
	db.inventory.find( { $and: [ {"status":  "A"} , {"qty": {$lt: 30} ] } )
_______________________________________________________________________________________
| Operadores  | Función | Ejemplo                                  					   |
|-------------|---------|--------------------------------------------------------------|
| $and        | todas   | { $and: [ { edad: { $gte: 18 } }, { edad: { $lte: 65 } } ] } |
| $nor        | ninguna | { $nor: [ { ciudad: "Lima" }, { ciudad: "Quito" } ] }        |
| $or         | alguna  | { $or: [ { nombre: "Ana" }, { nombre: "Luis" } ] }           |
| $not        | niega   | { edad: { $not: { $gte: 18 } } }                             |
 --------------------------------------------------------------------------------------|


##	Consulta documentos anidados
	db.inventory.find( { "size.w": { $gte: 16 } } ) -- Devuelve los size.w >= 16 (mayor igual)

## REGEX

## Consulta en arreglo
	db.<collection>.find( { <array field>: { <operator>: <value> }, ... })
	- Matchear un arreglo: db.food.find( {"fruits":  ["cherry", "banana" ] } )
	 _______________________________________________________________________________________________________________
	| Operadores	| Funcion																						|
	|---------------|-----------------------------------------------------------------------------------------------|
	|	$all 		| matchea si el campo arreglo contiene todos los elementos especificados en value				|
	|	$elemMatch  | matchea si al menos un elemento en el campo arreglo cumple todas las condiciones especificadas|
	|	$size 		| matchea si el campo arreglo es del largo especificado											|

## Consulta por nulos o campos ausentes 
	db.inventory.find( { item: null } ) -- > Matchear por campo null o ausente
	db.inventory.find({ item: { $type: "string" } }) -- > Matchea por tipo
	db.inventory.find({ item: { $exists: true } }) -- > Matchea por existencia ( Busca docs donde exista el campo item)

## Métodos del cursor - SORT SKIP LIMIT
	db.<collection>.find(<query filter>, <projection>)
		.sort({ <field1>: <1 or -1>, <field2>: <1 or -1> ... }) -- > 1 Ascendente | -1 Descendente
		.skip(<offset>)	-- > Salta los primero N (offset) doc
		.limit(<number>) -- > Limita la cantidad de resultados.
  	Ejemplo:
  		Listar los 3 items con mayor cantidad dentro de los inventarios con estado "A". Listar en 
  		orden alfabético si los items tiene la misma cantidad.
		db.inventory.find(
  			{ "status": "A" },              // Filtra por status = "A"
  			{ "item": 1, "qty": 1 }         // Proyección: muestra solo item y qty (más _id por defecto)
			)
			.sort({ qty: -1, item: 1 })       // Ordena por qty descendente, luego item ascendente
			.skip(0)                          // Salta 0 documentos (es decir, no salta ninguno)
			.limit(3)                         // Limita a 3 resultados

## UPDATE - DELETE
###	Update 
		db.<coleccion>.updateOne(     // o updateMany
		  	{ <filtro> },               // condición para encontrar el documento
  			{ <operador_de_actualización>: { <campo>: <valor> } }
			$currentDate: { lastModified: true } // Esto pone lastModified con la fecha/hora actual en ese documento.)
		---------------------------------------------
		|Operador	| Funcion						|
		|-----------|-------------------------------|
		|	$set	|	Cambia el valor de un campo |
		|	$inc	|	Incrementa un campo numérico|
		|	$unset	|	Elimina un campo			|
		|	$rename	|	Cambia el nombre de un campo|
		|	$mul	|	Multiplica un valor			|
		---------------------------------------------
### Update + Insert
		- Si hay un doc con url: "/blog", suma 1 a pageviews.
		- Si no existe, crea un nuevo documento con { url: "/blog", pageviews: 1 }.
		db.analytics.updateOne(
		  { url: "/blog" },             // filtro para encontrar documento
		  { $inc: { pageviews: 1 } },  // incrementa pageviews en 1
		  { upsert: true }             // si no existe, crea con url="/blog" y pageviews=1
		)
###	Delete
		deleteOne -- > Elimina el primer documento que coincida con el filtro
		db.inventory.deleteMany( { status: "A" } ) -- > Elimina todos los documentos que coincidan con el filtro.
		db.inventory.drop() -- > Elimina toda la coleccion.