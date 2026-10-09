# Periodic Table Database

Base de datos PostgreSQL con información de elementos químicos y un script en Bash (`element.sh`) que consulta cualquier elemento por **número atómico**, **símbolo** o **nombre**.

Proyecto del currículo de [freeCodeCamp](https://www.freecodecamp.org/) (Relational Database).

## Demo

```bash
$ ./element.sh 1
The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.

$ ./element.sh Ne
$ ./element.sh Fluorine

$ ./element.sh xyz
I could not find that element in the database.

$ ./element.sh
Please provide an element as an argument.
```

## Tecnologías

- PostgreSQL
- Bash
- Git

## Estructura del repositorio

| Archivo | Descripción |
|---|---|
| `element.sh` | Script que consulta la base de datos y muestra la información del elemento |
| `periodic_table.sql` | Dump de la base de datos para reconstruirla |

## Esquema de la base de datos

- **elements**: `atomic_number` (PK), `symbol` (único, no nulo), `name` (único, no nulo)
- **properties**: `atomic_number` (PK, FK → elements), `atomic_mass`, `melting_point_celsius`, `boiling_point_celsius`, `type_id` (FK → types)
- **types**: `type_id` (PK), `type`

Relaciones: `elements` 1 — 1 `properties` y `types` 1 — N `properties`.

### Cambios realizados sobre la base de datos original

- Renombré `weight` a `atomic_mass` y las columnas de temperatura a `*_celsius`.
- Agregué restricciones `NOT NULL`, `UNIQUE` y llaves foráneas.
- Normalicé los tipos de elemento en la tabla `types`.
- Capitalicé los símbolos y eliminé los ceros finales de `atomic_mass`.
- Agregué Fluorine y Neon, y eliminé un elemento inexistente (número atómico 1000).

## Cómo usarlo

### Requisitos

- PostgreSQL instalado y en ejecución
- Bash
- Un rol `freecodecamp` en PostgreSQL


### Ejecución

```bash
./element.sh <número atómico | símbolo | nombre>
```

## Cómo funciona `element.sh`

1. Si no recibe argumento, muestra un mensaje y termina.
2. Si el argumento es solo dígitos, busca por número atómico; si no, busca por símbolo o nombre.
3. Une las tres tablas con `INNER JOIN` y obtiene todos los datos en una sola consulta.
4. Si no hay resultado, avisa que el elemento no existe; si lo hay, imprime la descripción.

## Lo que aprendí

- Modificar un esquema existente con `ALTER TABLE` sin perder datos.
- Normalizar datos con tablas relacionadas y llaves foráneas.
- Combinar consultas SQL con scripts de Bash.
- Trabajar con commits pequeños y mensajes convencionales (`feat:`, `fix:`, `chore:`).

## Autor

**Chaggy** · [GitHub](https://github.com/ChaggyEKTPK)
