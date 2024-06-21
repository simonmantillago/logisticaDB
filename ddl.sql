DROP DATABASE IF EXISTS logistica;
CREATE DATABASE logistica;

USE logistica;

CREATE TABLE paises (
    pais_id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    CONSTRAINT Pk_id_paises PRIMARY KEY (pais_id)
);

CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    email VARCHAR(100),
    direccion VARCHAR(200),
    CONSTRAINT Pk_id_clientes PRIMARY KEY (cliente_id)
);

CREATE TABLE tipos_servicios (
    tipo_servicio_id INT AUTO_INCREMENT,
    tipo VARCHAR(50),
    CONSTRAINT Pk_id_tipos_servicios PRIMARY KEY (tipo_servicio_id)
);

CREATE TABLE estados (
    estado_id INT AUTO_INCREMENT,
    tipo VARCHAR(20),
    CONSTRAINT Pk_id_estados PRIMARY KEY (estado_id)
);

CREATE TABLE marcas (
    marca_id INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    CONSTRAINT Pk_id_marcas PRIMARY KEY (marca_id)
);

CREATE TABLE modelos (
    modelo_id INT AUTO_INCREMENT,
    descripcion VARCHAR(50),
    CONSTRAINT Pk_id_modelos PRIMARY KEY (modelo_id)
);

CREATE TABLE paquetes (
    paquete_id INT AUTO_INCREMENT,
    numero_seguimiento VARCHAR(50),
    peso DECIMAL(10,2),
    dimensiones VARCHAR(50),
    contenido TEXT,
    valor_declarado DECIMAL(10,2),
    tipo_servicio_id INT,
    estado_id INT,
    CONSTRAINT Pk_id_paquetes PRIMARY KEY (paquete_id),
    CONSTRAINT Fk_id_servicios FOREIGN KEY (tipo_servicio_id) REFERENCES tipos_servicios(tipo_servicio_id),
    CONSTRAINT Fk_id_paquetes_estados FOREIGN KEY (estado_id) REFERENCES estados(estado_id)
);

CREATE TABLE conductores (
    conductor_id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    CONSTRAINT Pk_conductores PRIMARY KEY (conductor_id)
);

CREATE TABLE auxiliares (
    auxiliar_id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    CONSTRAINT Pk_auxiliares PRIMARY KEY (auxiliar_id)
);

CREATE TABLE ciudades (
    ciudad_id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    pais_id INT,
    CONSTRAINT Pk_id_ciudades PRIMARY KEY (ciudad_id),
    CONSTRAINT Fk_id_ciudades_paises FOREIGN KEY (pais_id) REFERENCES paises(pais_id)
);

CREATE TABLE telefonos_clientes (
    telefono_id INT AUTO_INCREMENT,
    numero VARCHAR(20),
    cliente_id INT,
    CONSTRAINT Pk_id_telefonos_clientes PRIMARY KEY (telefono_id),
    CONSTRAINT Fk_id_telefonos_clientes_clientes FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE telefonos_conductores (
    telefono_id INT AUTO_INCREMENT,
    numero VARCHAR(20),
    conductor_id INT,
    CONSTRAINT Pk_id_telefonos_conductores PRIMARY KEY (telefono_id),
    CONSTRAINT Fk_id_telefonos_conductores_conductores FOREIGN KEY (conductor_id) REFERENCES conductores(conductor_id)
);

CREATE TABLE sucursales (
    sucursal_id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    direccion VARCHAR(200),
    ciudad_id INT,
    CONSTRAINT Pk_id_sucursales PRIMARY KEY (sucursal_id),
    CONSTRAINT Fk_id_sucursales_ciudades FOREIGN KEY (ciudad_id) REFERENCES ciudades(ciudad_id)
);

CREATE TABLE seguimiento (
    seguimiento_id INT AUTO_INCREMENT,
    paquete_id INT,
    ubicacion VARCHAR(200),
    fecha_hora TIMESTAMP,
    estado_id INT,
    CONSTRAINT Pk_id_seguimiento PRIMARY KEY (seguimiento_id),
    CONSTRAINT Fk_id_seguimiento_paquetes FOREIGN KEY (paquete_id) REFERENCES paquetes(paquete_id),
    CONSTRAINT Fk_id_seguimiento_estado FOREIGN KEY (estado_id) REFERENCES estados(estado_id)
);

CREATE TABLE vehiculos (
    vehiculo_id INT AUTO_INCREMENT,
    placa VARCHAR(20),
    marca_id INT,
    modelo_id INT,
    capacidad_carga DECIMAL(10,2),
    sucursal_id INT,
    CONSTRAINT Pk_id_vehiculos PRIMARY KEY (vehiculo_id),
    CONSTRAINT Fk_id_vehiculos_marcas FOREIGN KEY (marca_id) REFERENCES marcas(marca_id),
    CONSTRAINT Fk_id_vehiculos_modelos FOREIGN KEY (modelo_id) REFERENCES modelos(modelo_id),
    CONSTRAINT Fk_id_vehiculos_sucursales FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

CREATE TABLE rutas (
    ruta_id INT AUTO_INCREMENT,
    descripcion VARCHAR(200),
    sucursal_id INT,
    CONSTRAINT Pk_id_rutas PRIMARY KEY (ruta_id),
    CONSTRAINT Fk_id_rutas_sucursales FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

CREATE TABLE envios (
    envio_id INT AUTO_INCREMENT,
    cliente_id INT,
    paquete_id INT,
    fecha_envio TIMESTAMP,
    destino VARCHAR(200),
    ruta_id INT,
    sucursal_id INT,
    CONSTRAINT Pk_id_envios PRIMARY KEY (envio_id),
    CONSTRAINT Fk_id_envios_clientes FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    CONSTRAINT Fk_id_envios_paquetes FOREIGN KEY (paquete_id) REFERENCES paquetes(paquete_id),
    CONSTRAINT Fk_id_envios_rutas FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id),
    CONSTRAINT Fk_id_envios_sucursales FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

CREATE TABLE conductores_rutas (
    conductor_id INT,
    ruta_id INT,
    vehiculo_id INT,
    sucursal_id INT,
    CONSTRAINT Pk_id_conductores_rutas PRIMARY KEY (conductor_id, ruta_id),
    CONSTRAINT Fk_id_conductores_rutas_conductores FOREIGN KEY (conductor_id) REFERENCES conductores(conductor_id),
    CONSTRAINT Fk_id_conductores_rutas_rutas FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id),
    CONSTRAINT Fk_id_conductores_rutas_vehiculos FOREIGN KEY (vehiculo_id) REFERENCES vehiculos(vehiculo_id),
    CONSTRAINT Fk_id_conductores_rutas_sucursales FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

CREATE TABLE ruta_auxiliares (
    ruta_id INT,
    auxiliar_id INT,
    CONSTRAINT Pk_id_ruta_auxiliares PRIMARY KEY (ruta_id, auxiliar_id),
    CONSTRAINT Fk_id_ruta_auxiliares_rutas FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id),
    CONSTRAINT Fk_id_ruta_auxiliares_auxiliares FOREIGN KEY (auxiliar_id) REFERENCES auxiliares(auxiliar_id)
);
