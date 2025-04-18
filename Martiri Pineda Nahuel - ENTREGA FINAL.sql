
-- CREACION DE LAS TABLAS


CREATE DATABASE BilleteraVirtual;
USE BilleteraVirtual;


CREATE TABLE Sucursal (
  Id_Sucursal INT AUTO_INCREMENT PRIMARY KEY,
  Nombre VARCHAR(100),
  Direccion VARCHAR(200),
  Telefono VARCHAR(20)
);

CREATE TABLE Cliente(
Id_Cliente int not null auto_increment,
DNI int not null,
Nombre varchar (100) not null,
Apellido varchar (100) not null,
Email varchar (320) not null,
Celular varchar (15) ,
PRIMARY KEY (Id_Cliente),
unique (Email)
);

CREATE TABLE Cuenta(
Id_Cuenta int not null auto_increment,
Id_cliente int not null,
Saldo decimal (10,2) not null,
PRIMARY KEY (Id_Cuenta),
foreign key (Id_Cliente) references Cliente(Id_Cliente)
);


CREATE TABLE Moneda (
  Id_Moneda INT AUTO_INCREMENT PRIMARY KEY,
  Codigo VARCHAR(3), -- 'ARS', 'USD', 'EUR'
  Nombre VARCHAR(50)
);

CREATE TABLE Tipo_de_Transaccion(
Id_Tipo_Transaccion int not null auto_increment,
Tipo_Transaccion varchar (30) not null,
PRIMARY KEY (Id_Tipo_Transaccion)
);

CREATE TABLE Transaccion(
Id_Transaccion int not null auto_increment,
Id_Cuenta_Origen int not null,
Id_Cuenta_Destino int not null,
Id_Tipo_transaccion int not null,
Monto decimal (10,2) not null,
Fecha_Hora datetime not null,
Moneda int, 
PRIMARY KEY (Id_transaccion),
foreign key (Id_cuenta_Origen) references Cuenta(Id_Cuenta),
foreign key (Id_Cuenta_Destino) references Cuenta (Id_Cuenta),
foreign key (Id_Tipo_Transaccion) references Tipo_de_Transaccion (Id_Tipo_Transaccion),
foreign key (Moneda) references Moneda (Id_Moneda)
);

CREATE TABLE Tarjeta (
  Id_Tarjeta INT AUTO_INCREMENT PRIMARY KEY,
  Id_Cliente INT NOT NULL,
  Numero_Tarjeta VARCHAR(20) NOT NULL UNIQUE,
  Fecha_Vencimiento DATE NOT NULL,
  Tipo VARCHAR(10) NOT NULL,
  FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);


CREATE TABLE Sesion (
  Id_Sesion INT AUTO_INCREMENT PRIMARY KEY,
  Id_Cliente INT,
  Fecha_Ingreso DATETIME,
  IP VARCHAR(45),
  FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);


CREATE TABLE Notificacion (
  Id_Notificacion INT AUTO_INCREMENT PRIMARY KEY,
  Id_Cliente INT,
  Mensaje varchar (50),
  Fecha DATETIME,
  FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);

CREATE TABLE Prestamo (
  Id_Prestamo INT AUTO_INCREMENT PRIMARY KEY,
  Id_Cliente INT NOT NULL,
  Monto_Total DECIMAL(10,2) NOT NULL,
  Fecha_Solicitud DATE NOT NULL,
  FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);

CREATE TABLE Comercio (
  Id_Comercio INT AUTO_INCREMENT PRIMARY KEY,
  Nombre VARCHAR(100) NOT NULL,
  Rubro VARCHAR(100),
  Email VARCHAR(320),
  Telefono VARCHAR(20)
);


CREATE TABLE Beneficio (
  Id_Beneficio INT AUTO_INCREMENT PRIMARY KEY,
  Descripcion VARCHAR(255),
  Porcentaje_Descuento DECIMAL(5,2),
  Fecha_Inicio DATE,
  Fecha_Fin DATE
);

