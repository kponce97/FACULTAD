# Modelado de Datos

## Estrategias de modelado de datos

### Embedede (Anidado)
	// Persona
	{
		_id: "123,
		name: "Kevin Ponce",
		age: 28,
		pets: [
			{name:"boby", type:"Dog"}  // Documentos anidados
			{name:"mishi", type:"Cat"}
		]

	}

### References (Referenciado)
	// Producto								 //Review
	{											{
		_id:"1", _________________					review_id: "678",
		name: "Tomate",			  |_______________> product_id: 1,   // Referencia al ID del Producto
		desc: "Verduras",							author: "Kevin",
		price:119.99								text: "This is need",
	}												published:date: ISODate("2019-02-18")
												}
	 	
## Modelado de Relaciones

### One - To - One
- Embebida
✅ Sencillo y eficiente cuando los datos siempre se consultan juntos.
{
  _id: 1,
  nombre: "Juan",
  perfil: {
    edad: 30,
    direccion: "Calle 123"
  }
}

- Referenciada
✅ Util cuando el documento relacionado se consutla  o actualiza separado.
// Colección usuarios
{ _id: 1, nombre: "Juan", perfilId: 10 }

// Colección perfiles
{ _id: 10, edad: 30, direccion: "Calle 123" }

### One - To - Many
- Embebida (subdocumentos en un mismo doc)
{
  _id: 1,
  nombre: "Juan",
  pedidos: [
    { id: 101, producto: "Laptop", total: 1200 },
    { id: 102, producto: "Mouse", total: 25 }
  ]
}
✅ Ideal cuando los "muchos" (pedidos) siempre se consultan junto al "uno" (usuario).

- Referenciada (colecciones separadas)
// usuarios
{ _id: 1, nombre: "Juan" }

// pedidos
{ _id: 101, usuarioId: 1, producto: "Laptop", total: 1200 }
{ _id: 102, usuarioId: 1, producto: "Mouse", total: 25 }
✅ Mejor si los “muchos” crecen mucho o se consultan por separado.
	 
## Embedding VS Referencing

| Característica             | **Embebido** 🧩                          | **Referenciado** 🔗                              |
| -------------------------- | ---------------------------------------- | ------------------------------------------------ |
| **Rendimiento en lectura** | Rápido (todo en un solo documento)       | Más lento (requiere `lookup` o varias consultas) |
| **Actualizaciones**        | Más costosas si el documento crece mucho | Más fáciles y específicas                        |
| **Tamaño del documento**   | Limitado a 16 MB                         | Sin esa limitación                               |
| **Consistencia**           | Siempre coherente (datos juntos)         | Puede requerir sincronización manual             |
| **Flexibilidad**           | Menor (estructura fija)                  | Mayor (relaciones más complejas)                 |
| **Uso ideal**              | Datos que siempre se consultan juntos    | Datos grandes o con relaciones variables         |

## Modelado de Datos Dirigido por Queries = diseñar el modelo pensando en **las consultas más importantes**, no solo en las entidades.

**Pasos:**
1. Identificar entidades y relaciones.
2. Definir las queries clave.
3. Analizar su frecuencia y rendimiento.
4. Modelar usando **anidación** o **referencias** según convenga.

🎯 **Objetivo:** que las queries principales se resuelvan **en una sola operación**, sin usar `$lookup`.

La regla que te dieron es fundamental:
	“Una consulta es eficiente si se puede responder en una sola query sin $lookup.”
	Por eso:
		Si una entidad se usa siempre junto con otra, anídala.
		Si una entidad se usa en contextos distintos, mantenla separada con referencias.