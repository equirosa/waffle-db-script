--DROP DATABASE WAFFLE; --ELIMINAR LUEGO ESTA SECCION
CREATE DATABASE WAFFLE;
USE WAFFLE;

--CATEGORIAS


CREATE TABLE CATEGORIA(
	ID INT PRIMARY KEY,
	NOMBRE VARCHAR(50) NOT NULL,
);
GO
	--INSERTAR
CREATE PROCEDURE CRE_CATEGORIA_PR
	@ID INT,
	@NOMBRE VARCHAR(50)
AS INSERT INTO CATEGORIA VALUES(@ID,@NOMBRE);
GO

	--RETRIEVE ALL
CREATE PROCEDURE RET_ALL_CATEGORIA_PR
AS
	SELECT ID, NOMBRE FROM CATEGORIA;
RETURN 0
GO

	--UPDATE
CREATE PROCEDURE UPD_CATEGORIA_PR
	@ID INT,
	@NOMBRE VARCHAR(50)
AS 
	UPDATE CATEGORIA SET NOMBRE=@NOMBRE WHERE ID=@ID;
GO

	--RETRIEVE BY ID
CREATE PROCEDURE RET_CATEGORIA_PR
	@ID INT
AS
	SELECT ID, NOMBRE FROM CATEGORIA WHERE ID=@ID
GO

	--DELETE
CREATE PROCEDURE DEL_CATEGORIA_PR
	@ID INT
AS
	DELETE FROM CATEGORIA WHERE ID=@ID;
RETURN 0
GO



--DIRECCIONES


CREATE TABLE DIRECCION(
	ID INT PRIMARY KEY,
	LATITUD VARCHAR(50) NOT NULL,
	LONGITUD VARCHAR(50) NOT NULL,
);
GO

CREATE PROCEDURE CRE_DIRECCION_PR
	@ID INT,
	@LATITUD VARCHAR(50),
	@LONGITUD VARCHAR(50)
AS
	INSERT INTO DIRECCION VALUES(@ID,@LATITUD,@LONGITUD);
GO

CREATE PROCEDURE RET_ALL_DIRECCION_PR
AS
	SELECT ID, LATITUD, LONGITUD FROM DIRECCION;
GO

CREATE PROCEDURE RET_DIRECCION_PR
	@ID INT
AS
	SELECT ID, LATITUD, LONGITUD FROM DIRECCION WHERE ID=@ID;
GO

CREATE PROCEDURE UPD_DIRECCION_PR
	@ID INT,
	@LATITUD VARCHAR(50),
	@LONGITUD VARCHAR(50)
AS
	UPDATE DIRECCION SET LATITUD=@LATITUD, LONGITUD=@LONGITUD WHERE ID=@ID;
GO

CREATE PROCEDURE DEL_DIRECCION_PR
	@ID INT
AS
	DELETE FROM DIRECCION WHERE ID=@ID;
GO

--USUARIOS
CREATE TABLE USUARIO(
	CEDULA VARCHAR(50) PRIMARY KEY,
	NOMBRE VARCHAR(50) NOT NULL,
	APELLIDO1 VARCHAR(50) NOT NULL,
	APELLIDO2 VARCHAR(50) NULL,
	CORREO VARCHAR(50) NOT NULL,
	CONTRASENNA VARCHAR(50) NOT NULL,
	TEL VARCHAR(50) NOT NULL,
	PAYPAL VARCHAR(50) NOT NULL,
	FOTO_PERFIL VARCHAR(50) NULL,
	ESTADO VARCHAR(20) NOT NULL,
	TIPO_IDENTIFICACION VARCHAR(50) NOT NULL,
	CODIGO_VERIFICACION VARCHAR(50) NOT NULL,
 );
GO

CREATE PROCEDURE CRE_USUARIO_PR
	@CEDULA VARCHAR(50),
	@NOMBRE VARCHAR(50),
	@APELLIDO1 VARCHAR(50),
	@APELLIDO2 VARCHAR(50),
	@CORREO VARCHAR(50),
	@CONTRASENNA VARCHAR(50),
	@TEL VARCHAR(50),
	@PAYPAL VARCHAR(50),
	@ESTADO VARCHAR(20),
	@TIPO_IDENTIFICACION VARCHAR(50),
	@CODIGO_VERIFICACION VARCHAR(50)
AS
	INSERT INTO USUARIO VALUES(@CEDULA,@NOMBRE,@APELLIDO1,@APELLIDO2,@CORREO,
		@CONTRASENNA, @TEL, @PAYPAL, @ESTADO, @TIPO_IDENTIFICACION,
		@CODIGO_VERIFICACION);
GO