CREATE TABLE Pago (
  Id_Pago INT AUTO_INCREMENT PRIMARY KEY,
  Id_Cuenta INT NOT NULL,
  Id_Comercio INT NOT NULL,
  Monto DECIMAL(10,2) NOT NULL,
  Fecha_Hora DATETIME DEFAULT CURRENT_TIMESTAMP,
  Beneficio int,
  FOREIGN KEY (Id_Cuenta) REFERENCES Cuenta(Id_Cuenta),
  FOREIGN KEY (Id_Comercio) REFERENCES Comercio(Id_Comercio),
  foreign key (Beneficio) references Beneficio (Id_Beneficio)
);




CREATE TABLE Caja_Fuerte_Virtual (
  Id_CajaFuerte INT AUTO_INCREMENT PRIMARY KEY,
  Id_Cuenta INT NOT NULL,
  Monto decimal (10,2)  NOT NULL,
  FOREIGN KEY (Id_Cuenta) REFERENCES Cuenta(Id_Cuenta)
);
CREATE TABLE Pagos_Servicios (
  Id_Pago_Servicio INT AUTO_INCREMENT PRIMARY KEY,
  Id_Cuenta INT NOT NULL,
  Nombre_Servicio VARCHAR(100) NOT NULL, -- Ej: "Edenor", "Aysa", "Telecom"
  Monto DECIMAL(10,2) NOT NULL,
  Fecha_Hora DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (Id_Cuenta) REFERENCES Cuenta(Id_Cuenta)
);



-- INSERTAR DATOS EN LAS TABLAS

INSERT INTO Cliente (DNI, Nombre, Apellido, Email, Celular) VALUES
(30123456, 'Juan', 'Pérez', 'juan.perez@gmail.com', '+5491123456789'),
(32567890, 'María', 'Gómez', 'maria.gomez@hotmail.com', '+5491134567890'),
(34123456, 'Lucas', 'Rodríguez', 'lucas.rodriguez@yahoo.com', '+5491145678901'),
(29876543, 'Sofía', 'Fernández', 'sofia.fernandez@gmail.com', '+5491156789012'),
(31234567, 'Diego', 'López', 'diego.lopez@outlook.com', '+5491167890123'),
(33098765, 'Camila', 'Martínez', 'camila.martinez@gmail.com', '+5491178901234'),
(28765432, 'Mateo', 'García', 'mateo.garcia@hotmail.com', '+5491189012345'),
(34987654, 'Valentina', 'Díaz', 'valentina.diaz@yahoo.com', '+5491190123456'),
(30543210, 'Santiago', 'Sánchez', 'santiago.sanchez@gmail.com', '+5491101234567'),
(31876543, 'Lucía', 'Romero', 'lucia.romero@outlook.com', '+5491112345678'),
(29432109, 'Benjamín', 'Torres', 'benjamin.torres@gmail.com', '+5491123456780'),
(33789012, 'Ema', 'Ramírez', 'emma.ramirez@hotmail.com', '+5491134567891'),
(30987654, 'Tomás', 'Flores', 'tomas.flores@yahoo.com', '+5491145678902'),
(32654321, 'Isabella', 'Vega', 'isabella.vega@gmail.com', '+5491156789013'),
(34321098, 'Martín', 'Morales', 'martin.morales@outlook.com', '+5491167890124');

INSERT INTO Cuenta (Id_Cliente, Saldo) VALUES
(1, 15000.50),
(2, 23000.75),
(3, 8700.25),
(4, 45000.00),
(5, 12000.30),
(6, 30000.10),
(7, 5000.00),
(8, 78000.90),
(9, 2500.45),
(10, 19000.60),
(11, 34000.20),
(12, 6500.80),
(13, 42000.15),
(14, 10000.00),
(15, 28000.70);

INSERT INTO Tipo_de_Transaccion (Tipo_Transaccion) VALUES
('Transferencia'),
('Pago Servicio'),
('Compra Comercio'),
('Depósito'),
('Extracción'),
('Pago Tarjeta'),
('Préstamo'),
('Carga Saldo'),
('Reembolso'),
('Inversión'),
('Donación'),
('Suscripción'),
('Cambio Moneda'),
('Pago QR'),
('Devolución');



