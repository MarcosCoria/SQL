/* Ejercicio_01: Usar 'nba.sql' */
SELECT * FROM jugadores;
SELECT * FROM equipos;
SELECT * FROM estadisticas;
SELECT * FROM partidos;
/* 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras, ordenados por nombre alfabéticamente. */
SELECT nombre FROM jugadores ORDER BY nombre;
SELECT nombre, peso, posicion FROM jugadores WHERE posicion='c' AND peso>200 ORDER BY nombre;
/* 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
4. Mostrar el nombre de los equipos del este (East).
5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre. */
SELECT nombre FROM equipos ORDER BY nombre;
SELECT nombre, conferencia FROM equipos WHERE conferencia= 'east';
SELECT nombre FROM equipos WHERE nombre LIKE 'c%' ORDER BY nombre;
/* 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre. */
SELECT nombre, nombre_equipo FROM jugadores ORDER BY nombre_equipo;
SELECT nombre, nombre_equipo FROM jugadores WHERE nombre_equipo= 'RAPTORS' ORDER BY nombre;
/*8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′. */
SELECT temporada, puntos_por_partido FROM estadisticas WHERE jugador= (SELECT codigo FROM jugadores WHERE nombre = 'Pau gasol');
SELECT temporada, puntos_por_partido FROM estadisticas WHERE jugador= (SELECT codigo FROM jugadores WHERE nombre = 'Pau gasol') AND temporada='04/05';
/*10. Mostrar el número de puntos de cada jugador en toda su carrera.
11. Mostrar el número de jugadores de cada equipo.
12. Mostrar el jugador que más puntos ha realizado en toda su carrera. */
SELECT j.nombre, ROUND(SUM(e.puntos_por_partido)) AS puntos FROM estadisticas e INNER JOIN jugadores j ON j.codigo = e.jugador GROUP BY j.nombre; 
SELECT nombre_equipo, COUNT(nombre_equipo) AS cant_jugadores FROM jugadores GROUP BY nombre_equipo; /* 76ers =14, bucks=14, clipper= 15, heat=16*/
SELECT j.nombre, ROUND(SUM(e.puntos_por_partido)) AS puntos FROM estadisticas e INNER JOIN jugadores j ON j.codigo = e.jugador GROUP BY j.nombre ORDER BY puntos DESC LIMIT 1; 
/*13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA. */
SELECT nombre, altura FROM jugadores WHERE altura= (SELECT MAX(altura) FROM jugadores); /* Este es el jugador más alto */
SELECT e.nombre, e.division, e.conferencia, j.nombre, j.altura
FROM equipos e INNER JOIN jugadores j ON e.nombre= j.nombre_equipo
WHERE j.altura=(SELECT MAX(altura) FROM jugadores);
/*14. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos. */
SELECT equipo_local, equipo_visitante, puntos_local, puntos_visitante FROM partidos; /* Muestra los puntos de cada equipo*/
SELECT equipo_local, equipo_visitante, ABS(puntos_local - puntos_visitante) AS diferencia FROM partidos ORDER BY diferencia DESC LIMIT 4;
/*15. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), en caso de empate sera null */
SELECT * FROM partidos;

SELECT codigo, equipo_local, equipo_visitante, puntos_local, puntos_visitante,
IF (puntos_local=puntos_visitante, 'null', IF (puntos_local> puntos_visitante, equipo_local, equipo_visitante))
AS ganador FROM partidos;

/* EXTRA:

SELECT j.nombre_equipo, ROUND(SUM(e.puntos_por_partido)) AS puntos FROM estadisticas e INNER JOIN jugadores j ON j.codigo = e.jugador GROUP BY j.nombre_equipo;
SELECT nombre, division FROM equipos WHERE division='pacific';

SELECT e.nombre, e.division, AVG(puntos_por_partido) FROM estadisticas a 
INNER JOIN jugadores j ON a.jugador = j.codigo
INNER JOIN equipos e ON e.nombre = j.nombre_equipo GROUP BY e.nombre HAVING e.division= 'pacific';

*/