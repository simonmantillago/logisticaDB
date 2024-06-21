# Base de datos Logistica



![img](https://cdn.discordapp.com/attachments/1204750536960638976/1253404655166160946/image.png?ex=6676644c&is=667512cc&hm=87f585de9078c01e5f67c6b3f41a1ebf7e7158b11ce4fd5c7938ec7e8f105254&=)

## Casos de Uso



1. Caso de Uso 1: Registrar un Nuevo País

   ```sql
   INSERT INTO paises (nombre) VALUES ('Colombia');
   ```

   

2. Caso de Uso 2: Registrar una Nueva Ciudad

   ```sql
   INSERT INTO ciudades (nombre, pais_id) VALUES ('Bucaramanaga', 6);
   ```

   

3. Caso de Uso 3: Registrar una Nueva Sucursal

   ```sql
   INSERT INTO sucursales (nombre, direccion, ciudad_id) VALUES ('Sucursal Bucaramnaga', 'Cra 27 #15-42', 6);
   ```

   

4. Caso de Uso 4: Registrar un Nuevo Cliente

   ```sql
   INSERT INTO clientes (nombre, email, direccion) VALUES ('Simon Mantilla', 'SimonDios@gmail.com', 'Calle 197 #15-425, Bucaramanga');
   ```

   

5. Caso de Uso 5: Registrar un Nuevo Teléfono para un Cliente

   ```sql
   INSERT INTO telefonos_clientes (numero, cliente_id) VALUES ('3186871200', 6);    
   ```

   

6. Caso de Uso 6: Registrar un Nuevo Paquete

   ```sql
   INSERT INTO paquetes (numero_seguimiento, peso, dimensiones, contenido, valor_declarado, tipo_servicio_id, estado_id) 
   VALUES ('CHL202306210001', 2.5, '30x30x30 cm', 'Ropa', 50.00, 1, 1); 
   ```

   

7. Caso de Uso 7: Registrar un Nuevo Envío

   ```sql
   INSERT INTO envios (cliente_id, paquete_id, fecha_envio, destino, ruta_id, sucursal_id)
   VALUES (3, 4, '2023-06-21 10:00:00', 'Calle Destino 456, Santiago', 1, 1);
   ```

   

8. Caso de Uso 8: Registrar un Nuevo Vehículo

   ```sql
   INSERT INTO vehiculos (placa, marca_id, modelo_id, capacidad_carga, sucursal_id) 
   VALUES ('ABC1234', 1, 1, 1500.0, 1);
   
   ```

   

9. Caso de Uso 9: Registrar un Nuevo Conductor

   ```sql
   INSERT INTO conductores (nombre) VALUES ('Carlos López');
   ```

   

10. Caso de Uso 10: Registrar un Nuevo Teléfono para un Conductor

   ```sql
   INSERT INTO telefonos_conductores (numero, conductor_id) VALUES ('5559876543', 6);
   ```




11. Caso de Uso 11: Asignar un Conductor a una Ruta y un Vehículo

    ```sql
    INSERT INTO conductores_rutas (conductor_id, ruta_id, vehiculo_id, sucursal_id) 
    VALUES (2, 1, 1, 1);
    ```

    

12. Caso de Uso 12: Registrar un Nuevo Auxiliar

    ```sql
    INSERT INTO auxiliares (nombre, telefono) VALUES ('Lucía Martínez', '5557654321');
    ```



13. Caso de Uso 13: Asignar un Auxiliar a una Ruta

    ```sql
    INSERT INTO ruta_auxiliares (ruta_id, auxiliar_id) VALUES (1, 2);
    ```



14. Caso de Uso 14: Registrar un Evento de Seguimiento para un Paquete

    ```sql
    INSERT INTO seguimiento (paquete_id, ubicacion, fecha_hora, estado_id) 
    VALUES (4, 'Sucursal Santiago', '2023-06-21 12:00:00', 2);
    ```



15. Caso de Uso 15: Generar un Reporte de Envíos por Cliente

    ```sql
    SELECT envio_id, cliente_id, paquete_id, fecha_envio, destino, ruta_id, sucursal_id 
    FROM envios WHERE cliente_id = 3;
    
    +----------+------------+------------+---------------------+-----------------------------+---------+-------------+
    | envio_id | cliente_id | paquete_id | fecha_envio         | destino                     | ruta_id | sucursal_id |
    +----------+------------+------------+---------------------+-----------------------------+---------+-------------+
    |        3 |          3 |          3 | 2023-06-03 12:00:00 | Calle Segunda 456           |       3 |           3 |
    |        6 |          3 |          4 | 2023-06-21 10:00:00 | Calle Destino 456, Santiago |       1 |           1 |
    +----------+------------+------------+---------------------+-----------------------------+---------+-------------+
    ```



16. Caso de Uso 16: Actualizar el Estado de un Paquete

    ```sql
    UPDATE paquetes 
    SET estado_id = 3 
    WHERE paquete_id = 4;
    ```



17. Caso de Uso 17: Rastrear la Ubicación Actual de un Paquete

    ```sql
    SELECT paquete_id, ubicacion 
    FROM seguimiento 
    WHERE paquete_id = 4 
    ORDER BY fecha_hora DESC
    
    +-------------------+
    | ubicacion         |
    +-------------------+
    | Sucursal Santiago |
    | En tránsito       |
    +-------------------+
    ```



## Casos de Uso Multitabla

1. Caso de Uso 1: Obtener Información Completa de Envíos

```sql
SELECT 
    e.envio_id,
    e.cliente_id,
    e.destino,
    c.nombre AS cliente_nombre,
    c.email AS cliente_email,
    c.direccion AS cliente_direccion,
    p.numero_seguimiento,
    p.peso,
    p.dimensiones,
    p.contenido,
    p.valor_declarado,
    ts.tipo AS tipo_servicio,
    r.descripcion AS ruta,
    cd.nombre AS conductor_nombre,
    v.placa AS vehiculo_placa,
    ma.nombre AS marca_vehiculo,
    mo.descripcion AS modelo_vehiculo
FROM 
    envios e 
JOIN 
    clientes c ON e.cliente_id = c.cliente_id
JOIN 
    paquetes p ON e.paquete_id = p.paquete_id
JOIN 
    tipos_servicios ts ON p.tipo_servicio_id = ts.tipo_servicio_id
JOIN 
    rutas r ON e.ruta_id = r.ruta_id
JOIN 
    sucursales sc ON e.sucursal_id = sc.sucursal_id
JOIN 
    conductores_rutas cr ON e.ruta_id = cr.ruta_id
JOIN 
    conductores cd ON cr.conductor_id = cd.conductor_id
JOIN 
    vehiculos v ON cr.vehiculo_id = v.vehiculo_id
JOIN 
    marcas ma ON v.marca_id = ma.marca_id
JOIN 
    modelos mo ON v.modelo_id = mo.modelo_id;

+----------+------------+-----------------------------+-----------------+-----------------------------+--------------------------+--------------------+------+-------------+-------------+-----------------+---------------+-------------+------------------+----------------+----------------+-----------------+
| envio_id | cliente_id | destino                     | cliente_nombre  | cliente_email               | cliente_direccion        | numero_seguimiento | peso | dimensiones | contenido   | valor_declarado | tipo_servicio | ruta        | conductor_nombre | vehiculo_placa | marca_vehiculo | modelo_vehiculo |
+----------+------------+-----------------------------+-----------------+-----------------------------+--------------------------+--------------------+------+-------------+-------------+-----------------+---------------+-------------+------------------+----------------+----------------+-----------------+
|        1 |          1 | Calle Falsa 123             | Juan Pérez      | juan.perez@example.com      | Calle Falsa 123          | MX123456789        | 2.50 | 30x30x30    | Libros      |          500.00 | Express       | Ruta Centro | Pedro Sánchez    | ABC123         | Toyota         | Corolla         |
|        6 |          3 | Calle Destino 456, Santiago | Carlos García   | carlos.garcia@example.com   | Calle Segunda 456        | BR678901234        | 0.50 | 10x10x10    | Juguetes    |           50.00 | Internacional | Ruta Centro | Pedro Sánchez    | ABC123         | Toyota         | Corolla         |
|        1 |          1 | Calle Falsa 123             | Juan Pérez      | juan.perez@example.com      | Calle Falsa 123          | MX123456789        | 2.50 | 30x30x30    | Libros      |          500.00 | Express       | Ruta Centro | José Martínez    | ABC123         | Toyota         | Corolla         |
|        6 |          3 | Calle Destino 456, Santiago | Carlos García   | carlos.garcia@example.com   | Calle Segunda 456        | BR678901234        | 0.50 | 10x10x10    | Juguetes    |           50.00 | Internacional | Ruta Centro | José Martínez    | ABC123         | Toyota         | Corolla         |
|        2 |          2 | Avenida Siempre Viva 742    | Ana López       | ana.lopez@example.com       | Avenida Siempre Viva 742 | US987654321        | 1.20 | 20x20x20    | Ropa        |          150.00 | Estándar      | Ruta Norte  | José Martínez    | DEF456         | Ford           | Focus           |
|        3 |          3 | Calle Segunda 456           | Carlos García   | carlos.garcia@example.com   | Calle Segunda 456        | CA567890123        | 3.00 | 40x40x40    | Electrónica |         1000.00 | Económico     | Ruta Sur    | Miguel Ángel     | GHI789         | Chevrolet      | Cruze           |
|        4 |          4 | Calle Tercera 789           | María Rodríguez | maria.rodriguez@example.com | Calle Tercera 789        | BR678901234        | 0.50 | 10x10x10    | Juguetes    |           50.00 | Internacional | Ruta Este   | Roberto González | JKL012         | Honda          | Civic           |
|        5 |          5 | Avenida Cuarta 101          | Luis Fernández  | luis.fernandez@example.com  | Avenida Cuarta 101       | AR789012345        | 4.50 | 50x50x50    | Muebles     |         2000.00 | Prioritario   | Ruta Oeste  | Andrés Herrera   | MNO345         | Nissan         | Sentra          |
+----------+------------+-----------------------------+-----------------+-----------------------------+--------------------------+--------------------+------+-------------+-------------+-----------------+---------------+-------------+------------------+----------------+----------------+-----------------+
```

​	

2. Caso de Uso 2: Obtener Historial de Envíos de un Cliente

```sql
SELECT 
    e.envio_id,
    e.cliente_id,
    e.destino,
    e.paquete_id,
    p.numero_seguimiento,
    s.fecha_hora,
    s.ubicacion,
    s.estado_id
FROM 
    envios e
JOIN 
    paquetes p ON e.paquete_id = p.paquete_id
JOIN 
    seguimiento s ON p.paquete_id = s.paquete_id
WHERE 
    e.cliente_id = 3
ORDER BY 
    s.fecha_hora DESC; -------------------- revisar estaoooooasdaldandoafenf

+----------+------------+-----------------------------+------------+--------------------+---------------------+------------------------+-----------+
| envio_id | cliente_id | destino                     | paquete_id | numero_seguimiento | fecha_hora          | ubicacion              | estado_id |
+----------+------------+-----------------------------+------------+--------------------+---------------------+------------------------+-----------+
|        6 |          3 | Calle Destino 456, Santiago |          4 | BR678901234        | 2023-06-21 12:00:00 | Sucursal Santiago      |         2 |
|        3 |          3 | Calle Segunda 456           |          3 | CA567890123        | 2023-06-03 17:00:00 | Centro de distribución |         3 |
+----------+------------+-----------------------------+------------+--------------------+---------------------+------------------------+-----------+
```



3. Caso de Uso 3: Listar Conductores y sus Rutas Asignadas

```sql
SELECT d.nombre AS conductor_nombre, r.descripcion AS ruta_descripcion, v.placa AS vehiculo_placa, s.nombre AS sucursal_nombre 
FROM conductores_rutas cr
JOIN conductores d ON cr.conductor_id = d.conductor_id
JOIN rutas r ON cr.ruta_id = r.ruta_id
JOIN vehiculos v ON cr.vehiculo_id = v.vehiculo_id
JOIN sucursales s ON cr.sucursal_id = s.sucursal_id;

+------------------+------------------+----------------+-----------------+
| conductor_nombre | ruta_descripcion | vehiculo_placa | sucursal_nombre |
+------------------+------------------+----------------+-----------------+
| Pedro Sánchez    | Ruta Centro      | ABC123         | Sucursal Centro |
| José Martínez    | Ruta Centro      | ABC123         | Sucursal Centro |
| José Martínez    | Ruta Norte       | DEF456         | Sucursal Norte  |
| Miguel Ángel     | Ruta Sur         | GHI789         | Sucursal Sur    |
| Roberto González | Ruta Este        | JKL012         | Sucursal Este   |
| Andrés Herrera   | Ruta Oeste       | MNO345         | Sucursal Oeste  |
+------------------+------------------+----------------+-----------------+
```



4. Caso de Uso 4: Obtener Detalles de Rutas y Auxiliares Asignados

```sql
SELECT r.descripcion AS ruta_descripcion, a.nombre AS auxiliar_nombre 
FROM ruta_auxiliares ra
JOIN rutas r ON ra.ruta_id = r.ruta_id
JOIN auxiliares a ON ra.auxiliar_id = a.auxiliar_id;

+------------------+-----------------+
| ruta_descripcion | auxiliar_nombre |
+------------------+-----------------+
| Ruta Centro      | Laura Díaz      |
| Ruta Centro      | Raúl Méndez     |
| Ruta Norte       | Raúl Méndez     |
| Ruta Sur         | Patricia Torres |
| Ruta Este        | Daniela Ortiz   |
| Ruta Oeste       | Francisco Ríos  |
+------------------+-----------------+
```



5. Caso de Uso 5: Generar Reporte de Paquetes por Sucursal y Estado

```sql
SELECT s.nombre AS sucursal_nombre, e.tipo AS estado_tipo
FROM paquetes p
JOIN estados e ON p.estado_id = e.estado_id
JOIN envios en ON p.paquete_id = en.paquete_id
JOIN sucursales s ON en.sucursal_id = s.sucursal_id
ORDER BY s.nombre, e.tipo;
    
+-----------------+----------------+
| sucursal_nombre | estado_tipo    |
+-----------------+----------------+
| Sucursal Centro | En aduana      |
| Sucursal Centro | En preparación |
| Sucursal Este   | En aduana      |
| Sucursal Norte  | En tránsito    |
| Sucursal Oeste  | Devuelto       |
| Sucursal Sur    | En aduana      |
+-----------------+----------------+

```



6. Caso de Uso 6: Obtener Información Completa de un Paquete y su Historial de Seguimiento

```sql
SELECT 
    p.paquete_id,
    p.numero_seguimiento,
    p.peso,
    p.dimensiones,
    p.contenido,
    p.valor_declarado,
    s.fecha_hora,
    s.ubicacion,
    s.estado_id,
    ts.tipo AS tipo_de_envio
FROM 
    paquetes p
JOIN 
    seguimiento s ON p.paquete_id = s.paquete_id
JOIN 
    tipos_servicios ts ON p.tipo_servicio_id = ts.tipo_servicio_id
WHERE 
    p.paquete_id = 4
ORDER BY 
    s.fecha_hora DESC;
+------------+--------------------+------+-------------+-----------+-----------------+---------------------+-------------------+-----------+---------------+
| paquete_id | numero_seguimiento | peso | dimensiones | contenido | valor_declarado | fecha_hora          | ubicacion         | estado_id | tipo_de_envio |
+------------+--------------------+------+-------------+-----------+-----------------+---------------------+-------------------+-----------+---------------+
|          4 | BR678901234        | 0.50 | 10x10x10    | Juguetes  |           50.00 | 2023-06-21 12:00:00 | Sucursal Santiago |         2 | Internacional |
+------------+--------------------+------+-------------+-----------+-----------------+---------------------+-------------------+-----------+---------------+

```



## Casos de Uso Between, In y Not In



1. Caso de Uso 1: Obtener Paquetes Enviados Dentro de un Rango de Fecha

```sql
SELECT * 
FROM envios 
WHERE fecha_envio BETWEEN '2023-06-01' AND '2023-06-21';

+----------+------------+------------+---------------------+--------------------------+---------+-------------+
| envio_id | cliente_id | paquete_id | fecha_envio         | destino                  | ruta_id | sucursal_id |
+----------+------------+------------+---------------------+--------------------------+---------+-------------+
|        1 |          1 |          1 | 2023-06-01 10:00:00 | Calle Falsa 123          |       1 |           1 |
|        2 |          2 |          2 | 2023-06-02 11:00:00 | Avenida Siempre Viva 742 |       2 |           2 |
|        3 |          3 |          3 | 2023-06-03 12:00:00 | Calle Segunda 456        |       3 |           3 |
|        4 |          4 |          4 | 2023-06-04 13:00:00 | Calle Tercera 789        |       4 |           4 |
|        5 |          5 |          5 | 2023-06-05 14:00:00 | Avenida Cuarta 101       |       5 |           5 |
+----------+------------+------------+---------------------+--------------------------+---------+-------------+
```



2. Caso de Uso 2: Obtener Paquetes con Ciertos Estados

```sql
SELECT paquete_id, numero_seguimiento, peso,dimensiones, contenido, valor_declarado, tipo_servicio_id,estado_id
FROM paquetes 
WHERE estado_id IN (1, 2);

+------------+--------------------+------+-------------+-----------+-----------------+------------------+-----------+
| paquete_id | numero_seguimiento | peso | dimensiones | contenido | valor_declarado | tipo_servicio_id | estado_id |
+------------+--------------------+------+-------------+-----------+-----------------+------------------+-----------+
|          1 | MX123456789        | 2.50 | 30x30x30    | Libros    |          500.00 |                1 |         1 |
|          6 | CHL202306210001    | 2.50 | 30x30x30 cm | Ropa      |           50.00 |                1 |         1 |
|          2 | US987654321        | 1.20 | 20x20x20    | Ropa      |          150.00 |                2 |         2 |
+------------+--------------------+------+-------------+-----------+-----------------+------------------+-----------+
```



3. Caso de Uso 3: Obtener Paquetes Excluyendo Ciertos Estados

```sql
SELECT 
    paquete_id,
    numero_seguimiento,
    peso,
    dimensiones,
    contenido,
    valor_declarado,
    tipo_servicio,
    fecha_creacion,
    estado_id
FROM 
    paquetes 
WHERE 
    estado_id NOT IN (1, 3);
    
+------------+--------------------+------+-------------+-----------+-----------------+------------------+-----------+
| paquete_id | numero_seguimiento | peso | dimensiones | contenido | valor_declarado | tipo_servicio_id | estado_id |
+------------+--------------------+------+-------------+-----------+-----------------+------------------+-----------+
|          2 | US987654321        | 1.20 | 20x20x20    | Ropa      |          150.00 |                2 |         2 |
|          5 | AR789012345        | 4.50 | 50x50x50    | Muebles   |         2000.00 |                5 |         5 |
+------------+--------------------+------+-------------+-----------+-----------------+------------------+-----------+    
```



4. Caso de Uso 4: Obtener Clientes con Envíos Realizados Dentro de un Rango de Fechas

```sql
SELECT DISTINCT
    c.cliente_id,
    c.nombre,
    c.email,
    c.direccion,
    e.fecha_envio
FROM 
    clientes c
JOIN 
    envios e ON c.cliente_id = e.cliente_id
WHERE 
    e.fecha_envio BETWEEN '2023-06-01' AND '2023-06-21';

+------------+-----------------+-----------------------------+--------------------------+---------------------+
| cliente_id | nombre          | email                       | direccion                | fecha_envio         |
+------------+-----------------+-----------------------------+--------------------------+---------------------+
|          1 | Juan Pérez      | juan.perez@example.com      | Calle Falsa 123          | 2023-06-01 10:00:00 |
|          2 | Ana López       | ana.lopez@example.com       | Avenida Siempre Viva 742 | 2023-06-02 11:00:00 |
|          3 | Carlos García   | carlos.garcia@example.com   | Calle Segunda 456        | 2023-06-03 12:00:00 |
|          4 | María Rodríguez | maria.rodriguez@example.com | Calle Tercera 789        | 2023-06-04 13:00:00 |
|          5 | Luis Fernández  | luis.fernandez@example.com  | Avenida Cuarta 101       | 2023-06-05 14:00:00 |
+------------+-----------------+-----------------------------+--------------------------+---------------------+
```



5. Caso de Uso 5: Obtener Conductores Disponibles que No Están Asignados a Ciertas Rutas

```sql
SELECT 
    c.conductor_id,
    c.nombre
FROM 
    conductores c
WHERE 
    c.conductor_id NOT IN (
        SELECT 
            cr.conductor_id 
        FROM 
            conductores_rutas cr 
        WHERE 
            cr.ruta_id IN (1, 2)
    );
    
+--------------+------------------+
| conductor_id | nombre           |
+--------------+------------------+
|            3 | Miguel Ángel     |
|            4 | Roberto González |
|            5 | Andrés Herrera   |
|            6 | Carlos López     |
+--------------+------------------+
```



6. Caso de Uso 6: Obtener Información de Paquetes con Valor Declarado Dentro de un Rango Específico

```sql
SELECT 
    paquete_id,
    numero_seguimiento,
    peso,
    dimensiones,
    contenido,
    valor_declarado,
    tipo_servicio_id,
    estado_id
FROM 
    paquetes 
WHERE 
    valor_declarado BETWEEN 50 AND 100;
    
+------------+--------------------+------+-------------+-----------+-----------------+------------------+-----------+
| paquete_id | numero_seguimiento | peso | dimensiones | contenido | valor_declarado | tipo_servicio_id | estado_id |
+------------+--------------------+------+-------------+-----------+-----------------+------------------+-----------+
|          4 | BR678901234        | 0.50 | 10x10x10    | Juguetes  |           50.00 |                4 |         3 |
|          6 | CHL202306210001    | 2.50 | 30x30x30 cm | Ropa      |           50.00 |                1 |         1 |
+------------+--------------------+------+-------------+-----------+-----------------+------------------+-----------+
```



7. Caso de Uso 7: Obtener Rutas que Involucran Ciertas Ciudades

```sql
SELECT 
    r.ruta_id,
    r.descripcion,
    r.sucursal_id,
    s.nombre AS sucursal_nombre,
    s.direccion AS sucursal_direccion,
    c.nombre AS ciudad_nombre,
    c.pais_id
FROM rutas r
JOIN sucursales s ON r.sucursal_id = s.sucursal_id
JOIN ciudades c ON s.ciudad_id = c.ciudad_id
WHERE c.ciudad_id IN (3, 4, 5) 
;

+---------+-------------+-------------+-----------------+-----------------------+----------------+---------+
| ruta_id | descripcion | sucursal_id | sucursal_nombre | sucursal_direccion    | ciudad_nombre  | pais_id |
+---------+-------------+-------------+-----------------+-----------------------+----------------+---------+
|       3 | Ruta Sur    |           3 | Sucursal Sur    | Boulevard Tercero 789 | Toronto        |       3 |
|       4 | Ruta Este   |           4 | Sucursal Este   | Calle Cuarta 101      | Río de Janeiro |       4 |
|       5 | Ruta Oeste  |           5 | Sucursal Oeste  | Avenida Quinta 202    | Buenos Aires   |       5 |
+---------+-------------+-------------+-----------------+-----------------------+----------------+---------+
```



8. Caso de Uso 8: Obtener Vehículos que No Están Asignados a Ciertas Ruta

```sql
SELECT 
    vehiculo_id,
    placa,
    marca_id,
    modelo_id,
    capacidad_carga,
    sucursal_id
FROM vehiculos
WHERE vehiculo_id NOT IN (
    SELECT vehiculo_id
    FROM conductores_rutas
    WHERE ruta_id IN (1, 2, 3)
);

+-------------+---------+----------+-----------+-----------------+-------------+
| vehiculo_id | placa   | marca_id | modelo_id | capacidad_carga | sucursal_id |
+-------------+---------+----------+-----------+-----------------+-------------+
|           4 | JKL012  |        4 |         4 |         1100.00 |           4 |
|           5 | MNO345  |        5 |         5 |         1300.00 |           5 |
|           6 | ABC1234 |        1 |         1 |         1500.00 |           1 |
+-------------+---------+----------+-----------+-----------------+-------------+
```

Caso de Uso 9: Obtener Clientes con Teléfonos Registrados

```sql
SELECT 
    c.cliente_id,
    c.nombre,
    c.email,
    c.direccion,
    tc.telefono_id,
    tc.numero AS telefono
FROM clientes c
JOIN telefonos_clientes tc ON c.cliente_id = tc.cliente_id;

+------------+-----------------+-----------------------------+--------------------------------+-------------+------------+
| cliente_id | nombre          | email                       | direccion                      | telefono_id | telefono   |
+------------+-----------------+-----------------------------+--------------------------------+-------------+------------+
|          1 | Juan Pérez      | juan.perez@example.com      | Calle Falsa 123                |           1 | 5551234567 |
|          2 | Ana López       | ana.lopez@example.com       | Avenida Siempre Viva 742       |           2 | 5557654321 |
|          3 | Carlos García   | carlos.garcia@example.com   | Calle Segunda 456              |           3 | 5558765432 |
|          4 | María Rodríguez | maria.rodriguez@example.com | Calle Tercera 789              |           4 | 5552345678 |
|          5 | Luis Fernández  | luis.fernandez@example.com  | Avenida Cuarta 101             |           5 | 5553456789 |
|          6 | Simon Mantilla  | SimonDios@gmail.com         | Calle 197 #15-425, Bucaramanga |           6 | 3186871200 |
+------------+-----------------+-----------------------------+--------------------------------+-------------+------------+
```



Caso de Uso 10: Obtener Información de Vehículos con Capacidad de Carga en un Rango Específico

```sql
SELECT 
    vehiculo_id,
    placa,
    marca_id,
    modelo_id,
    capacidad_carga,
    sucursal_id
FROM vehiculos
WHERE capacidad_carga BETWEEN 1000 AND 1200;

+-------------+--------+----------+-----------+-----------------+-------------+
| vehiculo_id | placa  | marca_id | modelo_id | capacidad_carga | sucursal_id |
+-------------+--------+----------+-----------+-----------------+-------------+
|           1 | ABC123 |        1 |         1 |         1000.50 |           1 |
|           3 | GHI789 |        3 |         3 |         1200.00 |           3 |
|           4 | JKL012 |        4 |         4 |         1100.00 |           4 |
+-------------+--------+----------+-----------+-----------------+-------------+
```

