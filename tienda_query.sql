USE tienda;

#1 Lista el nombre de todos los productos que hay en la mesa producto.
SELECT nombre 
FROM producto;

#2 Lista los nombres y los precios de todos los productos de la mesa producto.
SELECT nombre,precio
FROM producto;

#3 Lista todas las columnas de la tabla producto.
SELECT *
FROM producto;

#4 Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
SELECT 
nombre,
FORMAT(precio,2) AS precio_euro,
FORMAT(ROUND(precio*1.1,2),2) AS precio_usd
FROM producto;

#5 Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes sobrenombre para las columnas: nombre de producto, euros, dólares.
SELECT 
nombre AS 'nombre de producto',
FORMAT(precio,2) AS euros,
FORMAT(ROUND(precio*1.1,2),2) AS dólares
FROM producto;

#6 Lista los nombres y los precios de todos los productos de la mesa producto, convirtiendo los nombres a mayúscula.
SELECT UPPER(nombre) AS nombre_mayúscula,
       precio
FROM producto;

#7 Lista los nombres y los precios de todos los productos de la mesa producto, convirtiendo los nombres a minúscula.
SELECT LOWER(nombre) AS nombre_minúscula,
       precio
FROM producto;

#8 Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
SELECT nombre, 
UPPER(SUBSTRING(nombre,1,2)) AS iniciales_mayus
FROM fabricante;
       
#9 Lista los nombres y los precios de todos los productos de la mesa producto, redondeando el valor del precio.
SELECT nombre,
       ROUND(precio) AS round_price
FROM producto;

#10 Lista los nombres y precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
SELECT nombre,
       TRUNCATE(precio,0) AS price_without_decimal
FROM producto;

#11 Lista el código de los fabricantes que tienen productos en la mesa producto.
SELECT f.codigo
FROM fabricante AS f
JOIN producto AS p
ON f.codigo = p.codigo_fabricante;

#12 Lista el código de los fabricantes que tienen productos en la mesa producto, eliminando los códigos que aparecen repetidos.
SELECT DISTINCT f.codigo
FROM fabricante AS f
JOIN producto AS p
ON f.codigo = p.codigo_fabricante；

#13 Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre
FROM fabricante
ORDER BY nombre;

#14 Lista los nombres de los fabricantes ordenados de forma descendente.
SELECT nombre
FROM fabricante
ORDER BY nombre DESC;

#15 Lista los nombres de los productos ordenados, en primer lugar, por el nombre de forma ascendente y, en segundo lugar, por el precio de forma descendente.
SELECT nombre,precio
FROM producto
ORDER BY nombre ASC,precio DESC;

#16 Devuelve una lista con las 5 primeras filas de la mesa fabricante.
SELECT * 
FROM fabricante
LIMIT 5;

#17 Devuelve una lista con 2 filas a partir de la cuarta fila de la mesa fabricante. La cuarta fila también debe incluirse en la respuesta.
SELECT * 
FROM fabricante
LIMIT 2 OFFSET 3;

#18 Lista el nombre y precio del producto más barato. (Utiliza solo las cláusulas ORDER BY y LIMIT). NOTA: Aquí no podría usar MIN(precio), necesitaría GROUP BY.
SELECT nombre,precio
FROM producto
ORDER BY precio ASC 
LIMIT 1;

#19 Lista el nombre y precio del producto más caro. (Utiliza solo las cláusulas ORDER BY y LIMIT). NOTA : Aquí no podría usar MAX(precio), necesitaría GROUP BY.
SELECT nombre,precio
FROM producto
ORDER BY precio DESC
LIMIT 1;

#20 Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
SELECT nombre
FROM producto
WHERE codigo_fabricante = 2;

#21 Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
SELECT p.nombre,
       p.precio,
       f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo;

#22 Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordena el resultado por el nombre del fabricante, por orden alfabético.
SELECT p.nombre,
       p.precio,
       f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY f.nombre ASC;

#23 Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT p.codigo,
       p.nombre,
       f.codigo AS fabricante_codigo,
       f.nombre AS fabricante_nombre    
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo;

#24 Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT p.nombre,
       p.precio,
       f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio ASC 
LIMIT 1;

#25 Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
SELECT p.nombre,
       p.precio,
       f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio DESC 
LIMIT 1;

#26 Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT *
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Lenovo';

#27 Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
SELECT *
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Crucial' AND p.precio > 200;

#28 Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard Seagate. Sin utilizar el operador IN.
SELECT *
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';

#29 Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
SELECT *
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre IN('Asus','Hewlett-Packard','Seagate');

#30 Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre acabe por la vocal e.
SELECT p.nombre,
       p.precio,
       f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%e';

#31 Devuelve un listado con el nombre y precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
SELECT p.nombre,
       p.precio,
       f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%w%';


#32 Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. 
#Ordena el resultado, en primer lugar, por el precio (en orden descendente) y, en segundo lugar, por el nombre (en orden ascendente).
SELECT p.nombre,
       p.precio,
       f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio>=180
ORDER BY p.precio DESC,p.nombre ASC;

#33 Devuelve un listado con el código y el nombre de fabricante, sólo de aquellos fabricantes que tienen productos asociados en la base de datos.
SELECT DISTINCT 
       f.codigo,
       f.nombre
FROM fabricante AS f
JOIN producto AS p ON p.codigo_fabricante = f.codigo;

#34 Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. 
#El listado deberá mostrar también a aquellos fabricantes que no tienen productos asociados.
SELECT *
FROM fabricante AS f
LEFT JOIN producto AS p ON p.codigo_fabricante = f.codigo;


#35 Devuelve un listado en el que sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT *
FROM fabricante AS f
LEFT JOIN producto AS p ON p.codigo_fabricante = f.codigo
WHERE p.codigo_fabricante IS NULL;

#36 Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT *
FROM producto
WHERE codigo_fabricante 
IN(
SELECT codigo 
FROM fabricante 
WHERE nombre='Lenovo');

#37 Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin usar INNER JOIN).
SELECT *
FROM producto
WHERE precio =
 ( SELECT MAX(precio) 
FROM producto
WHERE codigo 
IN (SELECT codigo 
FROM fabricante 
WHERE nombre='Lenovo')
);

#38 Lista el nombre del producto más caro del fabricante Lenovo.
SELECT p.nombre,p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Lenovo'
ORDER BY p.precio DESC
LIMIT 1;

#39 Lista el nombre del producto más barato del fabricante Hewlett-Packard.
SELECT p.nombre,p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Hewlett-Packard'
ORDER BY p.precio ASC
LIMIT 1;

#40 Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.
SELECT nombre,precio
FROM producto 
WHERE precio >=(SELECT  MAX(p.precio) FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo');

#41 Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT *,f.nombre AS fabricante_nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus' AND precio >(SELECT  AVG(p1.precio) FROM producto p1 JOIN fabricante f1 ON p1.codigo_fabricante = f1.codigo WHERE f1.nombre = 'Asus');