INSERT INTO Transaccion (Id_Cuenta_Origen, Id_Cuenta_Destino, Id_Tipo_Transaccion, Monto, Fecha_Hora) VALUES
(1, 2, 1, 5000.00, '2025-04-01 10:30:00'),
(3, 4, 1, 2000.50, '2025-04-02 14:15:00'),
(5, 6, 1, 15000.00, '2025-04-03 09:45:00'),
(7, 8, 1, 3000.75, '2025-04-04 16:20:00'),
(9, 10, 1, 1000.00, '2025-04-05 11:10:00'),
(11, 12, 2, 2500.30, '2025-04-06 13:50:00'),
(13, 14, 3, 4500.00, '2025-04-07 18:00:00'),
(15, 1, 4, 10000.00, '2025-04-08 08:30:00'),
(2, 3, 5, 2000.00, '2025-04-09 12:00:00'),
(4, 5, 6, 3500.25, '2025-04-10 15:45:00'),
(6, 7, 7, 8000.00, '2025-04-11 17:30:00'),
(8, 9, 8, 12000.00, '2025-04-12 09:15:00'),
(10, 11, 9, 1500.50, '2025-04-13 14:20:00'),
(12, 13, 10, 6000.00, '2025-04-14 10:00:00'),
(14, 15, 11, 4000.00, '2025-04-15 11:30:00');

INSERT INTO Tarjeta (Id_Cliente, Numero_Tarjeta, Fecha_Vencimiento, Tipo) VALUES
(1, '4532015112831234', '2027-12-31', 'Débito'),
(2, '4916112233445566', '2028-03-31', 'Crédito'),
(3, '5221345678901234', '2027-09-30', 'Crédito'),
(4, '4539012345678901', '2028-06-30', 'Débito'),
(5, '4716123456789012', '2027-11-30', 'Prepaga'),
(6, '5332123456781234', '2028-01-31', 'Crédito'),
(7, '4539123456789012', '2027-08-31', 'Débito'),
(8, '4916234567890123', '2028-04-30', 'Crédito'),
(9, '5223456789012345', '2027-10-31', 'Prepaga'),
(10, '4539345678901234', '2028-02-28', 'Débito'),
(11, '4716345678901234', '2027-07-31', 'Crédito'),
(12, '5332456789012345', '2028-05-31', 'Débito'),
(13, '4539456789012345', '2027-06-30', 'Prepaga'),
(14, '4916456789012345', '2028-08-31', 'Crédito'),
(15, '5223567890123456', '2027-12-31', 'Débito');

INSERT INTO Sucursal (Nombre, Direccion, Telefono) VALUES
('Sucursal Palermo', 'Av. Santa Fe 3500, Palermo, CABA', '+541147890123'),
('Sucursal Recoleta', 'Av. Callao 1200, Recoleta, CABA', '+541148901234'),
('Sucursal Belgrano', 'Av. Cabildo 2300, Belgrano, CABA', '+541149012345'),
('Sucursal San Telmo', 'Defensa 900, San Telmo, CABA', '+541150123456'),
('Sucursal Microcentro', 'Florida 500, Microcentro, CABA', '+541151234567'),
('Sucursal Almagro', 'Av. Corrientes 4000, Almagro, CABA', '+541152345678'),
('Sucursal Villa Crespo', 'Av. Juan B. Justo 3000, Villa Crespo, CABA', '+541153456789'),
('Sucursal Caballito', 'Av. Rivadavia 5500, Caballito, CABA', '+541154567890'),
('Sucursal Flores', 'Av. Rivadavia 7000, Flores, CABA', '+541155678901'),
('Sucursal Boedo', 'Av. San Juan 3500, Boedo, CABA', '+541156789012'),
('Sucursal Barracas', 'Av. Montes de Oca 900, Barracas, CABA', '+541157890123'),
('Sucursal Nuñez', 'Av. Libertador 6500, Nuñez, CABA', '+541158901234'),
('Sucursal Saavedra', 'Av. Balbín 4000, Saavedra, CABA', '+541159012345'),
('Sucursal Villa Urquiza', 'Av. Triunvirato 4500, Villa Urquiza, CABA', '+541160123456'),
('Sucursal Colegiales', 'Av. Lacroze 2800, Colegiales, CABA', '+541161234567');