CREATE PROCEDURE RET_ALL_USUARIO_PR
AS
	SELECT CEDULA,NOMBRE,APELLIDO1,APELLIDO2,CORREO,
		CONTRASENNA, TEL, PAYPAL, FOTO_PERFIL, ESTADO, TIPO_IDENTIFICACION,
		CODIGO_VERIFICACION FROM USUARIO;
GO

CREATE PROCEDURE RET_USUARIO_PR
	@CEDULA VARCHAR(50)
AS
	SELECT CEDULA,NOMBRE,APELLIDO1,APELLIDO2,CORREO,
		CONTRASENNA, TEL, PAYPAL, FOTO_PERFIL, ESTADO, TIPO_IDENTIFICACION,
		CODIGO_VERIFICACION FROM USUARIO WHERE CEDULA=@CEDULA;
GO

CREATE PROCEDURE UPD_USUARIO_PR
	@CEDULA VARCHAR(50),
	@NOMBRE VARCHAR(50),
	@APELLIDO1 VARCHAR(50),
	@APELLIDO2 VARCHAR(50),
	@CORREO VARCHAR(50),
	@CONTRASENNA VARCHAR(50),
	@TEL VARCHAR(50),
	@PAYPAL VARCHAR(50),
	@ESTADO VARCHAR(20),
	@TIPO_IDENTIFICACION VARCHAR(50),
	@CODIGO_VERIFICACION VARCHAR(50)
AS
	UPDATE USUARIO SET NOMBRE=@NOMBRE,APELLIDO1=@APELLIDO1,APELLIDO2=@APELLIDO2,
		CORREO=@CORREO,CONTRASENNA=@CONTRASENNA,TEL=@TEL,PAYPAL=@PAYPAL,ESTADO=@ESTADO,
		TIPO_IDENTIFICACION=@TIPO_IDENTIFICACION,CODIGO_VERIFICACION=@CODIGO_VERIFICACION);
GO

CREATE PROCEDURE DEL_USUARIO_PR
	@CEDULA VARCHAR(50)
AS
	DELETE FROM USUARIO WHERE CEDULA=@CEDULA;
GO


--CADENAS
CREATE TABLE CADENA(
	ID INT PRIMARY KEY,
	CEDULA_DUENNIO VARCHAR(50) FOREIGN KEY REFERENCES USUARIO(CEDULA),
	LOGO VARCHAR(100) NOT NULL);
GO


--COMERCIOS

CREATE TABLE COMERCIO(
	CEDULA_JURIDICA VARCHAR(50) PRIMARY KEY,
	CEDULA_DUENO VARCHAR(50) FOREIGN KEY REFERENCES USUARIO(CEDULA),
	ID_DIRECCION INT FOREIGN KEY REFERENCES DIRECCION(ID),
	ID_CATEGORIA INT FOREIGN KEY REFERENCES CATEGORIA(ID),
	ID_CADENA INT FOREIGN KEY REFERENCES CADENA(ID),
	REGIMEN VARCHAR(50) NOT NULL,
	TELEFONO VARCHAR(50) NOT NULL,
	HORARIO_APERTURA time(7) NOT NULL,
	HORARIO_CLAUSURA time(7) NOT NULL,
	UBICACION_ESCRITA VARCHAR(50) NOT NULL,
	NOMBRE_COMERCIAL VARCHAR(50) NOT NULL,
	FECHA_CREACION date NOT NULL,
	WEB VARCHAR(50) NOT NULL,
	ESTADO VARCHAR(10) NOT NULL,
	SUPERVISOR VARCHAR(50) FOREIGN KEY REFERENCES USUARIO(CADENA));
GO

ALTER TABLE COMERCIO CHECK CONSTRAINT FK_SUPERVISOR_COMERCIO
GO

	--INSERT
CREATE PROCEDURE CRE_COMERCIO_PR
	@CEDULA_JURIDICA VARCHAR(50),
	@CEDULA_DUENO VARCHAR(50),
	@ID_DIRECCION INT,
	@ID_CATEGORIA INT,
	@ID_CADENA INT,
	@REGIMEN VARCHAR(50),
	@TELEFONO VARCHAR(50),
	@HORARIO_APERTURA TIME(7),
	@HORARIO_CLAUSURA TIME(7),
	@UBICACION_ESCRITA VARCHAR(50),
	@NOMBRE_COMERCIAL VARCHAR(50),
	@FECHA_CREACION DATE,
	@WEB VARCHAR(50),
	@ESTADO VARCHAR(10),
	@SUPERVISOR VARCHAR(50)
AS INSERT INTO COMERCIO VALUES (@CEDULA_JURIDICA,@CEDULA_DUENO,@ID_DIRECCION,@ID_CADENA,@ID_CADENA,@REGIMEN,@TELEFONO,
		@HORARIO_APERTURA,@HORARIO_CLAUSURA,@UBICACION_ESCRITA,@NOMBRE_COMERCIAL,@FECHA_CREACION,@WEB,@ESTADO,@SUPERVISOR);
	GO

	--RETRIEVE ALL
