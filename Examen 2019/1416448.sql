-- Integrantes:	Sanchez Lopez, Julio Mauricio
-- CX: 1416448
-- Nombre de la BD: 1416448
-- Plataforma: Ubuntu 16.04.1
-- Motor y Version: MySQL Community Server - GPL 5.7.26

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- Enunciado 1 - Definicion de los objetos

-- -----------------------------------------------------
-- Schema 1416448
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `1416448` ;

-- -----------------------------------------------------
-- Schema 1416448
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `1416448` DEFAULT CHARACTER SET utf8 ;
USE `1416448` ;

-- -----------------------------------------------------
-- Table `Puestos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Puestos` (
  `puesto` INT NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`puesto`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Puestos` (`nombre` ASC);


-- -----------------------------------------------------
-- Table `Niveles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Niveles` (
  `nivel` INT NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`nivel`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Niveles` (`nombre` ASC);


-- -----------------------------------------------------
-- Table `Categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Categorias` (
  `categoria` INT NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`categoria`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Categorias` (`nombre` ASC);


-- -----------------------------------------------------
-- Table `Conocimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Conocimientos` (
  `conocimiento` INT NOT NULL,
  `categoria` INT NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`conocimiento`),
  CONSTRAINT `fk_Conocimientos_Categorias`
    FOREIGN KEY (`categoria`)
    REFERENCES `Categorias` (`categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Conocimientos_Categorias_idx` ON `Conocimientos` (`categoria` ASC);

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Conocimientos` (`nombre` ASC);


-- -----------------------------------------------------
-- Table `Personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Personas` (
  `persona` INT NOT NULL,
  `nombres` VARCHAR(25) NOT NULL,
  `apellidos` VARCHAR(25) NOT NULL,
  `puesto` INT NOT NULL,
  `fechaIngreso` DATE NOT NULL,
  `fechaBaja` DATE NULL,
  PRIMARY KEY (`persona`),
  CONSTRAINT `fk_Personas_Puestos1`
    FOREIGN KEY (`puesto`)
    REFERENCES `Puestos` (`puesto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Personas_Puestos1_idx` ON `Personas` (`puesto` ASC);


-- -----------------------------------------------------
-- Table `Habilidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Habilidades` (
  `habilidad` INT NOT NULL,
  `persona` INT NOT NULL,
  `conocimiento` INT NOT NULL,
  `nivel` INT NOT NULL,
  `fechaUltimaModificacion` DATE NOT NULL,
  `observaciones` VARCHAR(200) NULL,
  PRIMARY KEY (`habilidad`),
  CONSTRAINT `fk_Habilidades_Personas1`
    FOREIGN KEY (`persona`)
    REFERENCES `Personas` (`persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Habilidades_Conocimientos1`
    FOREIGN KEY (`conocimiento`)
    REFERENCES `Conocimientos` (`conocimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Habilidades_Niveles1`
    FOREIGN KEY (`nivel`)
    REFERENCES `Niveles` (`nivel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Habilidades_Personas1_idx` ON `Habilidades` (`persona` ASC);

CREATE INDEX `fk_Habilidades_Conocimientos1_idx` ON `Habilidades` (`conocimiento` ASC);

CREATE INDEX `fk_Habilidades_Niveles1_idx` ON `Habilidades` (`nivel` ASC);

CREATE UNIQUE INDEX `persona_conocimiento_UNIQUE` ON `Habilidades` (`persona` ASC, `conocimiento` ASC);

-- Insercion de Datos provista por el Scrip LBD-Datos-2019.sql

INSERT INTO `Categorias` (`categoria`, `nombre`) VALUES (1, 'IDIOMA');
INSERT INTO `Categorias` (`categoria`, `nombre`) VALUES (2, '.NET');
INSERT INTO `Categorias` (`categoria`, `nombre`) VALUES (3, 'JAVA');
INSERT INTO `Categorias` (`categoria`, `nombre`) VALUES (4, 'SO');
INSERT INTO `Categorias` (`categoria`, `nombre`) VALUES (5, 'REDES');

INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (1, 1, 'INGLES ORAL');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (2, 1, 'INGLES ESCRITO');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (3, 1, 'FRANCES ORAL');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (4, 1, 'FRANCES ESCRITO');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (5, 2, 'MVC');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (6, 2, 'ASP.NET');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (7, 2, 'VB.NET');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (8, 2, 'C#.NET');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (9, 3, 'J2SE ');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (10, 3, 'Escritorio');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (11, 3, 'WEB');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (12, 3, 'Servicios');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (13, 4, 'W Server 2000');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (14, 4, 'W Server 2003');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (15, 4, 'W Server 2008');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (16, 4, 'Ubuntu');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (17, 4, 'Unix');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (18, 4, 'DOS');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (19, 5, 'Virtualización');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (20, 5, 'LAN');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (21, 5, 'WAN');

INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (0, 'Nivel de prueba');
INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (1, 'Nulo');
INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (2, 'Básico');
INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (3, 'Intermedio');
INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (4, 'Avanzado');
INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (5, 'Experto');

INSERT INTO `Puestos` (`puesto`, `nombre`) VALUES (1, 'Programador');
INSERT INTO `Puestos` (`puesto`, `nombre`) VALUES (2, 'Analista');
INSERT INTO `Puestos` (`puesto`, `nombre`) VALUES (3, 'Líder');

INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (1, 'Juan', 'Romano', 1, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (2, 'Pablo', 'García', 1, '2014/01/01', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (3, 'Miguel', 'Godoy', 1, '2014/01/01', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (4, 'Luis', 'Rolandi', 1, '2014/01/01', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (5, 'Maximiliano', 'Villafañez', 1, '2013/10/01', '2014/11/01');
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (6, 'Alejandro', 'Boixados', 1, '2013/10/01', '2014/10/10');
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (7, 'Cecilia', 'López', 1, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (8, 'Alba', 'Gómez', 1, '2013/10/01', '2014/11/01');
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (9, 'Soledad', 'Alderete', 1, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (10, 'Alfredo', 'López', 1, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (11, 'Romina', 'Torrez', 1, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (12, 'Juan', 'Giobellina', 1, '2009/08/08', '2014/10/10');
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (13, 'Sebastián', 'Gómez', 2, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (14, 'Martín', 'Gonzáles', 2, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (15, 'María Laura', 'Torres', 2, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (16, 'Jorge', 'Ibañez', 2, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (17, 'Ariel', 'Ceballos', 2, '2009/08/08', '2014/10/10');
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (18, 'Alfredo', 'Alcorta', 3, '2012/10/01', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (19, 'Miguel', 'Algañarás', 3, '2012/10/01', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (20, 'Antonio', 'Martínez', 3, '2012/10/01', null);

INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (1, 1, 1, 1, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (2, 1, 2, 1, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (3, 1, 3, 1, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (4, 1, 4, 1, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (5, 1, 5, 1, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (6, 1, 6, 2, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (7, 1, 7, 2, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (8, 1, 8, 2, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (9, 1, 9, 2, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (10, 2, 1, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (11, 2, 2, 3, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (12, 3, 1, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (13, 3, 2, 4, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (14, 4, 1, 4, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (15, 4, 2, 4, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (16, 4, 3, 5, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (17, 5, 1, 5, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (18, 5, 2, 4, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (19, 6, 1, 3, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (20, 6, 2, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (21, 7, 1, 2, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('22', 7, 2, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('23', 8, 1, 4, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('24', 9, 2, 5, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('25', 10, 1, 3, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('26', 10, 2, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('27', 10, 3, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('28', 10, 4, 4, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('29', 10, 5, 5, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('30', 10, 6, 3, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('31', 10, 7, 1, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('32', 10, 8, 1, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('33', 10, 9, 1, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('34', 10, 10, 2, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('35', 10, 11, 2, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('36', 11, 1, 2, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('37', 11, 2, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('38', 11, 3, 3, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('39', 11, 4, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('40', 11, 5, 4, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('41', 11, 6, 4, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('42', 11, 7, 5, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('43', 11, 8, 5, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('44', 11, 9, 4, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('45', 11, 10, 3, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('46', 11, 11, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('47', 11, 12, 2, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('48', 11, 13, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('49', 11, 14, 4, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('50', 11, 21, 5, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`, `observaciones`) VALUES ('51', 1, 13, 1, '2014/10/01', 'Con Certificacion');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`, `observaciones`) VALUES ('52', 10, 14, 1, '2013/08/12', 'Autodidacta');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`, `observaciones`) VALUES ('53', 11, 16, 4, '2014/10/01', 'Realizando formacion');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`, `observaciones`) VALUES ('54', 11, 17, 2, '2013/08/12', 'En uso actualmente');

-- Enunciado 2 - Vista VHabilidades

CREATE OR REPLACE VIEW VHabilidades AS
	SELECT Per.apellidos 'Apellidos', Per.nombres 'Nombres',
    Pue.nombre 'Puesto', C.nombre 'Conocimiento', N.nombre 'Nivel'
	FROM Puestos Pue JOIN Personas Per USING(puesto)
	JOIN Habilidades H USING(persona)
	JOIN Niveles N USING(nivel)
    JOIN Conocimientos C USING(conocimiento)
    ORDER BY Per.apellidos ASC, Per.nombres ASC, Pue.nombre ASC, C.nombre ASC, N.nombre ASC;

SELECT * FROM VHabilidades;

-- Enunciado 3 - Store Procedure NuevaPersona

DROP PROCEDURE IF EXISTS `NuevaPersona`;
DELIMITER $$
CREATE PROCEDURE `NuevaPersona`(pnombres VARCHAR(25), papellidos VARCHAR(25), ppuesto VARCHAR(25),
pfechaIngreso DATE, OUT Mensaje VARCHAR(100))
SALIR: BEGIN
	/**
    * Permite dar de alta una Persona controlando los parametros nulos y la existencia del puesto.
    * El indicador de la persona se calcula en base al mayor valor de indicador que encuentre en la tabla.
	* Devuelve OK o el mensaje de error en Mensaje.
    */
    DECLARE ppersona INT;
    DECLARE pidpuesto INT;
	-- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		-- SHOW ERRORS;
		SET Mensaje='Error en la transacción. Contáctese con el administrador.';
        ROLLBACK;
	END;
    -- Controla Parámetros Vacios
    IF (pnombres IS NULL OR pnombres = '') THEN
        SET Mensaje='Debe ingresar un valor para el campo Nombres.';
        LEAVE SALIR;
	END IF;
	IF (papellidos IS NULL OR papellidos = '') THEN
        SET Mensaje='Debe ingresar un valor para el campo Apellidos.';
        LEAVE SALIR;
	END IF;
	IF (ppuesto IS NULL OR ppuesto = '') THEN
        SET Mensaje='Debe ingresar un valor para el campo Puesto.';
        LEAVE SALIR;
	END IF;
    IF (pfechaIngreso IS NULL) THEN
        SET Mensaje='Debe ingresar un valor para el campo Fecha de Ingreso.';
        LEAVE SALIR;
	END IF;
	-- Control de Parámetros incorrectos
    IF NOT EXISTS (SELECT nombre FROM Puestos WHERE nombre=ppuesto) THEN
		SET Mensaje='Debe existir el puesto.';
		LEAVE SALIR;
    END IF;
    SET pidpuesto = (SELECT puesto FROM Puestos WHERE nombre=ppuesto);
    START TRANSACTION;
		SET ppersona = (SELECT COALESCE(MAX(persona), 0) + 1 FROM Personas);
        INSERT Personas VALUES(ppersona, pnombres, papellidos, pidpuesto, pfechaIngreso, NULL);
        SET Mensaje='OK';
	COMMIT;
END$$
DELIMITER ;

SELECT * FROM Personas;

CALL `NuevaPersona`('Julio Mauricio','Sanchez Lopez','Programador', DATE(NOW()), @Salida);
SELECT @Salida;

CALL `NuevaPersona`(NULL,'Sanchez Lopez','Programador', DATE(NOW()), @Salida); -- No se puede enviar nombres nulos
SELECT @Salida;

CALL `NuevaPersona`('','Sanchez Lopez','Programador', DATE(NOW()), @Salida); -- No se puede enviar nombres vacios
SELECT @Salida;

CALL `NuevaPersona`('Julio Mauricio',NULL,'Programador', DATE(NOW()), @Salida); -- No se puede enviar apellidos nulos
SELECT @Salida;

CALL `NuevaPersona`('Julio Mauricio','','Programador', DATE(NOW()), @Salida); -- No se puede enviar apellidos vacios
SELECT @Salida;

CALL `NuevaPersona`('Julio Mauricio','Sanchez Lopez',NULL, DATE(NOW()), @Salida); -- No se puede enviar un puesto nulo
SELECT @Salida;

CALL `NuevaPersona`('Julio Mauricio','Sanchez Lopez','', DATE(NOW()), @Salida); -- No se puede enviar un puesto vacio
SELECT @Salida;

CALL `NuevaPersona`('Julio Mauricio','Sanchez Lopez','Dios', DATE(NOW()), @Salida); -- No se puede enviar un puesto que no exista
SELECT @Salida;

CALL `NuevaPersona`('Julio Mauricio','Sanchez Lopez','Programador', NULL, @Salida); -- No se puede enviar una fecha de ingreso nula
SELECT @Salida;

SELECT * FROM Personas;

-- Enunciado 4 - Store Procedure PersonasConConocimiento

DROP PROCEDURE IF EXISTS `PersonasConConocimiento`;
DELIMITER $$
CREATE PROCEDURE `PersonasConConocimiento`(pcategoria INT, pconocimiento INT)
SALIR: BEGIN
	/**
    * Listar las cantidades de personas que existen, con el conocimiento
    * y categorias espeficiadas, y el nivel de los mismos.
    */
    -- Controla Parámetros Vacios
    IF (pcategoria IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Debe ingresar un valor para el campo Categoria.';
        LEAVE SALIR;
	END IF;
	IF (pconocimiento IS NULL) THEN
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Error: Debe ingresar un valor para el campo Conocimiento.';
        LEAVE SALIR;
	END IF;
    SELECT Cat.nombre 'Categoría', Con.nombre 'Conocimiento', N.nombre 'Nivel', COUNT(*) AS 'Personas'
	FROM Categorias Cat JOIN Conocimientos Con USING(categoria)
	JOIN Habilidades H USING(conocimiento)
	JOIN Niveles N USING(nivel)
    JOIN Personas P USING(persona)
    WHERE Cat.categoria=pcategoria AND Con.conocimiento=pconocimiento
    GROUP BY Cat.nombre, Con.nombre, N.nombre
    ORDER BY Cat.nombre ASC, Con.nombre ASC, N.nombre ASC;
END$$
DELIMITER ;

CALL `PersonasConConocimiento`(2,6);

CALL `PersonasConConocimiento`(2,8);

CALL `PersonasConConocimiento`(NULL,8); -- No se puede enviar un indicador categoria nulo

CALL `PersonasConConocimiento`(2,NULL);	-- No se puede enviar un indicador conocimineto nulo

-- Enunciado 5 - Triggers

DROP TRIGGER IF EXISTS `tg_borrado_nivel`;
DELIMITER $$
CREATE TRIGGER `tg_borrado_nivel` 
BEFORE DELETE ON `Niveles` FOR EACH ROW
BEGIN
	IF EXISTS(SELECT H.habilidad FROM Habilidades H JOIN Niveles N USING(nivel) WHERE nivel=OLD.nivel)THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puede borrar un nivel que tenga Habilidades asociadas';
    END IF;
END $$
DELIMITER ;

INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (6, 'Trigger Exito');
INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (7, 'Trigger Falla');

INSERT INTO `Habilidades` (`habilidad`,`persona`,`conocimiento`,`nivel`,`fechaUltimaModificacion`,`observaciones`) VALUES (55, 1, 17, 7, '2013/08/12', 'Prueba Trigger');

SELECT * FROM Niveles;
SELECT * FROM Habilidades;

DELETE FROM Niveles WHERE nivel=6; -- Exito
DELETE FROM Niveles WHERE nivel=7; -- Falla

SELECT * FROM Niveles;
SELECT * FROM Habilidades;

-- Final del Examen

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