INSERT INTO Sesion (Id_Cliente, Fecha_Ingreso, IP) VALUES
(1, '2025-04-01 08:00:00', '192.168.1.10'),
(2, '2025-04-02 09:15:00', '172.16.0.20'),
(3, '2025-04-03 10:30:00', '10.0.0.30'),
(4, '2025-04-04 11:45:00', '192.168.2.40'),
(5, '2025-04-05 12:00:00', '172.16.1.50'),
(6, '2025-04-06 13:15:00', '10.0.1.60'),
(7, '2025-04-07 14:30:00', '192.168.3.70'),
(8, '2025-04-08 15:45:00', '172.16.2.80'),
(9, '2025-04-09 16:00:00', '10.0.2.90'),
(10, '2025-04-10 17:15:00', '192.168.4.100'),
(11, '2025-04-11 18:30:00', '172.16.3.110'),
(12, '2025-04-12 19:45:00', '10.0.3.120'),
(13, '2025-04-13 20:00:00', '192.168.5.130'),
(14, '2025-04-14 21:15:00', '172.16.4.140'),
(15, '2025-04-15 22:30:00', '10.0.4.150');

INSERT INTO Moneda (Codigo, Nombre) VALUES
('ARS', 'Peso Argentino'),
('USD', 'Dólar Estadounidense'),
('EUR', 'Euro'),
('BRL', 'Real Brasileño'),
('CLP', 'Peso Chileno'),
('UYU', 'Peso Uruguayo'),
('COP', 'Peso Colombiano'),
('PEN', 'Sol Peruano'),
('MXN', 'Peso Mexicano'),
('GBP', 'Libra Esterlina'),
('JPY', 'Yen Japonés'),
('CNY', 'Yuan Chino'),
('CAD', 'Dólar Canadiense'),
('AUD', 'Dólar Australiano'),
('CHF', 'Franco Suizo');

INSERT INTO Notificacion (Id_Cliente, Mensaje, Fecha) VALUES
(1, 'Transferencia enviada: $5000', '2025-04-01 10:35:00'),
(2, 'Pago de servicio confirmado', '2025-04-02 14:20:00'),
(3, 'Nueva tarjeta añadida', '2025-04-03 09:50:00'),
(4, 'Compra en comercio exitosa', '2025-04-04 16:25:00'),
(5, 'Saldo bajo: $12000.30', '2025-04-05 11:15:00'),
(6, 'Préstamo solicitado', '2025-04-06 13:55:00'),
(7, 'Sesión iniciada desde IP nueva', '2025-04-07 14:35:00'),
(8, 'Reembolso recibido: $1500', '2025-04-08 18:05:00'),
(9, 'Carga de saldo confirmada', '2025-04-09 12:05:00'),
(10, 'Tarjeta próxima a vencer', '2025-04-10 15:50:00'),
(11, 'Beneficio activado: 10% off', '2025-04-11 17:35:00'),
(12, 'Pago QR procesado', '2025-04-12 09:20:00'),
(13, 'Depósito confirmado: $6000', '2025-04-13 14:25:00'),
(14, 'Cambio de moneda exitoso', '2025-04-14 10:05:00'),
(15, 'Notificación de mantenimiento', '2025-04-15 11:35:00');

INSERT INTO Prestamo (Id_Cliente, Monto_Total, Fecha_Solicitud) VALUES
(1, 50000.00, '2025-04-01'),
(2, 75000.00, '2025-04-02'),
(3, 30000.00, '2025-04-03'),
(4, 100000.00, '2025-04-04'),
(5, 25000.00, '2025-04-05'),
(6, 60000.00, '2025-04-06'),
(7, 40000.00, '2025-04-07'),
(8, 120000.00, '2025-04-08'),
(9, 15000.00, '2025-04-09'),
(10, 80000.00, '2025-04-10'),
(11, 55000.00, '2025-04-11'),
(12, 35000.00, '2025-04-12'),
(13, 90000.00, '2025-04-13'),
(14, 20000.00, '2025-04-14'),
(15, 65000.00, '2025-04-15');

