USE `ExamenLBD2018`;

-- Detalle Roles
DROP PROCEDURE IF EXISTS `DetalleRoles`;
DELIMITER $$
CREATE PROCEDURE `DetalleRoles`(pdesde DATE, phasta DATE)
SALIR: BEGIN
	/*
	Muestra: Año, DNI, Apellidos, Nombres, Tutor, Cotutor y Jurado, donde Tutor, Cotutor y Jurado muestran la
	cantidad de trabajos en los que un profesor participó en un trabajo con ese rol entre el rango de
	fechas especificado.
    El listado se mostrará ordenado por el año, apellidos, nombres y DNI
    (se pueden emplear vistas u otras estructuras para lograr la funcionalidad solicitada.
    Para obtener el año de una fecha se puede emplear la función YEAR())
	*/
    DECLARE Mensaje VARCHAR(100);
	-- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		-- SHOW ERRORS;
		SELECT 'Error en la transacción. Contáctese con el administrador.' Mensaje;
        ROLLBACK;
	END;
    -- Controla Parámetros Vacios
    IF (pdesde IS NULL) THEN
        SELECT 'Debe ingresar un valor para la fecha minima de busqueda.' Mensaje;
        LEAVE SALIR;
	END IF;
	IF (phasta IS NULL) THEN
        SELECT 'Debe ingresar un valor para la fecha limite de busqueda.' Mensaje;
        LEAVE SALIR;
	END IF;
	-- Control de Parámetros incorrectos
    IF (phasta < pdesde) THEN
        SELECT 'La fecha minima debe menor que la fecha limite.' Mensaje;
        LEAVE SALIR;
	END IF;
    -- Listado
    SELECT YEAR(R.desde) 'Año', Per.apellidos 'Apellidos', Per.nombres 'Nombres',
		count(IF(R.rol='Tutor',1,NULL)) 'Tutor', count(IF(R.rol='Cotutor',1,NULL)) 'Cotutor', count(IF(R.rol='Jurado',1,NULL)) 'Jurado'
	FROM RolesEnTrabajos R JOIN Profesores Pro USING(dni)
		JOIN Personas Per USING(dni)
		JOIN Cargos C USING(idCargo)
    WHERE R.desde BETWEEN pdesde AND phasta
    GROUP BY YEAR(R.desde), Per.apellidos, Per.nombres
	ORDER BY YEAR(R.desde) ASC, Per.apellidos ASC, Per.nombres ASC, Per.dni ASC;
END$$
DELIMITER ;

CALL `DetalleRoles`('2017-04-03','2018-05-24');

-- Nuevo Trabajo
DROP PROCEDURE IF EXISTS `NuevoTrabajo`;
DELIMITER $$
CREATE PROCEDURE `NuevoTrabajo`(ptitulo VARCHAR(100), pduracion INT, parea varchar(10), pfechaPresentacion DATE,
pfechaAprobacion DATE, pfechaFinalizacion DATE)
SALIR: BEGIN
	/*
	Permite que se agregue un trabajo nuevo. El procedimiento deberá efectuar las comprobaciones necesarias
    (incluyendo que la fecha de aprobación sea igual o mayor a la de presentación) y devolver los mensajes
	correspondientes (uno por cada condición de error, y otro por el éxito).
	*/
    DECLARE enum_aux ENUM('Hardware', 'Redes', 'Software');
    DECLARE pidTrabajo INT;
	-- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		-- SHOW ERRORS;
		SELECT 'Error en la transacción. Contáctese con el administrador.' Mensaje;
        ROLLBACK;
	END;
    -- Controla Parámetros Vacios
    IF (ptitulo IS NULL) THEN
        SELECT 'Debe ingresar un valor para el campo Titulo.' Mensaje;
        LEAVE SALIR;
	END IF;
	IF (parea IS NULL) THEN
        SELECT 'Debe ingresar un valor para el campo Area.' Mensaje;
        LEAVE SALIR;
	END IF;
    IF (pfechaPresentacion IS NULL) THEN
        SELECT 'Debe ingresar un valor para el campo Fecha de Presentacion.' Mensaje;
        LEAVE SALIR;
	END IF;
    IF (pfechaAprobacion IS NULL) THEN
        SELECT 'Debe ingresar un valor para el campo Fecha de Aprobacion.' Mensaje;
        LEAVE SALIR;
	END IF;
	-- Control de Parámetros incorrectos
    IF (pfechaAprobacion < pfechaPresentacion) THEN
        SELECT 'La Fecha de Presentacion debe menor que la Fecha de Aprobacion.' Mensaje;
        LEAVE SALIR;
	END IF;
    IF (parea != 'Redes' AND parea != 'Software' AND parea != 'Hardware') THEN
        SELECT 'El campo area debe pertenecer a la enumeracion correspondiente.' Mensaje;
        LEAVE SALIR;
	END IF;
    IF EXISTS(SELECT titulo FROM Trabajos WHERE titulo=ptitulo) THEN
		SELECT 'Ya existe un trabajo con este Titulo' Mensaje;
		LEAVE SALIR;
    END IF;
    IF (pduracion IS NULL) THEN
        SET pduracion = 6;
	END IF;
    START TRANSACTION;
		-- Da de alta calculando el próximo id
        SET pidTrabajo = (SELECT COALESCE(MAX(idTrabajo), 0) + 1 FROM Trabajos);
        INSERT Trabajos VALUES(pidTrabajo, ptitulo, pduracion, parea, pfechaPresentacion, pfechaAprobacion, pfechaFinalizacion);
        SELECT 'OK' Mensaje;
	COMMIT;
