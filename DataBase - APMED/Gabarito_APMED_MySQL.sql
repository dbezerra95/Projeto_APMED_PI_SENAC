-- MySQL Script generated by MySQL Workbench
-- Tue Jun  8 21:33:36 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema APMED_MySQL
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema APMED_MySQL
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `APMED_MySQL` DEFAULT CHARACTER SET utf8 ;
USE `APMED_MySQL` ;

-- -----------------------------------------------------
-- Table `APMED_MySQL`.`hospital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APMED_MySQL`.`hospital` (
  `id_hosp` INT NOT NULL AUTO_INCREMENT,
  `cnpj_hosp` VARCHAR(25) NOT NULL,
  `raz_hosp` VARCHAR(150) NOT NULL,
  `cep_hosp` VARCHAR(15) NOT NULL,
  `end_hosp` VARCHAR(150) NOT NULL,
  `tel_hosp` VARCHAR(20) NULL,
  `email_hosp` VARCHAR(100) NULL,
  PRIMARY KEY (`id_hosp`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `APMED_MySQL`.`setor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APMED_MySQL`.`setor` (
  `id_setor` INT NOT NULL AUTO_INCREMENT,
  `espec_setor` VARCHAR(45) NOT NULL,
  `cat_setor` VARCHAR(45) NOT NULL,
  `cap_setor` INT NOT NULL,
  `hospital_id_hosp` INT NOT NULL,
  PRIMARY KEY (`id_setor`, `hospital_id_hosp`),
  INDEX `fk_setor_hospital_idx` (`hospital_id_hosp` ASC) VISIBLE,
  CONSTRAINT `fk_setor_hospital`
    FOREIGN KEY (`hospital_id_hosp`)
    REFERENCES `APMED_MySQL`.`hospital` (`id_hosp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `APMED_MySQL`.`medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APMED_MySQL`.`medico` (
  `id_med` INT NOT NULL AUTO_INCREMENT,
  `crm_med` VARCHAR(15) NOT NULL,
  `cpf_med` VARCHAR(20) NOT NULL,
  `nome_med` VARCHAR(150) NOT NULL,
  `nasc_med` DATE NOT NULL,
  `nac_med` VARCHAR(45) NOT NULL,
  `sexo_med` ENUM('M', 'F', 'O') NOT NULL,
  `end_med` VARCHAR(150) NOT NULL,
  `espec_med` VARCHAR(45) NOT NULL,
  `tel_med` VARCHAR(20) NULL,
  `email_med` VARCHAR(100) NULL,
  `setor_id_setor` INT NOT NULL,
  `setor_hospital_id_hosp` INT NOT NULL,
  PRIMARY KEY (`id_med`, `setor_id_setor`, `setor_hospital_id_hosp`),
  INDEX `fk_medico_setor1_idx` (`setor_id_setor` ASC, `setor_hospital_id_hosp` ASC) VISIBLE,
  CONSTRAINT `fk_medico_setor1`
    FOREIGN KEY (`setor_id_setor` , `setor_hospital_id_hosp`)
    REFERENCES `APMED_MySQL`.`setor` (`id_setor` , `hospital_id_hosp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `APMED_MySQL`.`documentacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APMED_MySQL`.`documentacao` (
  `id_doc` INT NOT NULL AUTO_INCREMENT,
  `tipo_doc` VARCHAR(50) NOT NULL,
  `desc_doc` VARCHAR(900) NOT NULL,
  `data_doc` DATE NOT NULL,
  `hora_doc` TIME NOT NULL,
  PRIMARY KEY (`id_doc`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `APMED_MySQL`.`convenio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APMED_MySQL`.`convenio` (
  `id_conv` INT NOT NULL AUTO_INCREMENT,
  `cnpj_conv` VARCHAR(25) NOT NULL,
  `raz_conv` VARCHAR(150) NOT NULL,
  `tel_conv` VARCHAR(20) NULL,
  `email_conv` VARCHAR(100) NULL,
  PRIMARY KEY (`id_conv`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `APMED_MySQL`.`paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APMED_MySQL`.`paciente` (
  `id_pac` INT NOT NULL AUTO_INCREMENT,
  `cpf_pac` VARCHAR(20) NOT NULL,
  `nome_pac` VARCHAR(150) NOT NULL,
  `nasc_pac` DATE NOT NULL,
  `nac_pac` VARCHAR(45) NOT NULL,
  `sexo_pac` ENUM('M', 'F', 'O') NOT NULL,
  `ocup_pac` VARCHAR(45) NOT NULL,
  `end_pac` VARCHAR(150) NOT NULL,
  `tel_pac` VARCHAR(20) NULL,
  `email_pac` VARCHAR(100) NULL,
  `setor_id_setor` INT NOT NULL,
  `setor_hospital_id_hosp` INT NOT NULL,
  `convenio_id_conv` INT NULL,
  PRIMARY KEY (`id_pac`, `setor_id_setor`, `setor_hospital_id_hosp`, `convenio_id_conv`),
  INDEX `fk_paciente_setor1_idx` (`setor_id_setor` ASC, `setor_hospital_id_hosp` ASC) VISIBLE,
  INDEX `fk_paciente_convenio1_idx` (`convenio_id_conv` ASC) VISIBLE,
  CONSTRAINT `fk_paciente_setor1`
    FOREIGN KEY (`setor_id_setor` , `setor_hospital_id_hosp`)
    REFERENCES `APMED_MySQL`.`setor` (`id_setor` , `hospital_id_hosp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_convenio1`
    FOREIGN KEY (`convenio_id_conv`)
    REFERENCES `APMED_MySQL`.`convenio` (`id_conv`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `APMED_MySQL`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APMED_MySQL`.`departamento` (
  `id_dep` INT NOT NULL AUTO_INCREMENT,
  `cat_dep` VARCHAR(45) NOT NULL,
  `cap_dep` INT NOT NULL,
  `ramal_dep` VARCHAR(20) NOT NULL,
  `hospital_id_hosp` INT NOT NULL,
  PRIMARY KEY (`id_dep`, `hospital_id_hosp`),
  INDEX `fk_departamento_hospital1_idx` (`hospital_id_hosp` ASC) VISIBLE,
  CONSTRAINT `fk_departamento_hospital1`
    FOREIGN KEY (`hospital_id_hosp`)
    REFERENCES `APMED_MySQL`.`hospital` (`id_hosp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `APMED_MySQL`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APMED_MySQL`.`funcionario` (
  `id_func` INT NOT NULL AUTO_INCREMENT,
  `corem_func` VARCHAR(20) NULL,
  `cpf_func` VARCHAR(20) NOT NULL,
  `nome_func` VARCHAR(150) NOT NULL,
  `nasc_func` DATE NOT NULL,
  `nac_func` VARCHAR(45) NOT NULL,
  `sexo_func` ENUM('M', 'F', 'O') NOT NULL,
  `cargo_func` VARCHAR(45) NOT NULL,
  `end_func` VARCHAR(150) NOT NULL,
  `tel_func` VARCHAR(20) NULL,
  `email_func` VARCHAR(100) NULL,
  `departamento_id_dep` INT NULL,
  `departamento_hospital_id_hosp` INT NULL,
  `setor_id_setor` INT NULL,
  `setor_hospital_id_hosp` INT NULL,
  PRIMARY KEY (`id_func`, `departamento_id_dep`, `departamento_hospital_id_hosp`, `setor_id_setor`, `setor_hospital_id_hosp`),
  INDEX `fk_funcionario_departamento1_idx` (`departamento_id_dep` ASC, `departamento_hospital_id_hosp` ASC) VISIBLE,
  INDEX `fk_funcionario_setor1_idx` (`setor_id_setor` ASC, `setor_hospital_id_hosp` ASC) VISIBLE,
  CONSTRAINT `fk_funcionario_departamento1`
    FOREIGN KEY (`departamento_id_dep` , `departamento_hospital_id_hosp`)
    REFERENCES `APMED_MySQL`.`departamento` (`id_dep` , `hospital_id_hosp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionario_setor1`
    FOREIGN KEY (`setor_id_setor` , `setor_hospital_id_hosp`)
    REFERENCES `APMED_MySQL`.`setor` (`id_setor` , `hospital_id_hosp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `APMED_MySQL`.`atendimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APMED_MySQL`.`atendimento` (
  `id_atend` INT NOT NULL AUTO_INCREMENT,
  `desc_atend` VARCHAR(900) NOT NULL,
  `data_atend` DATE NOT NULL,
  `hora_atend` TIME NOT NULL,
  `priori_atend` VARCHAR(45) NOT NULL,
  `paciente_id_pac` INT NOT NULL,
  `funcionario_id_func` INT NOT NULL,
  `funcionario_departamento_id_dep` INT NULL,
  `funcionario_departamento_hospital_id_hosp` INT NULL,
  PRIMARY KEY (`id_atend`, `paciente_id_pac`, `funcionario_id_func`, `funcionario_departamento_id_dep`, `funcionario_departamento_hospital_id_hosp`),
  INDEX `fk_consulta_paciente1_idx` (`paciente_id_pac` ASC) VISIBLE,
  INDEX `fk_atendimento_funcionario1_idx` (`funcionario_id_func` ASC, `funcionario_departamento_id_dep` ASC, `funcionario_departamento_hospital_id_hosp` ASC) VISIBLE,
  CONSTRAINT `fk_consulta_paciente1`
    FOREIGN KEY (`paciente_id_pac`)
    REFERENCES `APMED_MySQL`.`paciente` (`id_pac`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_atendimento_funcionario1`
    FOREIGN KEY (`funcionario_id_func` , `funcionario_departamento_id_dep` , `funcionario_departamento_hospital_id_hosp`)
    REFERENCES `APMED_MySQL`.`funcionario` (`id_func` , `departamento_id_dep` , `departamento_hospital_id_hosp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `APMED_MySQL`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APMED_MySQL`.`pagamento` (
  `id_pgto` INT NOT NULL AUTO_INCREMENT,
  `desc_pgto` VARCHAR(100) NOT NULL,
  `data_pgto` DATE NOT NULL,
  `hora_pgto` TIME NOT NULL,
  `preco_pgto` FLOAT NULL,
  `cred_pgto` TINYINT NULL,
  `deb_pgto` TINYINT NULL,
  `din_pgto` TINYINT NULL,
  `conv_pgto` TINYINT NULL,
  PRIMARY KEY (`id_pgto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `APMED_MySQL`.`consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APMED_MySQL`.`consulta` (
  `id_cons` INT NOT NULL AUTO_INCREMENT,
  `paciente_id_pac` INT NOT NULL,
  `medico_id_med` INT NOT NULL,
  `documentacao_id_doc` INT NOT NULL,
  `paciente_setor_id_setor` INT NOT NULL,
  `paciente_setor_hospital_id_hosp` INT NOT NULL,
  PRIMARY KEY (`id_cons`, `paciente_id_pac`, `medico_id_med`, `documentacao_id_doc`, `paciente_setor_id_setor`, `paciente_setor_hospital_id_hosp`),
  INDEX `fk_consulta_documentacao1_idx` (`documentacao_id_doc` ASC) VISIBLE,
  INDEX `fk_consulta_paciente2_idx` (`paciente_id_pac` ASC, `paciente_setor_id_setor` ASC, `paciente_setor_hospital_id_hosp` ASC) VISIBLE,
  INDEX `fk_consulta_medico1_idx` (`medico_id_med` ASC) VISIBLE,
  CONSTRAINT `fk_consulta_documentacao1`
    FOREIGN KEY (`documentacao_id_doc`)
    REFERENCES `APMED_MySQL`.`documentacao` (`id_doc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_paciente2`
    FOREIGN KEY (`paciente_id_pac` , `paciente_setor_id_setor` , `paciente_setor_hospital_id_hosp`)
    REFERENCES `APMED_MySQL`.`paciente` (`id_pac` , `setor_id_setor` , `setor_hospital_id_hosp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_medico1`
    FOREIGN KEY (`medico_id_med`)
    REFERENCES `APMED_MySQL`.`medico` (`id_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `APMED_MySQL`.`comprovante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `APMED_MySQL`.`comprovante` (
  `id_comp` INT NOT NULL AUTO_INCREMENT,
  `desc_comp` VARCHAR(100) NOT NULL,
  `data_comp` DATE NOT NULL,
  `hora_comp` TIME NOT NULL,
  `funcionario_id_func` INT NOT NULL,
  `pagamento_id_pgto` INT NOT NULL,
  `consulta_id_cons` INT NOT NULL,
  `paciente_convenio_id_conv` INT NULL,
  `consulta_paciente_id_pac` INT NOT NULL,
  `consulta_medico_id_med` INT NOT NULL,
  `consulta_paciente_setor_id_setor` INT NOT NULL,
  `consulta_paciente_setor_hospital_id_hosp` INT NOT NULL,
  PRIMARY KEY (`id_comp`, `funcionario_id_func`, `pagamento_id_pgto`, `consulta_id_cons`, `paciente_convenio_id_conv`, `consulta_paciente_id_pac`, `consulta_medico_id_med`, `consulta_paciente_setor_id_setor`, `consulta_paciente_setor_hospital_id_hosp`),
  INDEX `fk_comprovante_pagamento1_idx` (`pagamento_id_pgto` ASC) VISIBLE,
  INDEX `fk_comprovante_funcionario1_idx` (`funcionario_id_func` ASC) VISIBLE,
  INDEX `fk_comprovante_paciente1_idx` (`paciente_convenio_id_conv` ASC) VISIBLE,
  INDEX `fk_comprovante_consulta1_idx` (`consulta_id_cons` ASC, `consulta_paciente_id_pac` ASC, `consulta_paciente_setor_id_setor` ASC, `consulta_paciente_setor_hospital_id_hosp` ASC, `consulta_medico_id_med` ASC) VISIBLE,
  CONSTRAINT `fk_comprovante_pagamento1`
    FOREIGN KEY (`pagamento_id_pgto`)
    REFERENCES `APMED_MySQL`.`pagamento` (`id_pgto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comprovante_funcionario1`
    FOREIGN KEY (`funcionario_id_func`)
    REFERENCES `APMED_MySQL`.`funcionario` (`id_func`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comprovante_paciente1`
    FOREIGN KEY (`paciente_convenio_id_conv`)
    REFERENCES `APMED_MySQL`.`paciente` (`convenio_id_conv`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comprovante_consulta1`
    FOREIGN KEY (`consulta_id_cons` , `consulta_paciente_id_pac` , `consulta_paciente_setor_id_setor` , `consulta_paciente_setor_hospital_id_hosp` , `consulta_medico_id_med`)
    REFERENCES `APMED_MySQL`.`consulta` (`id_cons` , `paciente_id_pac` , `paciente_setor_id_setor` , `paciente_setor_hospital_id_hosp` , `medico_id_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;