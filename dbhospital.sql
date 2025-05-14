-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dbhospital
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbhospital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbhospital` DEFAULT CHARACTER SET utf8 ;
USE `dbhospital` ;

-- -----------------------------------------------------
-- Table `dbhospital`.`Pessoas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbhospital`.`Pessoas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `idade` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbhospital`.`Ambulatorios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbhospital`.`Ambulatorios` (
  `nroa` INT NOT NULL AUTO_INCREMENT,
  `andar` INT NOT NULL,
  `capacidade` INT NOT NULL,
  PRIMARY KEY (`nroa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbhospital`.`Medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbhospital`.`Medicos` (
  `codm` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `idade` INT NOT NULL,
  `especialidade` VARCHAR(45) NOT NULL,
  `CPF` INT NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `nroa` INT NULL,
  PRIMARY KEY (`codm`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  INDEX `fk_Medicos_Ambulatorios1_idx` (`nroa` ASC) VISIBLE,
  CONSTRAINT `fk_Medicos_Ambulatorios1`
    FOREIGN KEY (`nroa`)
    REFERENCES `dbhospital`.`Ambulatorios` (`nroa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbhospital`.`Pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbhospital`.`Pacientes` (
  `codp` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `idade` INT NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `CPF` INT NOT NULL,
  `doenca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codp`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbhospital`.`Funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbhospital`.`Funcionarios` (
  `codf` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `idade` INT NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `salario` INT NOT NULL,
  `CPF` INT NOT NULL,
  PRIMARY KEY (`codf`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbhospital`.`Consultas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbhospital`.`Consultas` (
  `codm` INT NOT NULL,
  `codp` INT NOT NULL,
  `data` DATE NOT NULL,
  `hora` TIME NOT NULL,
  PRIMARY KEY (`codm`, `codp`, `data`, `hora`),
  INDEX `fk_Medicos_has_Pacientes_Pacientes1_idx` (`codp` ASC) VISIBLE,
  INDEX `fk_Medicos_has_Pacientes_Medicos_idx` (`codm` ASC) VISIBLE,
  CONSTRAINT `fk_Medicos_has_Pacientes_Medicos`
    FOREIGN KEY (`codm`)
    REFERENCES `dbhospital`.`Medicos` (`codm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medicos_has_Pacientes_Pacientes1`
    FOREIGN KEY (`codp`)
    REFERENCES `dbhospital`.`Pacientes` (`codp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
ALTER TABLE Funcionarios
MODIFY COLUMN CPF VARCHAR(11);

SELECT * FROM Ambulatorios;
INSERT INTO Ambulatorios (andar, capacidade) VALUES (1, 30), (1, 50), (2, 40), (2, 25), (2, 55);

SELECT * FROM Pacientes;
INSERT INTO Pacientes (nome, idade, cidade, CPF, doenca) VALUES ("Ana", 20, "Florianopolis", "20000200000", "gripe"); 
INSERT INTO Pacientes (nome, idade, cidade, CPF, doenca) VALUES ("Paulo", 24, "Palhoca", "20000220000", "fratura"); 
INSERT INTO Pacientes (nome, idade, cidade, CPF, doenca) VALUES ("Lucia", 30, "Biguacu", "22000220000", "tendinite"); 
INSERT INTO Pacientes (nome, idade, cidade, CPF, doenca) VALUES ("Carlos", 28, "Joinville", "11000110000", "sarampo"); 

SELECT * FROM Medicos;
INSERT INTO Medicos (nome, idade, especialidade, CPF, cidade, nroa) VALUES ("Joao", 40, "ortopedia", "10000100000", "Florianopolis", 1);
INSERT INTO Medicos (nome, idade, especialidade, CPF, cidade, nroa) VALUES ("Maria", 42, "traumatologia", "10000110000", "Blumenau", 2);
INSERT INTO Medicos (nome, idade, especialidade, CPF, cidade, nroa) VALUES ("Pedro", 51, "pediatria", "11000100000", "São José", 2);
INSERT INTO Medicos (nome, idade, especialidade, CPF, cidade) VALUES ("Carlos", 28, "ortopedia", "11000110000", "Joinville");
INSERT INTO Medicos (nome, idade, especialidade, CPF, cidade, nroa) VALUES ("Marcia", 33, "neurologia", "11000111000", "Biguacu", 3);

SELECT * FROM Funcionarios;
INSERT INTO Funcionarios (nome, idade, cidade, salario, CPF) VALUES ("Rita", 32, "São José", 1200, "20000100000"); 
INSERT INTO Funcionarios (nome, idade, cidade, salario, CPF) VALUES ("Vera", 55, "Palhoca", 1220, "30000110000"); 
INSERT INTO Funcionarios (nome, idade, cidade, salario, CPF) VALUES ("Caio", 45, "Florianopolis", 1100, "41000100000"); 
INSERT INTO Funcionarios (nome, idade, cidade, salario, CPF) VALUES ("Marcelo", 44, "Florianopolis", 1200, "51000110000"); 
INSERT INTO Funcionarios (nome, idade, cidade, salario, CPF) VALUES ("Paula", 33, "Florianopolis", 2500, "61000111000"); 

SELECT * FROM Consultas;
INSERT INTO Consultas (codm, codp, data, hora) VALUES (1, 1, '2020-10-12', '14:00');
INSERT INTO Consultas (codm, codp, data, hora) VALUES (1, 4, '2020-10-13', '10:00');
INSERT INTO Consultas (codm, codp, data, hora) VALUES (2, 1, '2020-10-13', '09:00');
INSERT INTO Consultas (codm, codp, data, hora) VALUES (2, 2, '2020-10-13', '11:00');
INSERT INTO Consultas (codm, codp, data, hora) VALUES (2, 3, '2020-10-14', '14:00');
INSERT INTO Consultas (codm, codp, data, hora) VALUES (2, 4, '2020-10-14', '17:00');
INSERT INTO Consultas (codm, codp, data, hora) VALUES (3, 1, '2020-10-19', '18:00');
INSERT INTO Consultas (codm, codp, data, hora) VALUES (3, 3, '2020-10-12', '10:00');
INSERT INTO Consultas (codm, codp, data, hora) VALUES (3, 4, '2020-10-19', '13:00');
INSERT INTO Consultas (codm, codp, data, hora) VALUES (4, 4, '2020-10-20', '13:00');
INSERT INTO Consultas (codm, codp, data, hora) VALUES (2, 4, '2020-10-22', '19:30');

UPDATE Pacientes SET cidade = 'Ilhota' WHERE codp = 2;
UPDATE Consultas SET data= '2020-11-04', hora= '12:00' WHERE codm= 1 AND codp= 4;
UPDATE Consultas SET hora= '14:30' WHERE codm= 3 AND codp= 4;
DELETE FROM Funcionarios WHERE codf= 4;
DELETE FROM Consultas WHERE hora > '19:00';
DELETE FROM Medicos WHERE cidade= 'Biguacu' OR cidade= 'Palhoca';

ALTER TABLE Ambulatorios MODIFY COLUMN andar NUMERIC(2);
ALTER TABLE Ambulatorios MODIFY COLUMN capacidade SMALLINT;
ALTER TABLE Medicos MODIFY COLUMN idade SMALLINT;
ALTER TABLE Medicos MODIFY COLUMN CPF NUMERIC(11);
ALTER TABLE Pacientes MODIFY COLUMN idade SMALLINT;
ALTER TABLE Pacientes MODIFY COLUMN CPF NUMERIC(11);
ALTER TABLE Funcionarios MODIFY COLUMN CPF NUMERIC(11);
ALTER TABLE Funcionarios MODIFY COLUMN idade SMALLINT;
ALTER TABLE Funcionarios MODIFY COLUMN salario NUMERIC(10);
ALTER TABLE Funcionarios ADD COLUMN cargo VARCHAR(40);
ALTER TABLE Funcionarios DROP COLUMN cargo;
CREATE INDEX idx_cidade ON Pacientes (cidade);
