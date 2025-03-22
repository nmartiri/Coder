
-- CREACION DE LAS TABLAS


CREATE DATABASE BilleteraVirtual;
USE BilleteraVirtual;

CREATE TABLE Cliente(
Id_Cliente int not null auto_increment,
DNI int not null,
Nombre varchar (100) not null,
Apellido varchar (100) not null,
Email varchar (320) not null,
Celular varchar (15) not null,
PRIMARY KEY (Id_Cliente),
unique (DNI),
unique (Email)
);

CREATE TABLE Cuenta(
Id_Cuenta int not null auto_increment,
Id_cliente int not null,
Saldo decimal (10,2) not null,
PRIMARY KEY (Id_Cuenta),
foreign key (Id_Cliente) references Cliente(Id_Cliente)
);

CREATE TABLE Tipo_de_Transaccion(
Id_Tipo_Transaccion int not null auto_increment,
Tipo_Transaccion varchar (13) not null,
PRIMARY KEY (Id_Tipo_Transaccion)
);

CREATE TABLE Transaccion(
Id_Transaccion int not null auto_increment,
Id_Cuenta_Origen int not null,
Id_Cuenta_Destino int not null,
Tipo_transaccion int not null,
Monto decimal (10,2) not null,
Fecha_Hora datetime not null,
PRIMARY KEY (Id_transaccion),
foreign key (Id_cuenta_Origen) references Cuenta(Id_Cuenta),
foreign key (Id_Cuenta_Destino) references Cuenta (Id_Cuenta),
foreign key (Tipo_Transaccion) references Tipo_de_Transaccion (Id_Tipo_Transaccion)
);




-- INSERTAR DATOS EN LAS TABLAS

INSERT INTO Cliente (DNI, Nombre, Apellido, Email, Celular)
VALUES
(11111111,"gabriela", "gomez", "gomez@gmail.com", "1511111111"),
(22222222, "mariano", "perez", "perez@gmail.com", "1522222222"),
(33333333, "ruth", "martinez", "rmatinez@gmail.com", "1533333333"),
(44444444, "facundo", "paredes", "fparedes@gmail.com", "1544444444"),
(55555555, "ayelen", "coria", "acoria@gmail.com", "1555555555");

INSERT INTO Cuenta (Id_cliente, Saldo)
VALUES
(1,10000),
(2,20000),
(3,30000),
(4,40000),
(5,50000);

INSERT INTO Tipo_de_Transaccion (Tipo_Transaccion)
VALUES
("Transferencia"),
("Deposito"),
("Retiro");

INSERT INTO Transaccion (Id_Cuenta_origen, Id_Cuenta_Destino, Tipo_Transaccion, Monto, Fecha_Hora)
VALUES
(1,2,1,1000.00, "2025-03-21 10:00:00"),
(2,2,2,2000.00, "2025-03-20 11:00:00"),
(3,3,3,3000.00,"2025-03-19 12:00:00"),
(4,5,1,4000.00, "2025-03-18 13:00:00"),
(5,5,2,5000.00, "2025-03-19 14:00:00");


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
WHERE transaccion.Tipo_transaccion = 1;

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
    

