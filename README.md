# JavaSprint2_2MySQL_Consultas en Bases de Datos Tienda y Universidad 
## 📄 Descripción - Enunciado del ejercicio
Este proyecto implementa una serie de consultas SQL en dos bases de datos MySQL: tienda (una tienda de productos electrónicos) y universidad (un sistema de gestión universitaria). Las consultas cubren operaciones básicas y avanzadas como selecciones, filtros, joins, agregaciones, subconsultas y uso de LEFT/RIGHT JOIN.
El sistema permite:

Ejecutar más de 80 consultas SQL predefinidas sobre las tablas proporcionadas.
Explorar datos de productos, fabricantes, alumnos, profesores, asignaturas, departamentos y matriculaciones.
Demostrar técnicas SQL como ORDER BY, LIMIT, GROUP BY, HAVING, JOIN, LEFT JOIN, subconsultas y funciones de cadena/fecha.
Generar resultados claros y ordenados para análisis educativo.

Este ejercicio refuerza el dominio de SQL en entornos reales, incluyendo el manejo de relaciones uno-a-muchos, datos nulos y optimización de consultas.
## 💻 Tecnologías Utilizadas

MySQL 5.7+ (compatible con MySQL 8.0)
MySQL Workbench o DBeaver (recomendado para visualización)
Cliente SQL (línea de comandos, phpMyAdmin, etc.)
No requiere bibliotecas externas ni frameworks

## 📋 Requisitos

Tener instalado MySQL Server y un cliente SQL.
Acceso de usuario con permisos para crear bases de datos, tablas e insertar datos.
Conexión local o remota a MySQL (por defecto: localhost:3306, usuario root).

## 🛠️ Instalación


Clona este repositorio:
```
git clone https://github.com/jrffruit518-enrich/JavaSprint2_2MySQL_Consultas.git
```

Accede al directorio:
```
cd SQLSprint1_TiendaUniversidad
```

Inicia MySQL y conéctate:
```
mysql -u root -p
```

Ejecuta los scripts SQL en orden:

Primero: create_tienda.sql (crea y popula la BD tienda)
Segundo: create_universidad.sql (crea y popula la BD universidad)

Ejemplo:
textSOURCE /ruta/create_tienda.sql;
SOURCE /ruta/create_universidad.sql;


## ▶️ Ejecución


Usa la base de datos correspondiente:
```
USE tienda;
```
o
```
USE universidad;
```

Ejecuta las consultas numeradas (ejemplos):
En tienda:
```
#1: Lista nombres de productos
```
SELECT nombre FROM producto;
En universidad:
```
 #1: Alumnos ordenados por apellidos
```
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;


Visualiza resultados directamente en la consola o Workbench.
Ejemplo de salida (#24 tienda):
text+-----------------------------+--------+---------------------+
| nombre                      | precio | nombre_fabricante   |
+-----------------------------+--------+---------------------+
| Impresora HP Deskjet 3720  |  59.99 | Hewlett-Packard     |
+-----------------------------+--------+---------------------+


## 🌐 Despliegue
Proyecto educativo local. Para uso en servidor:

Exporta las BD:
```
mysqldump -u root -p tienda > tienda_backup.sql
```
Restaura en servidor remoto:
```
mysql -h remoto -u user -p nueva_tienda < tienda_backup.sql
```
Accede vía phpMyAdmin o aplicación web (conectar con JDBC/ODBC si integras en Java).

## 🤝 Contribuciones
¡Bienvenidas! Sigue estos pasos:

Haz fork del repositorio.
Crea rama:
```
git checkout -b feature/nueva-consulta
```
Añade tu consulta SQL en consultas_extra.sql.
Commit:
```
git commit -m "Añade consulta: alumnos por grado"
```
Push y Pull Request.