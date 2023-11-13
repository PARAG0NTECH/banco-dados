-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cineguardian
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cineguardian
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cineguardian` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `cineguardian` ;

-- -----------------------------------------------------
-- Table `cineguardian`.`tb_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cineguardian`.`tb_address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cep` VARCHAR(255) NULL DEFAULT NULL,
  `neighborhood` VARCHAR(255) NULL DEFAULT NULL,
  `number` VARCHAR(255) NULL DEFAULT NULL,
  `street` VARCHAR(255) NULL DEFAULT NULL,
  `compl` VARCHAR(255) NULL DEFAULT NULL,
  `city` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cineguardian`.`tb_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cineguardian`.`tb_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `type_user` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cineguardian`.`tb_companies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cineguardian`.`tb_companies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_address` INT NULL DEFAULT NULL,
  `tb_users_id` INT NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `cnpj` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_address` (`id_address` ASC) ,
  INDEX `fk_tb_companies_tb_users1_idx` (`tb_users_id` ASC) ,
  CONSTRAINT `tb_companies_ibfk_1`
    FOREIGN KEY (`id_address`)
    REFERENCES `cineguardian`.`tb_address` (`id`),
  CONSTRAINT `fk_tb_companies_tb_users1`
    FOREIGN KEY (`tb_users_id`)
    REFERENCES `cineguardian`.`tb_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cineguardian`.`tb_cpu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cineguardian`.`tb_cpu` (
  `id` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cineguardian`.`tb_disk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cineguardian`.`tb_disk` (
  `id` VARCHAR(255) NOT NULL,
  `model` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cineguardian`.`tb_computers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cineguardian`.`tb_computers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tb_companies_id` INT NOT NULL,
  `id_cpu` VARCHAR(255) NULL DEFAULT NULL,
  `id_disk` VARCHAR(255) NULL DEFAULT NULL,
  `hostname` VARCHAR(255) NULL DEFAULT NULL,
  `maker` VARCHAR(255) NULL DEFAULT NULL,
  `system_info` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_cpu` (`id_cpu` ASC) ,
  INDEX `id_disk` (`id_disk` ASC) ,
  INDEX `fk_tb_computers_tb_companies1_idx` (`tb_companies_id` ASC) ,
  CONSTRAINT `tb_computers_ibfk_1`
    FOREIGN KEY (`id_cpu`)
    REFERENCES `cineguardian`.`tb_cpu` (`id`),
  CONSTRAINT `tb_computers_ibfk_2`
    FOREIGN KEY (`id_disk`)
    REFERENCES `cineguardian`.`tb_disk` (`id`),
  CONSTRAINT `fk_tb_computers_tb_companies1`
    FOREIGN KEY (`tb_companies_id`)
    REFERENCES `cineguardian`.`tb_companies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cineguardian`.`tb_network`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cineguardian`.`tb_network` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_computer` INT NULL DEFAULT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `mac_address` VARCHAR(255) NULL DEFAULT NULL,
  `packages_received` INT NULL DEFAULT NULL,
  `packages_sent` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_computer` (`id_computer` ASC),
  CONSTRAINT `tb_network_ibfk_1`
    FOREIGN KEY (`id_computer`)
    REFERENCES `cineguardian`.`tb_computers` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cineguardian`.`tb_statistics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cineguardian`.`tb_statistics` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_computer` INT NULL DEFAULT NULL,
  `temperature` DOUBLE NULL DEFAULT NULL,
  `cpu_usage` DOUBLE NULL DEFAULT NULL,
  `ram_usage` DOUBLE NULL DEFAULT NULL,
  `ram_available` DOUBLE NULL DEFAULT NULL,
  `ram_total` DOUBLE NULL DEFAULT NULL,
  `disk_total` DOUBLE NULL DEFAULT NULL,
  `disk_usage` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_computer` (`id_computer` ASC) ,
  CONSTRAINT `tb_statistics_ibfk_1`
    FOREIGN KEY (`id_computer`)
    REFERENCES `cineguardian`.`tb_computers` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cineguardian`.`tb_alerts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cineguardian`.`tb_alerts` (
  `id` INT NOT NULL,
  `tb_companies_id` INT NOT NULL,
  `percentual_cpu` DOUBLE NULL,
  `percentual_disk` DOUBLE NULL,
  `percentual_ram` DOUBLE NULL,
  PRIMARY KEY (`id`, `tb_companies_id`),
  CONSTRAINT `fk_tb_alerts_tb_companies1`
    FOREIGN KEY (`tb_companies_id`)
    REFERENCES `cineguardian`.`tb_companies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
