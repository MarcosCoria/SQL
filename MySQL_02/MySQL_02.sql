/* Ejercicio_02: Usar 'tienda.sql' */
SELECT * FROM fabricante;
SELECT * FROM producto;
/* 1. Lista el nombre de todos los productos que hay en la tabla producto.
2. Lista los nombres y los precios de todos los productos de la tabla producto.
3. Lista todas las columnas de la tabla producto.
4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio. */
SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;
SELECT * FROM producto LIMIT 0;
SELECT nombre, ROUND(precio) FROM producto;
/* 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos. */

SELECT p.codigo_fabricante, p.nombre, p.codigo, f.* FROM producto p 
LEFT JOIN fabricante f ON f.codigo= p.codigo_fabricante
ORDER BY p.codigo_fabricante;

SELECT p.codigo_fabricante, p.nombre, p.codigo, f.* FROM producto p 
LEFT JOIN fabricante f ON f.codigo= p.codigo_fabricante
GROUP BY p.codigo_fabricante;

/* 7. Lista los nombres de los fabricantes ordenados de forma ascendente. */
SELECT nombre FROM fabricante ORDER BY nombre;
/* 8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente. */
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
/*9. Devuelve una lista con las 5 primeras filas de la tabla fabricante. */
SELECT * FROM fabricante LIMIT 5;
/* 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
12. Lista el nombre de los productos que tienen un precio menor o igual a $120.
13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre. */
SELECT nombre, precio FROM producto ORDER BY precio LIMIT 1;
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
SELECT * FROM producto WHERE precio<=120 ORDER BY precio DESC;
SELECT * FROM producto  WHERE precio BETWEEN 60 AND 200 ORDER BY precio DESC;
SELECT * FROM producto WHERE codigo_fabricante IN (1,3,5) ORDER BY codigo_fabricante;
SELECT * FROM producto WHERE nombre LIKE '%Portatil%';
/* Consultas Multitabla 
1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato. 
4. Devuelve una lista de todos los productos del fabricante Lenovo.
5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)*/

SELECT p.codigo, p.nombre, p.codigo_fabricante, f.nombre 
FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante= f.codigo;

SELECT f.nombre, p.nombre, p.precio
FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante= f.codigo 
ORDER BY f.nombre;

SELECT p.nombre, p.precio, f.nombre
FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante= f.codigo 
ORDER BY p.precio LIMIT 1;

SELECT p.*, f.*
FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante= f.codigo
WHERE f.nombre='Lenovo';

SELECT p.*, f.*
FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante= f.codigo
WHERE f.nombre='Crucial' AND p.precio>200;

SELECT p.*, f.*
FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante= f.codigo
WHERE f.nombre IN('Asus', 'Hewlett-Packard');

SELECT p.nombre, p.precio, f.nombre
FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante= f.codigo 
WHERE p.precio>180 ORDER BY p.precio DESC, p.nombre;

/* Consultas Multitabla 
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado. */

SELECT f.*, p.*
FROM producto p RIGHT JOIN fabricante f ON p.codigo_fabricante= f.codigo 
ORDER BY f.codigo DESC;

SELECT f.*, p.*
FROM producto p RIGHT JOIN fabricante f ON p.codigo_fabricante= f.codigo
WHERE p.precio IS NULL;

/* Subconsultas (En la cláusula WHERE)
Con operadores básicos de comparación
1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
3. Lista el nombre del producto más caro del fabricante Lenovo.
4. Lista todos los productos del fabricante Asus que tienen un precio inferior al precio medio de todos sus productos. */

SELECT f.*, p.*
FROM producto p RIGHT JOIN fabricante f ON p.codigo_fabricante= f.codigo
WHERE f.nombre='Lenovo';

SELECT f.*, p.*
FROM producto p RIGHT JOIN fabricante f ON p.codigo_fabricante= f.codigo
WHERE p.precio= 
	(SELECT MAX(p.precio) 
	FROM producto p RIGHT JOIN fabricante f ON p.codigo_fabricante= f.codigo
	WHERE f.nombre= 'Lenovo');
	
SELECT f.*, p.*
FROM producto p RIGHT JOIN fabricante f ON p.codigo_fabricante= f.codigo
WHERE f.nombre= 'Asus' AND p.precio<
	(SELECT AVG(p.precio) AS Promedio
	FROM producto p RIGHT JOIN fabricante f ON p.codigo_fabricante= f.codigo);
	
/* Subconsultas con IN y NOT IN
1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN). */

SELECT f.nombre, p.*
FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante= f.codigo
WHERE p.codigo IN (1,2,3,4,5,6,7,8,9,10,11) ORDER BY p.codigo;

SELECT f.*, p.*
FROM producto p RIGHT JOIN fabricante f ON p.codigo_fabricante= f.codigo
WHERE f.codigo NOT IN(1,2,3,4,5,6,7);

/* Subconsultas (En la cláusula HAVING)
1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo. */
SELECT COUNT(p.codigo) AS CONTADOR, f.*, p.*
FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante= f.codigo
GROUP BY f.nombre HAVING COUNT(p.codigo)=
	(SELECT COUNT(p.codigo)
	FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante= f.codigo
	WHERE f.nombre='Lenovo'); /* Lenovo tiene 2 productos en total*/