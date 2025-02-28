CREATE SCHEMA coaching;
USE coaching;

CREATE TABLE clientes (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    DNI_Cliente VARCHAR(100) UNIQUE,
    Nombre_Cliente VARCHAR(100) NOT NULL,
    Apellido_Cliente VARCHAR(100) NOT NULL,
    FechaNacimiento_Cliente DATE NOT NULL,
    
    NumTelefono_Cliente VARCHAR(15) NOT NULL,
    Correo_Cliente VARCHAR(100) NOT NULL,

    TipoVia_Cliente ENUM('C/', 'Paseo', 'Av.') NULL,
    NombreVia_Cliente VARCHAR(100) NULL,
    NumeroVia_Cliente INT NULL,

    Contrasena_Cliente VARCHAR(100) NOT NULL,

    Tipo ENUM('cliente','admin') NOT NULL
);

CREATE TABLE especialistas (
    ID_Especialista INT AUTO_INCREMENT PRIMARY KEY,
    DNI_Especialista VARCHAR(100) UNIQUE NOT NULL,
    Nombre_Especialista VARCHAR(100) NOT NULL,
    Apellido_Especialista VARCHAR(100) NOT NULL,
    FechaNacimiento_Especialista DATE NOT NULL,

    NumTelefono_Especialista VARCHAR(15) NOT NULL,
    Correo_Especialista VARCHAR(100) NOT NULL,

    TipoVia_Especialista ENUM('C/', 'Paseo', 'Av.') NOT NULL,
    NombreVia_Especialista VARCHAR(100) NOT NULL,
    NumeroVia_Especialista INT NOT NULL,

    CuentaBancaria_Especialista VARCHAR(100) NOT NULL, /*ENCRIPTAR*/

    Cuota_Especialista DECIMAL(5,2) NOT NULL,

    Contrasena_Especialista VARCHAR(100),

    Tipo ENUM('espe') NOT NULL
);

CREATE TABLE especialistas_especialidades (
    ID_Especialista_EspeEspe INT,
    ID_Especialidad_EspeEspe INT,
    
    PRIMARY KEY (ID_Especialista_EspeEspe, ID_Especialidad_EspeEspe)
);

CREATE TABLE citas (
    ID_Cita INT AUTO_INCREMENT PRIMARY KEY,

    Fecha_Cita DATE,
    Hora_Cita ENUM('8:00-9:00', '9:00-10:00', '10:00-11:00', '11:00-12:00',
                   '15:00-16:00', '16:00-17:00', '17:00-18:00', '18:00-19:00',
                   '19:00-20:00', '20:00-21:00'),
    
    Coste_Cita DECIMAL NOT NULL,

    ID_Especialista_Cita INT,
    ID_Cliente_Cita INT
);

CREATE TABLE especialidad (
    ID_Especialidad INT AUTO_INCREMENT PRIMARY KEY,
    Especialidad_Especialista ENUM('Coaching Empresarial', 'Coaching Personal', 'Coaching con Inteligencia Emocional',
                                   'Coaching Deportivo', 'Coaching Ontológico', 'Coaching Cognitivo',
                                   'Coaching PNL (Programación Neurolingüística)', 'Coaching Coercitivo')
);

CREATE TABLE pagos (
    ID_Pago INT AUTO_INCREMENT PRIMARY KEY,
    Fecha_Pago DATE NOT NULL,
    Cantidad_Pago INT NOT NULL,
    
    ID_Pago_Cliente INT
);

CREATE TABLE disponibilidad_especialista (
    ID_Dispo INT AUTO_INCREMENT PRIMARY KEY,
    Lunes BOOLEAN,
    Martes BOOLEAN,
    Miercoles BOOLEAN,
    Jueves BOOLEAN,
    Viernes BOOLEAN,
    Hora_Dispo ENUM('8:00-9:00', '9:00-10:00', '10:00-11:00', '11:00-12:00', 
                    '15:00-16:00', '16:00-17:00', '17:00-18:00', '18:00-19:00', 
                    '19:00-20:00', '20:00-21:00'),
    
    ID_Especialista_DispoEspe INT
);

/* RELACIONES */

ALTER TABLE especialistas_especialidades 
    ADD CONSTRAINT FK_ESPECIALISTA_ESPECIALIDAD_ESPECIALISTA 
    FOREIGN KEY (ID_Especialista_EspeEspe) REFERENCES especialistas (ID_Especialista) ON UPDATE CASCADE;

ALTER TABLE especialistas_especialidades 
    ADD CONSTRAINT FK_ESPECIALISTA_ESPECIALIDAD_ESPECIALIDAD 
    FOREIGN KEY (ID_Especialidad_EspeEspe) REFERENCES especialidad (ID_Especialidad) ON UPDATE CASCADE;

ALTER TABLE citas 
    ADD CONSTRAINT FK_CITAS_ESPECIALISTAS 
    FOREIGN KEY (ID_Especialista_Cita) REFERENCES especialistas (ID_Especialista) ON UPDATE CASCADE;

ALTER TABLE citas 
    ADD CONSTRAINT FK_CITAS_CLIENTES 
    FOREIGN KEY (ID_Cliente_Cita) REFERENCES clientes (ID_Cliente) ON UPDATE CASCADE;

ALTER TABLE pagos 
    ADD CONSTRAINT FK_PAGOS_CLIENTE 
    FOREIGN KEY (ID_Pago_Cliente) REFERENCES clientes (ID_Cliente) ON UPDATE CASCADE;

ALTER TABLE disponibilidad_especialista 
    ADD CONSTRAINT FK_DISPONIBILIDAD_ESPECIALISTA_ESPECIALISTAS 
    FOREIGN KEY (ID_Especialista_DispoEspe) REFERENCES especialistas (ID_Especialista) ON UPDATE CASCADE;