END$$
DELIMITER ;

CALL `NuevoTrabajo`('ExamenLBD2018+Plus+Ñato', null, 'Software', '2018-05-09', '2018-05-24', NULL);

SELECT * FROM Trabajos;

-- -----------------------------------------------------
-- Table `aud_Trabajos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `aud_Trabajos` ;

CREATE TABLE IF NOT EXISTS `aud_Trabajos` (
  `idAud` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fechaAud` DATETIME NOT NULL,
  `usuarioAud` varchar(30) NOT NULL,
  `hostNameAud` varchar(40) NOT NULL,
  `idTrabajo` INT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `duracion` INT NOT NULL DEFAULT 6,
  `area` ENUM('Hardware', 'Redes', 'Software') NOT NULL,
  `fechaPresentacion` DATE NOT NULL,
  `fechaAprobacion` DATE NOT NULL,
  `fechaFinalizacion` DATE NULL,
  PRIMARY KEY (`idAud`))
ENGINE = InnoDB;

-- Trigger insercion en vacas
DROP TRIGGER IF EXISTS `AuditarTrabajos`;
DELIMITER $$
CREATE TRIGGER `AuditarTrabajos` 
AFTER INSERT ON `Trabajos` FOR EACH ROW
BEGIN
	/*
    Audita cuando se agregue un trabajo con una	duración superior a los 12 meses, o inferior a 3 meses,
    registre en una tabla de auditoría los detalles del trabajo (todos los campos de la tabla Trabajos),
    el usuario que lo agregó y la fecha	en la que lo hizo.
    */
    IF (NEW.duracion > 12 OR NEW.duracion < 3) THEN
		INSERT INTO aud_Trabajos(fechaAud, usuarioAud, hostNameAud,
		idTrabajo, titulo, duracion, area, fechaPresentacion, fechaAprobacion, fechaFinalizacion)
		VALUES(NOW(), SUBSTRING_INDEX(USER(), '@', 1), SUBSTRING_INDEX(USER(), '@', -1),
		NEW.idTrabajo, NEW.titulo, NEW.duracion, NEW.area, NEW.fechaPresentacion, NEW.fechaAprobacion, NEW.fechaFinalizacion);
    END IF;
END $$
DELIMITER ;

CALL `NuevoTrabajo`('Ejemplo-Trigger', null, 'Software', '2018-05-09', '2018-05-24', NULL);

SELECT * FROM Trabajos;
SELECT * FROM aud_Trabajos;

CALL `NuevoTrabajo`('Ejemplo-Trigger+Plus', 14, 'Software', '2018-05-09', '2018-05-24', NULL);

SELECT * FROM Trabajos;
SELECT * FROM aud_Trabajos;

CALL `NuevoTrabajo`('Ejemplo-Trigger+Less', 2, 'Software', '2018-05-09', '2018-05-24', NULL);

SELECT * FROM Trabajos;
SELECT * FROM aud_Trabajos;
