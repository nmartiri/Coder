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

