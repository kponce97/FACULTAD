	# Validacion de Esquema: Permite especificar reglas de validacion a los documentos, se ejecuta en los INSERT y UPDATE

## VE JSON:
db.createCollection( "<name>", { validator: <document>, validationLevel: <string>, validationAction: <string> } )
db.runCommand( { collMod: "<name>", validator: <document>, validationLevel: <string>, validationAction: <string> } )
| Comando           | Qué hace                                               | Ejemplo                                                                                          |
| ----------------- | ------------------------------------------------------ | ------------------------------------------------------------------------------------------------ |
| `create`          | Crear una colección                                    | `db.runCommand({ create: "users" })`                                                             |
| `drop`            | Borrar colección                                       | `db.runCommand({ drop: "users" })`                                                               |
| `collStats`       | Estadísticas de la colección                           | `db.runCommand({ collStats: "users" })`                                                          |
| `listCollections` | Listar colecciones                                     | `db.runCommand({ listCollections: 1 })`                                                          |
| `collMod`         | Modificar colección existente (validator, capped, TTL) | `db.runCommand({ collMod: "users", validator: {...} })`                                          |
| `createIndexes`   | Crear índices                                          | `db.runCommand({ createIndexes: "users", indexes: [{ key: { email: 1 }, name: "email_idx" }] })` |
| `dropIndexes`     | Borrar índices                                         | `db.runCommand({ dropIndexes: "users", index: "*" })`                                            |
| `convertToCapped` | Convertir en capped collection                         | `db.runCommand({ convertToCapped: "logs", size: 5242880 })`                                      |
| `ping`            | Verificar conexión al servidor                         | `db.runCommand({ ping: 1 })`                                                                     |


### JSONSchema
db.createCollection( "<name>", { 
	validator: {	
		$jsonSchema: {
			<keyword1>: <value1>,
			<keyword2>: <value2>,
			<keyword3>: <value3>,
			…
		} 
	},
	validationLevel: <string>, 
	validationAction: <string> 
})

### JSONSchema KEYWORDS
- bsonType --> Acepta los mismos alias en string usados por el operador $type
- required --> El documento debe contener todos los elementos especificados en el arreglo
- properties --> Un esquema JSON válido donde cada valor es un esquema JSON válido
- additionalProperties --> Especifica si se permiten campos adicionales
- minimum, maximum --> Indica el valor mínimo (máximo) del campo
- minItems, maxItems --> Indica la longitud mínima (longitud máxima) del arreglo
- minLength / maxLength → longitud mínima/máxima de strings
- pattern → regex para strings
- enum → valores permitidos (ej: enum: ["A","B","C"])
- items → reglas para elementos de un array
	- uniqueItems: true → obliga a que no haya duplicados
- additionalProperties → si se permiten campos extra (false = no permitir)

| `bsonType`          | Descripción breve                         |
| ------------------- | ----------------------------------------- |
| `double`            | Número decimal (flotante).                |
| `string`            | Cadena de texto.                          |
| `object`            | Documento embebido.                       |
| `array`             | Arreglo de valores.                       |
| `binData`           | Datos binarios.                           |
| `objectId`          | Identificador único `_id` (ObjectId).     |
| `bool`              | Valor booleano (`true`/`false`).          |
| `date`              | Fecha (objeto `Date`).                    |
| `null`              | Valor nulo.                               |
| `regex`             | Expresión regular.                        |
| `int`               | Entero de 32 bits.                        |
| `long`              | Entero de 64 bits.                        |
| `decimal`           | Decimal de alta precisión (`Decimal128`). |
| `timestamp`         | Marca de tiempo interna de MongoDB.       |
| `undefined`         | Tipo indefinido (obsoleto).               |
| `minKey` / `maxKey` | Valores especiales para ordenamiento.     |

### Con Operadores de Seleccion: Permite especificar validaciones que comparan múltiples campos
db.createCollection( "orders",
  {
      validator: {
    	$expr: {
        	      $eq: [
                        "$totalWithIVA",
          	            { $multiply: [ "$total", "$IVA" ] }
        	      ]
      	}
      }
  }
)

### ValidationLevel: Permiten especificar cómo aplicar las reglas de validación a documentos ya existentes
- 			strict: (valor por defecto) Las reglas de validación se aplican a todos los inserts y updates.
- 			moderate : Las reglas de validación solo se aplican a los documentos existentes válidos. 

### ValidationAction: Permiten especificar cómo manejar los documentos que no cumplen la validación
- 			error: (valor por defecto) MongoDB rechaza cualquier insert o update que no cumple la regla de validación
- 			warn: MongoDB permite que operación continúe, pero registra la infracción en los logs de MongoDB 
Ejemplo:
	db.createCollection("usuarios", {
	  validator: {
	    $jsonSchema: {
	      bsonType: "object",
	      required: ["nombre", "edad"],
	      properties: {
	        nombre: { bsonType: "string" },
	        edad: { bsonType: "int", minimum: 18 }
	      }
	    }
	  },
	  validationLevel: "strict",   // valida todos los documentos (también los existentes en update)
	  validationAction: "error"    // rechaza los documentos que no cumplan (alternativa: "warn")
	});

## Metadata
Este comando devuelve información sobre las colecciones existentes en una base de datos.
- Mostrar la regla de validación de una colección
- Mostrar información solo de una colección específica
	db.getCollectionInfos({ name: "collection" })
	  
1. Mostrar todas las colecciones de la base de datos actual
	db.getCollectionInfos()  


Muestra los campos de una coleccion
let info = db.getCollectionInfos({ name: "<collection>" })[0];
Object.keys(info.options.validator.$jsonSchema.properties);

let info = db.getCollectionInfos({ name: "listingsAndReviews" })[0];
Object.keys(info.options.validator.$jsonSchema.properties);