INSERT INTO Comercio (Nombre, Rubro, Email, Telefono) VALUES
('Supermercado Coto', 'Supermercado', 'coto@supermercado.com', '+541147890123'),
('Farmacia Farmacity', 'Farmacia', 'farmacity@farmacia.com', '+541148901234'),
('Resto La Cabrera', 'Gastronomía', 'lacabrera@resto.com', '+541149012345'),
('Librería Yenny', 'Librería', 'yenny@libreria.com', '+541150123456'),
('Tienda Falabella', 'Ropa', 'falabella@tienda.com', '+541151234567'),
('Cine Hoyts', 'Cine', 'hoyts@cine.com', '+541152345678'),
('Heladería Freddo', 'Heladería', 'freddo@heladeria.com', '+541153456789'),
('Electro Garbarino', 'Electrónica', 'garbarino@electro.com', '+541154567890'),
('Pizzeria Güerrín', 'Gastronomía', 'guerrin@pizzeria.com', '+541155678901'),
('Perfumería Juleriaque', 'Perfumería', 'juleriaque@perfumeria.com', '+541156789012'),
('Zapatería Grimoldi', 'Calzado', 'grimoldi@zapateria.com', '+541157890123'),
('Café Starbucks', 'Cafetería', 'starbucks@cafe.com', '+541158901234'),
('Gimnasio Megatlon', 'Gimnasio', 'megatlon@gimnasio.com', '+541159012345'),
('Juguetería Cebra', 'Juguetería', 'cebra@jugueteria.com', '+541160123456'),
('Óptica Visión', 'Óptica', 'vision@optica.com', '+541161234567');

INSERT INTO Pago (Id_Cuenta, Id_Comercio, Monto, Fecha_Hora) VALUES
(1, 1, 3500.00, '2025-04-01 12:00:00'),
(2, 2, 1200.50, '2025-04-02 15:30:00'),
(3, 3, 5000.00, '2025-04-03 20:00:00'),
(4, 4, 2800.75, '2025-04-04 10:15:00'),
(5, 5, 4500.00, '2025-04-05 14:45:00'),
(6, 6, 3200.00, '2025-04-06 18:30:00'),
(7, 7, 1500.25, '2025-04-07 09:00:00'),
(8, 8, 6000.00, '2025-04-08 16:20:00'),
(9, 9, 2500.00, '2025-04-09 13:10:00'),
(10, 10, 1800.50, '2025-04-10 11:50:00'),
(11, 11, 4000.00, '2025-04-11 17:00:00'),
(12, 12, 2200.00, '2025-04-12 08:30:00'),
(13, 13, 3000.00, '2025-04-13 14:00:00'),
(14, 14, 2700.00, '2025-04-14 12:45:00'),
(15, 15, 1900.00, '2025-04-15 10:30:00');

INSERT INTO Beneficio (Descripcion, Porcentaje_Descuento, Fecha_Inicio, Fecha_Fin) VALUES
('Descuento en Supermercados', 10.00, '2025-04-01', '2025-04-30'),
('Promo Farmacias', 15.00, '2025-04-01', '2025-04-15'),
('Happy Hour Restaurantes', 20.00, '2025-04-05', '2025-04-12'),
('Descuento en Librerías', 10.00, '2025-04-10', '2025-04-20'),
('Oferta Ropa', 25.00, '2025-04-01', '2025-04-30'),
('2x1 en Cines', 50.00, '2025-04-07', '2025-04-14'),
('Promo Heladerías', 15.00, '2025-04-01', '2025-04-30'),
('Descuento Electrónica', 10.00, '2025-04-05', '2025-04-25'),
('Oferta Pizzerías', 20.00, '2025-04-01', '2025-04-15'),
('Descuento Perfumerías', 15.00, '2025-04-10', '2025-04-20'),
('Promo Calzado', 10.00, '2025-04-01', '2025-04-30'),
('Descuento Cafeterías', 20.00, '2025-04-05', '2025-04-12'),
('Oferta Gimnasios', 30.00, '2025-04-01', '2025-04-30'),
('Descuento Jugueterías', 15.00, '2025-04-10', '2025-04-20'),
('Promo Ópticas', 10.00, '2025-04-01', '2025-04-30');

