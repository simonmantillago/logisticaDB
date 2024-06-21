INSERT INTO paises (nombre) VALUES 
('México'),
('Estados Unidos'),
('Canadá'),
('Brasil'),
('Argentina');

INSERT INTO clientes (nombre, email, direccion) VALUES 
('Juan Pérez', 'juan.perez@example.com', 'Calle Falsa 123'),
('Ana López', 'ana.lopez@example.com', 'Avenida Siempre Viva 742'),
('Carlos García', 'carlos.garcia@example.com', 'Calle Segunda 456'),
('María Rodríguez', 'maria.rodriguez@example.com', 'Calle Tercera 789'),
('Luis Fernández', 'luis.fernandez@example.com', 'Avenida Cuarta 101');

INSERT INTO tipos_servicios (tipo) VALUES 
('Express'),
('Estándar'),
('Económico'),
('Internacional'),
('Prioritario');

INSERT INTO estados (tipo) VALUES 
('En preparación'),
('En tránsito'),
('En aduana'),
('Entregado'),
('Devuelto');

INSERT INTO marcas (nombre) VALUES 
('Toyota'),
('Ford'),
('Chevrolet'),
('Honda'),
('Nissan');

INSERT INTO modelos (descripcion) VALUES 
('Corolla'),
('Focus'),
('Cruze'),
('Civic'),
('Sentra');

INSERT INTO paquetes (numero_seguimiento, peso, dimensiones, contenido, valor_declarado, tipo_servicio_id, estado_id) VALUES 
('MX123456789', 2.5, '30x30x30', 'Libros', 500.00, 1, 1),
('US987654321', 1.2, '20x20x20', 'Ropa', 150.00, 2, 2),
('CA567890123', 3.0, '40x40x40', 'Electrónica', 1000.00, 3, 3),
('BR678901234', 0.5, '10x10x10', 'Juguetes', 50.00, 4, 4),
('AR789012345', 4.5, '50x50x50', 'Muebles', 2000.00, 5, 5);

INSERT INTO conductores (nombre) VALUES 
('Pedro Sánchez'),
('José Martínez'),
('Miguel Ángel'),
('Roberto González'),
('Andrés Herrera');

INSERT INTO auxiliares (nombre, telefono) VALUES 
('Laura Díaz', '5554567891'),
('Raúl Méndez', '5557894561'),
('Patricia Torres', '5551236547'),
('Daniela Ortiz', '5559873214'),
('Francisco Ríos', '5556541238');

INSERT INTO ciudades (nombre, pais_id) VALUES 
('Ciudad de México', 1),
('Los Ángeles', 2),
('Toronto', 3),
('Río de Janeiro', 4),
('Buenos Aires', 5);

INSERT INTO telefonos_clientes (numero, cliente_id) VALUES 
('5551234567', 1),
('5557654321', 2),
('5558765432', 3),
('5552345678', 4),
('5553456789', 5);

INSERT INTO telefonos_conductores (numero, conductor_id) VALUES 
('5551239876', 1),
('5559871234', 2),
('5554567890', 3),
('5557891234', 4),
('5553214567', 5);

INSERT INTO sucursales (nombre, direccion, ciudad_id) VALUES 
('Sucursal Centro', 'Calle Principal 123', 1),
('Sucursal Norte', 'Avenida Secundaria 456', 2),
('Sucursal Sur', 'Boulevard Tercero 789', 3),
('Sucursal Este', 'Calle Cuarta 101', 4),
('Sucursal Oeste', 'Avenida Quinta 202', 5);

INSERT INTO seguimiento (paquete_id, ubicacion, fecha_hora, estado_id) VALUES 
(1, 'Centro de distribución', '2023-06-01 15:00:00', 1),
(2, 'En tránsito', '2023-06-02 16:00:00', 2),
(3, 'Centro de distribución', '2023-06-03 17:00:00', 3),
(4, 'En tránsito', '2023-06-04 18:00:00', 4),
(5, 'Entregado', '2023-06-05 19:00:00', 5);

INSERT INTO vehiculos (placa, marca_id, modelo_id, capacidad_carga, sucursal_id) VALUES 
('ABC123', 1, 1, 1000.5, 1),
('DEF456', 2, 2, 1500.0, 2),
('GHI789', 3, 3, 1200.0, 3),
('JKL012', 4, 4, 1100.0, 4),
('MNO345', 5, 5, 1300.0, 5);

INSERT INTO rutas (descripcion, sucursal_id) VALUES 
('Ruta Centro', 1),
('Ruta Norte', 2),
('Ruta Sur', 3),
('Ruta Este', 4),
('Ruta Oeste', 5);

INSERT INTO envios (cliente_id, paquete_id, fecha_envio, destino, ruta_id, sucursal_id) VALUES 
(1, 1, '2023-06-01 10:00:00', 'Calle Falsa 123', 1, 1),
(2, 2, '2023-06-02 11:00:00', 'Avenida Siempre Viva 742', 2, 2),
(3, 3, '2023-06-03 12:00:00', 'Calle Segunda 456', 3, 3),
(4, 4, '2023-06-04 13:00:00', 'Calle Tercera 789', 4, 4),
(5, 5, '2023-06-05 14:00:00', 'Avenida Cuarta 101', 5, 5);

INSERT INTO conductores_rutas (conductor_id, ruta_id, vehiculo_id, sucursal_id) VALUES 
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3),
(4, 4, 4, 4),
(5, 5, 5, 5);

INSERT INTO ruta_auxiliares (ruta_id, auxiliar_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
