DROP DATABASE IF EXISTS ventas;

CREATE DATABASE ventas CHARACTER SET utf8mb4;

USE ventas;

CREATE TABLE cliente (

id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

nombre VARCHAR(100) NOT NULL,

apellido1 VARCHAR(100) NOT NULL,

apellido2 VARCHAR(100),

ciudad VARCHAR(100),

categoría INT UNSIGNED

);

CREATE TABLE comercial (

id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

nombre VARCHAR(100) NOT NULL,

apellido1 VARCHAR(100) NOT NULL,

apellido2 VARCHAR(100),

comisión FLOAT

);

CREATE TABLE pedido (

id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

total DOUBLE NOT NULL,



fecha DATE,

id_cliente INT UNSIGNED NOT NULL,

id_comercial INT UNSIGNED NOT NULL,

FOREIGN KEY (id_cliente) REFERENCES cliente(id),

FOREIGN KEY (id_comercial) REFERENCES comercial(id)

);

INSERT INTO cliente VALUES(1, 'Aarón', 'Rivero', 'Gómez', 'Almería', 100);

INSERT INTO cliente VALUES(2, 'Adela', 'Salas', 'Díaz', 'Granada', 200);

INSERT INTO cliente VALUES(3, 'Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL);

INSERT INTO cliente VALUES(4, 'Adrián', 'Suárez', NULL, 'Jaén', 300);

INSERT INTO cliente VALUES(5, 'Marcos', 'Loyola', 'Méndez', 'Almería', 200);

INSERT INTO cliente VALUES(6, 'María', 'Santana', 'Moreno', 'Cádiz', 100);

INSERT INTO cliente VALUES(7, 'Pilar', 'Ruiz', NULL, 'Sevilla', 300);

INSERT INTO cliente VALUES(8, 'Pepe', 'Ruiz', 'Santana', 'Huelva', 200);

INSERT INTO cliente VALUES(9, 'Guillermo', 'López', 'Gómez', 'Granada', 225);

INSERT INTO cliente VALUES(10, 'Daniel', 'Santana', 'Loyola', 'Sevilla', 125);

INSERT INTO comercial VALUES(1, 'Daniel', 'Sáez', 'Vega', 0.15);

INSERT INTO comercial VALUES(2, 'Juan', 'Gómez', 'López', 0.13);

INSERT INTO comercial VALUES(3, 'Diego','Flores', 'Salas', 0.11);

INSERT INTO comercial VALUES(4, 'Marta','Herrera', 'Gil', 0.14);

INSERT INTO comercial VALUES(5, 'Antonio','Carretero', 'Ortega', 0.12);

INSERT INTO comercial VALUES(6, 'Manuel','Domínguez', 'Hernández', 0.13);

INSERT INTO comercial VALUES(7, 'Antonio','Vega', 'Hernández', 0.11);

INSERT INTO comercial VALUES(8, 'Alfredo','Ruiz', 'Flores', 0.05);

INSERT INTO pedido VALUES(1, 150.5, '2017-10-05', 5, 2);

INSERT INTO pedido VALUES(2, 270.65, '2016-09-10', 1, 5);

INSERT INTO pedido VALUES(3, 65.26, '2017-10-05', 2, 1);

INSERT INTO pedido VALUES(4, 110.5, '2016-08-17', 8, 3);

INSERT INTO pedido VALUES(5, 948.5, '2017-09-10', 5, 2);

INSERT INTO pedido VALUES(6, 2400.6, '2016-07-27', 7, 1);

INSERT INTO pedido VALUES(7, 5760, '2015-09-10', 2, 1);

INSERT INTO pedido VALUES(8, 1983.43, '2017-10-10', 4, 6);

INSERT INTO pedido VALUES(9, 2480.4, '2016-10-10', 8, 3);

INSERT INTO pedido VALUES(10, 250.45, '2015-06-27', 8, 2);

INSERT INTO pedido VALUES(11, 75.29, '2016-08-17', 3, 7);

INSERT INTO pedido VALUES(12, 3045.6, '2017-04-25', 2, 1);

INSERT INTO pedido VALUES(13, 545.75, '2019-01-25', 6, 1);

INSERT INTO pedido VALUES(14, 145.82, '2017-02-02', 6, 1);

INSERT INTO pedido VALUES(15, 370.85, '2019-03-11', 1, 5);

INSERT INTO pedido VALUES(16, 2389.23, '2019-03-11', 1, 5);





-- 1 

-- Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que

-- han realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben

-- eliminar los elementos repetidos.



SELECT DISTINCT c.id, c.nombre, c.apellido1, c.apellido2

FROM cliente c

JOIN pedido p ON c.id = p.id_cliente

ORDER BY c.nombre, c.apellido1, c.apellido2;









-- 2 

-- Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El

-- resultado debe mostrar todos los datos de los pedidos y del cliente. El listado debe

-- mostrar los datos de los clientes ordenados alfabéticamente.





SELECT c.*, p.*

FROM cliente c

JOIN pedido p ON c.id = p.id_cliente

ORDER BY c.nombre, c.apellido1, c.apellido2;









-- 3 



-- Devuelve un listado que muestre todos los pedidos en los que ha participado un

-- comercial. El resultado debe mostrar todos los datos de los pedidos y de los comerciales.

-- El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.







SELECT cm.*, p.*

FROM comercial cm

JOIN pedido p ON cm.id = p.id_comercial

ORDER BY cm.nombre, cm.apellido1, cm.apellido2;







-- 4

use ventas;





-- Devuelve un listado que muestre todos los clientes, con todos los pedidos que han

-- realizado y con los datos de los comerciales asociados a cada pedido.



SELECT c.*, p.*, cm.*

FROM cliente c

JOIN pedido p ON c.id = p.id_cliente

JOIN comercial cm ON p.id_comercial = cm.id;







-- 5



-- Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017,

-- cuya cantidad esté entre 300 € y 1000 €.



SELECT c.*

FROM cliente c

JOIN pedido p ON c.id = p.id_cliente

WHERE YEAR(p.fecha) = 2017 AND p.total BETWEEN 300 AND 1000;







-- 6



-- Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún

--- pedido realizado por María Santana Moreno.





SELECT DISTINCT cm.nombre, cm.apellido1, cm.apellido2

FROM comercial cm

JOIN pedido p ON cm.id = p.id_comercial

JOIN cliente c ON p.id_cliente = c.id

WHERE c.nombre = 'María' AND c.apellido1 = 'Santana' AND c.apellido2 = 'Moreno';





-- 7



-- Devuelve el nombre de todos los clientes que han realizado algún pedido con el

-- comercial Daniel Sáez Vega.



SELECT DISTINCT c.nombre

FROM cliente c

JOIN pedido p ON c.id = p.id_cliente

JOIN comercial cm ON p.id_comercial = cm.id

WHERE cm.nombre = 'Daniel' AND cm.apellido1 = 'Sáez' AND cm.apellido2 = 'Vega';







-- 8 



-- Devuelve un listado con todos los clientes junto con los datos de los pedidos que han

-- realizado. Este listado también debe incluir los clientes que no han realizado ningún

-- pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo

-- apellido y nombre de los clientes.





SELECT c.*, p.*

FROM cliente c

LEFT JOIN pedido p ON c.id = p.id_cliente

ORDER BY c.apellido1, c.apellido2, c.nombre;











-- 9





-- Devuelve un listado con todos los comerciales junto con los datos de los pedidos que

-- han realizado. Este listado también debe incluir los comerciales que no han realizado

-- ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido,

-- segundo apellido y nombre de los comerciales.



SELECT cm.*, p.*

FROM comercial cm

LEFT JOIN pedido p ON cm.id = p.id_comercial

ORDER BY cm.apellido1, cm.apellido2, cm.nombre;













-- 10.Devuelve un listado que solamente muestre los clientes que no han realizado ningún

-- pedido.







SELECT c.*

FROM cliente c

LEFT JOIN pedido p ON c.id = p.id_cliente

WHERE p.id IS NULL;









-- 11. Comerciales que no han realizado ningún pedido

SELECT cm.*

FROM comercial cm

LEFT JOIN pedido p ON cm.id = p.id_comercial

WHERE p.id IS NULL;



-- 12. Clientes y comerciales que no han realizado ningún pedido, diferenciados

SELECT 'Cliente' AS Tipo, c.nombre, c.apellido1, c.apellido2

FROM cliente c

LEFT JOIN pedido p ON c.id = p.id_cliente

WHERE p.id IS NULL

UNION

SELECT 'Comercial' AS Tipo, cm.nombre, cm.apellido1, cm.apellido2

FROM comercial cm

LEFT JOIN pedido p ON cm.id = p.id_comercial

WHERE p.id IS NULL

ORDER BY apellido1, apellido2, nombre;



-- 13. No se pueden hacer con NATURAL JOIN porque los nombres de las columnas no son únicos.



-- 14. Máximo valor de pedido por cliente y fecha

SELECT p.id_cliente, c.nombre, c.apellido1, c.apellido2, p.fecha, MAX(p.total) AS max_pedido

FROM pedido p

JOIN cliente c ON p.id_cliente = c.id

GROUP BY p.id_cliente, p.fecha;



-- 15. Igual que la anterior, pero solo si el máximo supera los 2000€

SELECT p.id_cliente, c.nombre, c.apellido1, c.apellido2, p.fecha, MAX(p.total) AS max_pedido

FROM pedido p

JOIN cliente c ON p.id_cliente = c.id

GROUP BY p.id_cliente, p.fecha

HAVING max_pedido > 2000;



-- 16. Máximo pedido realizado por cada comercial el 2016-08-17

SELECT p.id_comercial, cm.nombre, cm.apellido1, cm.apellido2, MAX(p.total) AS max_pedido

FROM pedido p

JOIN comercial cm ON p.id_comercial = cm.id

WHERE p.fecha = '2016-08-17'

GROUP BY p.id_comercial;



-- 17. Número total de pedidos por cliente, incluyendo los que no han realizado ninguno

SELECT c.id, c.nombre, c.apellido1, c.apellido2, COUNT(p.id) AS total_pedidos

FROM cliente c

LEFT JOIN pedido p ON c.id = p.id_cliente

GROUP BY c.id;



-- 18. Igual que la anterior, pero solo para pedidos en 2017

SELECT c.id, c.nombre, c.apellido1, c.apellido2, COUNT(p.id) AS total_pedidos

FROM cliente c

LEFT JOIN pedido p ON c.id = p.id_cliente AND YEAR(p.fecha) = 2017

GROUP BY c.id;



-- 19. Máximo valor de pedidos por cliente, mostrando 0 si no tienen pedidos

SELECT c.id, c.nombre, c.apellido1, IFNULL(MAX(p.total), 0) AS max_pedido

FROM cliente c

LEFT JOIN pedido p ON c.id = p.id_cliente

GROUP BY c.id;



-- 20. Pedido más caro de cada año

SELECT YEAR(p.fecha) AS año, MAX(p.total) AS max_pedido

FROM pedido p

GROUP BY YEAR(p.fecha);



-- 21. Total de pedidos por año

SELECT YEAR(p.fecha) AS año, COUNT(p.id) AS total_pedidos

FROM pedido p

GROUP BY YEAR(p.fecha);



-- 22. Cliente que realizó el pedido más caro en 2019 (sin JOIN)

SELECT * FROM cliente WHERE id = (

    SELECT id_cliente FROM pedido WHERE YEAR(fecha) = 2019 ORDER BY total DESC LIMIT 1

);



-- 23. Pedido de menor valor de Pepe Ruiz Santana

SELECT fecha, total FROM pedido WHERE id_cliente = (

    SELECT id FROM cliente WHERE nombre = 'Pepe' AND apellido1 = 'Ruiz' AND apellido2 = 'Santana'

) ORDER BY total ASC LIMIT 1;



-- 24. Clientes que hicieron pedidos en 2017 con valor mayor al promedio de 2017

SELECT c.*, p.*

FROM cliente c

JOIN pedido p ON c.id = p.id_cliente

WHERE YEAR(p.fecha) = 2017 AND p.total >= (

    SELECT AVG(total) FROM pedido WHERE YEAR(fecha) = 2017

);



-- 25. Pedido más caro sin usar MAX, ORDER BY ni LIMIT

SELECT p1.*

FROM pedido p1

WHERE NOT EXISTS (

    SELECT 1 FROM pedido p2 WHERE p2.total > p1.total

);



-- 26. Clientes sin pedidos usando ANY o ALL

SELECT c.*

FROM cliente c

WHERE c.id <> ALL (SELECT id_cliente FROM pedido);



-- 27. Comerciales sin pedidos usando ANY o ALL

SELECT cm.*

FROM comercial cm

WHERE cm.id <> ALL (SELECT id_comercial FROM pedido);



-- 28. Clientes sin pedidos usando IN o NOT IN

SELECT c.*

FROM cliente c

WHERE c.id NOT IN (SELECT id_cliente FROM pedido);



-- 29. Comerciales sin pedidos usando IN o NOT IN

SELECT cm.*

FROM comercial cm

WHERE cm.id NOT IN (SELECT id_comercial FROM pedido);



-- 30. Clientes sin pedidos usando EXISTS o NOT EXISTS

SELECT c.*

FROM cliente c

WHERE NOT EXISTS (SELECT 1 FROM pedido p WHERE p.id_cliente = c.id);



-- 31. Comerciales sin pedidos usando EXISTS o NOT EXISTS

SELECT cm.*

FROM comercial cm

WHERE NOT EXISTS (SELECT 1 FROM pedido p WHERE p.id_comercial = cm.id);