INSERT INTO Caja_Fuerte_Virtual (Id_Cuenta, Monto) VALUES
(1, 10000.00),
(2, 15000.00),
(3, 5000.00),
(4, 20000.00),
(5, 3000.00),
(6, 25000.00),
(7, 8000.00),
(8, 30000.00),
(9, 2000.00),
(10, 12000.00),
(11, 18000.00),
(12, 4000.00),
(13, 22000.00),
(14, 6000.00),
(15, 14000.00);

INSERT INTO Pagos_Servicios (Id_Cuenta, Nombre_Servicio, Monto, Fecha_Hora) VALUES
(1, 'Luz (Edenor)', 3500.00, '2025-04-01 09:00:00'),
(2, 'Gas (Metrogas)', 2000.50, '2025-04-02 10:30:00'),
(3, 'Agua (AySA)', 1500.00, '2025-04-03 11:45:00'),
(4, 'Internet (Fibertel)', 4500.00, '2025-04-04 13:00:00'),
(5, 'Telefonía (Movistar)', 2800.75, '2025-04-05 14:15:00'),
(6, 'Luz (Edesur)', 4000.00, '2025-04-06 15:30:00'),
(7, 'Gas (Naturgy)', 1800.00, '2025-04-07 16:45:00'),
(8, 'Agua (AySA)', 2200.00, '2025-04-08 18:00:00'),
(9, 'Internet (Telecentro)', 3000.00, '2025-04-09 09:15:00'),
(10, 'Telefonía (Claro)', 2500.00, '2025-04-10 10:30:00'),
(11, 'Luz (Edenor)', 3700.00, '2025-04-11 11:45:00'),
(12, 'Gas (Metrogas)', 1900.00, '2025-04-12 13:00:00'),
(13, 'Agua (AySA)', 1600.00, '2025-04-13 14:15:00'),
(14, 'Internet (Fibertel)', 4200.00, '2025-04-14 15:30:00'),
(15, 'Telefonía (Personal)', 2700.00, '2025-04-15 16:45:00');





--  ***CREACION DE VISTAS***

-- Vista 1 - para ver saldos y numeros de cuentas, pero ningun otro dato

CREATE VIEW Saldos_Actuales_por_Cuenta 
AS SELECT Id_cuenta, Saldo 
FROM Cuenta;

SELECT * FROM Saldos_Actuales_por_Cuenta;

-- Vista 2 - para ver que tipo de transaciones existen

Create VIEW Transacciones_Existentes 
AS SELECT Tipo_Transaccion 
FROM tipo_de_transaccion;

Select * FROM Transacciones_Existentes;

-- Vista 3 - para ver transacciones realizadas mayores a $2000 con su cuenta origen
CREATE VIEW Transacciones_Mayores_de_2000
AS SELECT Id_Cuenta_Origen, Monto
FROM transaccion
WHERE Monto>2000;

Select * FROM Transacciones_mayores_de_2000;

-- Vista 4 - para ver todo cliente que haya recibido una tranferencia

CREATE VIEW Cliente_Recibio_Tranferencia
AS 
SELECT Cliente.Apellido, Cliente.Nombre, Cliente.Email
FROM Transaccion
JOIN Cuenta ON Transaccion.Id_Cuenta_Destino = Cuenta.Id_Cuenta
JOIN Cliente ON Cuenta.Id_Cliente = Cliente.Id_Cliente
WHERE transaccion.Id_Tipo_transaccion = 1;

Select * From Cliente_Recibio_Tranferencia;

