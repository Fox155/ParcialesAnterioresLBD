-- -----------------------------------------------------
-- Schema LBD201903Tambo
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ExamenLBD2018` ;

-- -----------------------------------------------------
-- Schema LBD201903Tambo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ExamenLBD2018` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `ExamenLBD2018`;

-- -----------------------------------------------------
-- Table `Personas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Personas` ;

CREATE TABLE IF NOT EXISTS `Personas` (
  `dni` INT NOT NULL,
  `apellidos` VARCHAR(40) NOT NULL,
  `nombres` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Cargos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cargos` ;

CREATE TABLE IF NOT EXISTS `Cargos` (
  `idCargo` INT NOT NULL,
  `cargo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idCargo`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `ui_Cargos_cargo` ON `Cargos` (`cargo` ASC);

-- -----------------------------------------------------
-- Table `Trabajos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Trabajos` ;

CREATE TABLE IF NOT EXISTS `Trabajos` (
  `idTrabajo` INT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `duracion` INT NOT NULL DEFAULT 6,
  `area` ENUM('Hardware', 'Redes', 'Software') NOT NULL,
  `fechaPresentacion` DATE NOT NULL,
  `fechaAprobacion` DATE NOT NULL,
  `fechaFinalizacion` DATE NULL,
  PRIMARY KEY (`idTrabajo`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `ui_Trabajos_titulo` ON `Trabajos` (`titulo` ASC);

-- -----------------------------------------------------
-- Table `Profesores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Profesores` ;

CREATE TABLE IF NOT EXISTS `Profesores` (
  `dni` INT NOT NULL,
  `idCargo` INT NOT NULL,
  PRIMARY KEY (`dni`),
  CONSTRAINT `fk_Profesores_Personas1`
    FOREIGN KEY (`dni`)
    REFERENCES `Personas` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Profesores_Cargos1`
    FOREIGN KEY (`idCargo`)
    REFERENCES `Cargos` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Profesores_Personas1_idx` ON `Profesores` (`dni` ASC);

CREATE INDEX `fk_Profesores_Cargos1_idx` ON `Profesores` (`idCargo` ASC);

-- -----------------------------------------------------
-- Table `Alumnos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Alumnos` ;

CREATE TABLE IF NOT EXISTS `Alumnos` (
  `dni` INT NOT NULL,
  `cx` CHAR(7) NOT NULL,
  PRIMARY KEY (`dni`),
  CONSTRAINT `fk_Alumnos_Personas1`
    FOREIGN KEY (`dni`)
    REFERENCES `Personas` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Alumnos_Personas1_idx` ON `Alumnos` (`dni` ASC);

-- -----------------------------------------------------
-- Table `RolesEnTrabajos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RolesEnTrabajos` ;

CREATE TABLE IF NOT EXISTS `RolesEnTrabajos` (
  `idTrabajo` INT NOT NULL,
  `dni` INT NOT NULL,
  `rol` ENUM('Tutor', 'Cotutor', 'Jurado') NOT NULL,
  `desde` DATE NOT NULL,
  `hasta` DATE NULL,
  `razon` VARCHAR(100) NULL,
  PRIMARY KEY (`idTrabajo`,`dni`),
  CONSTRAINT `fk_RolesEnTrabajos_Trabajos1`
    FOREIGN KEY (`idTrabajo`)
    REFERENCES `Trabajos` (`idTrabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RolesEnTrabajos_Profesores1`
    FOREIGN KEY (`dni`)
    REFERENCES `Profesores` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_RolesEnTrabajos_Trabajos1_idx` ON `RolesEnTrabajos` (`idTrabajo` ASC);

CREATE INDEX `fk_RolesEnTrabajos_Profesores1_idx` ON `RolesEnTrabajos` (`dni` ASC);

-- -----------------------------------------------------
-- Table `AlumnosEnTrabajos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AlumnosEnTrabajos` ;

CREATE TABLE IF NOT EXISTS `AlumnosEnTrabajos` (
  `idTrabajo` INT NOT NULL,
  `dni` INT NOT NULL,
  `desde` DATE NOT NULL,
  `hasta` DATE NULL,
  `razon` VARCHAR(100) NULL,
  PRIMARY KEY (`idTrabajo`,`dni`),
  CONSTRAINT `fk_AlumnosEnTrabajos_Trabajos1`
    FOREIGN KEY (`idTrabajo`)
    REFERENCES `Trabajos` (`idTrabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AlumnosEnTrabajos_Alumnos1`
    FOREIGN KEY (`dni`)
    REFERENCES `Alumnos` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_AlumnosEnTrabajos_Trabajos1_idx` ON `AlumnosEnTrabajos` (`idTrabajo` ASC);

CREATE INDEX `fk_AlumnosEnTrabajos_Alumnos1_idx` ON `AlumnosEnTrabajos` (`dni` ASC);







