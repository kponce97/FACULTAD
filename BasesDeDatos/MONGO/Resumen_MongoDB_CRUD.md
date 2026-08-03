# 📘 Introducción a MongoDB y Operaciones CRUD

## 🧩 Conceptos básicos

MongoDB es una base de datos **NoSQL orientada a documentos**. -
Almacena los datos como **documentos BSON** (binario de JSON). - Los
documentos se guardan en **colecciones** y cada base de datos puede
tener varias. - Cada documento contiene pares **campo: valor**, pudiendo
incluir **arreglos** y **documentos anidados**. - El campo \*\*\_id\*\*
es único e inmutable; actúa como **clave primaria**.

## 💻 Comandos básicos (mongosh)

-   `show dbs` → lista bases de datos\
-   `use <db>` → cambia la base de datos actual\
-   `show collections` → muestra colecciones\
-   `db.createCollection(name)` → crea una colección\
-   `db.<collection>.help()` → muestra ayuda

## ⚙️ Operaciones CRUD

### 1. Create (Insertar)

-   `insertOne(doc)` → inserta un documento\
db.<coleccion>.insertOne({ <campo1>: <valor1>, <campo2>: <valor2>, ... })
-   `insertMany([doc1, doc2])` → varios documentos
db.<coleccion>.insertMany([{ <campo1>: <valor1> }, { <campo1>: <valor1> }, ...])

### 2. Read (Leer)
-   `find(filter, projection)` → devuelve documentos que cumplan un filtro\
db.<coleccion>.find(<filtro>, <proyeccion>)

-   `findOne(filter, projection)` → devuelve el primero que cumpla\
db.<coleccion>.findOne(<filtro>, <proyeccion>)
-   **Projection:** selecciona qué campos mostrar (`1` = incluir, `0` = excluir).\
-   Se pueden proyectar **campos anidados** usando `"campo.subcampo"`.

### 3. Update (Actualizar)
-   `updateOne(filtro, { $set: { campo: valor } })`\
db.<coleccion>.updateOne(<filtro>, { <operador>: { <campo>: <valor> } })
-   `updateMany(...)`\
db.<coleccion>.updateMany(<filtro>, { <operador>: { <campo>: <valor> } })
-   **Operadores:** `$set`, `$inc`, `$unset`, `$rename`, `$addToSet`,
    `$currentDate`\
-   `upsert:true` → crea el documento si no existe

### 4. Delete (Eliminar)

-   `deleteOne(filtro)` / `deleteMany(filtro)`\
-   `db.<coleccion>.drop()` → elimina toda la colección

## 🔍 Consultas con FIND

**Operadores de comparación:** `$eq`, `$ne`, `$gt`, `$gte`, `$lt`,`$lte`, `$in`, `$nin`\
**Operadores lógicos:** `$and`, `$or`, `$not`, `$nor`\
**Consultas en documentos anidados:** `"campo.subcampo": valor`\
**Consultas en arreglos:** `$all`, `$elemMatch`, `$size`\
**Campos nulos o ausentes:** `$exists`, `$type`, `campo: null`\
**Regex:** búsquedas por patrón

## 🧭 Métodos del cursor

-   `.sort({campo: 1/-1})` → orden asc/desc\
-   `.skip(n)` → omite los primeros n\
-   `.limit(n)` → limita los resultados

**Ejemplo:**

``` js
db.inventory.find(
  {status: "A"},
  {item: 1, qty: 1}
).sort({qty: -1, item: 1}).limit(3)
```

## 🔁 Upsert

Combina *update* + *insert*:

``` js
db.analytics.updateOne(
  {url: "/blog"},
  {$inc: {pageviews: 1}},
  {upsert: true}
)
```

## 🧾 En resumen

MongoDB guarda datos flexibles en documentos tipo JSON.\
Permite manipularlos con comandos CRUD, filtrar usando operadores, y
controlar la salida con proyecciones y métodos del cursor.\
Es ideal para datos no estructurados o semiestructurados.