-- Vista 5 -para ver clientes con DNI menores a 30 Millones

Create view Clientes_DNI_Menor_30Millones
AS
Select cliente.Id_Cliente, cliente.Apellido, cliente.Nombre
From cliente
Where cliente.DNI< 30000000;

Select * From Clientes_DNI_Menor_30Millones;





-- FUNCIONES

-- Función para calcular el total de tranferencias realizadas por un usuario

DROP function IF exists CalcularTotalTransferido;
DELIMITER //
CREATE FUNCTION CalcularTotalTransferido (idcuenta INT)
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN
DECLARE total DECIMAL (10,2);

Select SUM(Monto) INTO total
FROM transaccion
where Id_Cuenta_Origen = idCuenta;

If total IS NULL THEN 
SET total = 0;
END IF;

RETURN total;

END //
DELIMITER ;

Select Cliente.Nombre, CalcularTotalTransferido(Cuenta.Id_Cuenta) AS Monto_total
FROM Transaccion
Join Cuenta On Transaccion.Id_Cuenta_Origen = Cuenta.Id_Cuenta
Join Cliente ON Cuenta.Id_Cliente = Cliente.Id_Cliente;


-- Función para ver la primera tranferencia realizada por un usuario

DROP FUNCTION IF exists PrimeraTransferencia;
DELIMITER //
CREATE FUNCTION Primeratransferencia (idcuenta INT)
RETURNS DATETIME
DETERMINISTIC
BEGIN 
	DECLARE fecha_primer DATETIME;
    
    select MIN(Fecha_Hora) INTO Fecha_primer
    FROM transaccion
    WHERE Id_Cuenta_Origen = idcuenta;
    
    return Fecha_primer;
    
end //
DELIMITER ;

Select Cliente.Nombre, Cliente.Apellido AS Primera_Transferencia
FROM Cuenta
JOIN Cliente on Cuenta.Id_Cliente = Cliente.Id_Cliente;
    




-- STORED PROCEDURES


-- STORED PROCEDURES 1 --- actualizar email de un cliente


DELIMITER //

CREATE PROCEDURE Actualizar_email(
    IN pId INT,
    IN pemail VARCHAR(100)
)
BEGIN 
    UPDATE Cliente
    SET Email = pemail
    WHERE Id_Cliente = pId;
    
End //

DELIMITER ;



CALL Actualizar_email (1, 'miemil@gmail.com');


select * from Cliente;

-- STORED PROCEDURES 2 --- Borrar una caja fuerte en caso de que la misma no se pueda utilizar más

DELIMITER //
CREATE PROCEDURE EliminarCajaFuerte(
	IN pId INT
    )
    
    BEGIN 
		DELETE FROM Caja_Fuerte_Virtual
        WHERE Id_CajaFuerte = pId;
	END//
    
DELIMITER ;
CALL EliminarCajaFuerte (1);


 
 
 
 
 
 
-- Triggers


-- Triggers 1 --- Si en el alta de un cliente no se completa celular se inserta automaticamente "sin info"

DELIMITER //
CREATE TRIGGER RellenarCelular
BEFORE INSERT ON Cliente 
FOR EACH ROW
BEGIN
	IF NEW.Celular IS NULL OR NEW.Celular = '' THEN
		SET NEW.Celular = "sin info";
	END IF
END ;

DELIMITER ;

INSERT INTO Cliente (Id_Cliente, DNI, Nombre, Apellido, Email, Celular) VALUES ('45', '36725566', 'Nahuel', 'Gomez', 'carlos@email.com', null);



-- Triggers 2--- convertir email en minuscula

DELIMITER //

CREATE TRIGGER ConvertirEmail
BEFORE INSERT ON Cliente
FOR EACH row
BEGIN 
	SET NEW.Email = LOWER(NEW.Email)
END //

DELIMITER ;

INSERT INTO Cliente (Id_Cliente, DNI, Nombre, Apellido, Email, Celular) VALUES ('47', '36125566', 'Tomas', 'Perez', 'TOMASperez@gmail.com', +91123567845);