CREATE PROCEDURE RET_ALL_COMERCIO_PR
AS SELECT CEDULA_JURIDICA,CEDULA_DUENO,ID_DIRECCION,ID_CATEGORIA,ID_CADENA,REGIMEN,TELEFONO,HORARIO_APERTURA,HORARIO_CLAUSURA,
	UBICACION_ESCRITA,NOMBRE_COMERCIAL,FECHA_CREACION,WEB,ESTADO,SUPERVISOR FROM COMERCIO;
RETURN 0
GO
--FLOTILLAS

CREATE TABLE FLOTILLA(
	ID INT NOT NULL,
	NOMBRE VARCHAR(50) NOT NULL,
	DESCRIPCION VARCHAR(50) NULL,
 CONSTRAINT PK_FLOTILLA PRIMARY KEY CLUSTERED 
(
	ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON PRIMARY
) ON PRIMARY
GO


--HISTORIAL DE CONTRASE�AS

CREATE TABLE HISTORICO_CONTRASENA(
	FECHA date NOT NULL,
	CEDULA_USUARIO VARCHAR(50) NOT NULL,
	CONTRASENA VARCHAR(50) NOT NULL
) ON PRIMARY
GO

ALTER TABLE HISTORICO_CONTRASENA  WITH CHECK ADD  CONSTRAINT FK_USUARIO_HISTORICO FOREIGN KEY(CEDULA_USUARIO)
REFERENCES USUARIO (CEDULA)
GO

ALTER TABLE HISTORICO_CONTRASENA CHECK CONSTRAINT FK_USUARIO_HISTORICO
GO


--MEMBRESIAS
CREATE TABLE MEMBRESIA(
	CODIGO_MEMBRESIA VARCHAR(50) NOT NULL,
	CEDULA_USUARIO VARCHAR(50) NOT NULL,
	MONTO float NOT NULL,
	FECHA_COMPRADA date NOT NULL,
	FECHA_EXPIRADA date NOT NULL,
	COMISION_PEDIDO float NOT NULL,
	TIPO_MEMBRESIA VARCHAR(50) NOT NULL,
 CONSTRAINT PK_MEMBRESIA PRIMARY KEY CLUSTERED 
(
	CODIGO_MEMBRESIA ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON PRIMARY
) ON PRIMARY
GO

ALTER TABLE MEMBRESIA  WITH CHECK ADD  CONSTRAINT FK_USUARIO_MEMBRESIA FOREIGN KEY(CEDULA_USUARIO)
REFERENCES USUARIO (CEDULA)
GO

ALTER TABLE MEMBRESIA CHECK CONSTRAINT FK_USUARIO_MEMBRESIA
GO




--VEHICULOS

CREATE TABLE VEHICULO(
	PLACA VARCHAR(50) NOT NULL,
	MODELO VARCHAR(50) NOT NULL,
	TIPO VARCHAR(50) NOT NULL,
	CEDULA_DUENNIO VARCHAR(50) NOT NULL,
	ID_FLOTILLA INT NULL,
 CONSTRAINT PK_VEHICULO PRIMARY KEY CLUSTERED 
(
	PLACA ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON PRIMARY
) ON PRIMARY
GO

ALTER TABLE VEHICULO  WITH CHECK ADD  CONSTRAINT FK_DUENNIO FOREIGN KEY(CEDULA_DUENNIO)
REFERENCES USUARIO (CEDULA)
GO

ALTER TABLE VEHICULO CHECK CONSTRAINT FK_DUENNIO
GO

ALTER TABLE VEHICULO  WITH CHECK ADD  CONSTRAINT FK_FLOTILLA FOREIGN KEY(ID_FLOTILLA)
REFERENCES FLOTILLA (ID)
GO

ALTER TABLE VEHICULO CHECK CONSTRAINT FK_FLOTILLA
GO

--PRODUCTOS

CREATE TABLE PRODUCTO(
	ID INT NOT NULL,
	NOMBRE VARCHAR(50) NOT NULL,
	ID_CATEGORIA INT NOT NULL,
	CEDULA_COMERCIO VARCHAR(50) NOT NULL,
	PRECIO float NOT NULL,
	ESTADO VARCHAR(10) NOT NULL,
	CONSTRAINT PK_PRODUCTO PRIMARY KEY CLUSTERED
	(
		ID ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON PRIMARY
	) ON PRIMARY
	GO

ALTER TABLE PRODUCTO WITH CHECK ADD CONSTRAINT FK_COMERCIO FOREIGN KEY(CEDULA_COMERCIO)
REFERENCES COMERCIO (CEDULA_JURIDICA)
GO

ALTER TABLE PRODUCTO CHECK CONSTRAINT FK_COMERCIO
GO

ALTER TABLE PRODUCTO WITH CHECK ADD CONSTRAINT FK_CATEGORIA FOREIGN KEY(ID_CATEGORIA)
REFERENCES CATEGORIA (ID)
GO

ALTER TABLE PRODUCTO CHECK CONSTRAINT FK_CATEGORIA
GO

--ORDENES
CREATE TABLE ORDEN(
	ID INT NOT NULL,
	ID_DIRECCION INT NOT NULL,
	CEDULA_USUARIO VARCHAR(50) NOT NULL,
	CEDULA_COMERCIO VARCHAR(50) NOT NULL,
	CEDULA_CONDUCTOR VARCHAR(50) NOT NULL,
	ESTADO VARCHAR(50) NOT NULL,
	FECHA date NOT NULL,
	CONSTRAINT PK_ORDEN PRIMARY KEY CLUSTERED
	(
		ID ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON PRIMARY
	) ON PRIMARY
	GO

ALTER TABLE ORDEN WITH CHECK ADD CONSTRAINT FK_USUARIO_FINAL FOREIGN KEY(CEDULA_USUARIO)
REFERENCES USUARIO (CEDULA)
GO

ALTER TABLE ORDEN CHECK CONSTRAINT FK_USUARIO_FINAL
GO

ALTER TABLE ORDEN WITH CHECK ADD CONSTRAINT FK_TRANSPORTISTA FOREIGN KEY(CEDULA_CONDUCTOR)
REFERENCES USUARIO (CEDULA)
GO

ALTER TABLE ORDEN CHECK CONSTRAINT FK_TRANSPORTISTA
GO

ALTER TABLE ORDEN WITH CHECK ADD CONSTRAINT FK_COMERCIO_ORDEN FOREIGN KEY(CEDULA_COMERCIO) REFERENCES COMERCIO (CEDULA_JURIDICA)
GO

ALTER TABLE ORDEN CHECK CONSTRAINT FK_COMERCIO_ORDEN
GO

--DETALLES DE ORDEN
CREATE TABLE ORDEN_DETALLE(
	ID INT NOT NULL,
	ID_ORDEN INT NOT NULL,
	ID_PRODUCTO INT NOT NULL,
	NOMBRE_PRODUCTO VARCHAR(50) NOT NULL,
	PRECIO float NOT NULL,
	CANTIDAD INT NOT NULL,
	CALIFICACION INT NOT NULL,
	CONSTRAINT PK_ORDEN_DETALLE PRIMARY KEY CLUSTERED
	(
		ID ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON PRIMARY
	) ON PRIMARY
	GO

ALTER TABLE ORDEN_DETALLE WITH CHECK ADD CONSTRAINT FK_ORDEN FOREIGN KEY (ID_ORDEN)
REFERENCES ORDEN (ID)
GO

--EXCEPCIONES
CREATE TABLE EXCEPCION(
	ID INT NOT NULL PRIMARY KEY,
	MENSAJE VARCHAR(500) NOT NULL
	);

INSERT INTO EXCEPCION VALUES(0,'Error.');
INSERT INTO EXCEPCION VALUES(1,'Identificador no v�lido.');
INSERT INTO EXCEPCION VALUES(2,'El cliente debe tener 15 a�os para registrarse.');
INSERT INTO EXCEPCION VALUES(3,'El cliente debe tener 18 a�os para pedir bebidas alcoh�licas.');
INSERT INTO EXCEPCION VALUES(4,'Ya existe una entrada registrada con esa identifiaci�n.');
GO
	--RETRIEVE ALL
CREATE PROCEDURE RET_ALL_EXCEPCION_PR
AS
	SELECT ID, MENSAJE FROM EXCEPCION;
RETURN 0
GO

	--RETRIEVE
CREATE PROCEDURE RET_EXCEPCION_PR
	@ID INT
AS
	SELECT ID, MENSAJE FROM EXCEPCION WHERE ID=@ID;
RETURN 0
GO

--MONEDERO
CREATE TABLE MONEDERO(
	ID INT PRIMARY KEY,
	CEDULA_USUARIO VARCHAR(50) FOREIGN KEY REFERENCES USUARIO(CEDULA),
	SALDO float NOT NULL
	);
	GO

	--INSERT
CREATE PROCEDURE CRE_MONEDERO_PR
	@ID INT,
	@CEDULA_USUARIO VARCHAR(50)
AS
	INSERT INTO MONEDERO VALUES(@ID,@CEDULA_USUARIO,0);
GO

	--RETRIEVE BY USER ID
CREATE PROCEDURE RET_MONEDERO_PR
	@CEDULA_USUARIO VARCHAR(50)
AS
	SELECT ID, CEDULA_USUARIO, SALDO FROM MONEDERO WHERE CEDULA_USUARIO=@CEDULA_USUARIO;
GO

