-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema USERS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `USERS` DEFAULT CHARACTER SET latin1 ;
USE `USERS` ;

-- -----------------------------------------------------
-- Table `USERS`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `USERS`.`User` (
  `User_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Firstname` VARCHAR(50) NULL,
  `Lastname` VARCHAR(50) NULL,
  `Email` VARCHAR(50) NULL,
  `Password` VARCHAR(50) NULL,
  `Username` VARCHAR(50) NULL,
  PRIMARY KEY (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `USERS`.`Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `USERS`.`Role` (
  `Role_ID` INT NOT NULL AUTO_INCREMENT,
  `Rolename` VARCHAR(50) NULL,
  PRIMARY KEY (`Role_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `USERS`.`Permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `USERS`.`Permission` (
  `Permission_ID` INT NOT NULL AUTO_INCREMENT,
  `Permissionname` VARCHAR(50) NULL,
  PRIMARY KEY (`Permission_ID`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `USERS`.`UserRole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `USERS`.`UserRole` (
  `User_ID` INT(11) NOT NULL,
  `Role_ID` INT NOT NULL,
  PRIMARY KEY (`User_ID`, `Role_ID`),
 
    FOREIGN KEY (`User_ID`)
    REFERENCES `USERS`.`User` (`User_ID`),
  
    FOREIGN KEY (`Role_ID`)
    REFERENCES `USERS`.`Role` (`Role_ID`)
    )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `USERS`.`RolePermission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `USERS`.`RolePermission` (
  `Permission_ID` INT NOT NULL,
  `Role_ID` INT NOT NULL,
  PRIMARY KEY (`Permission_ID`, `Role_ID`),
 
    FOREIGN KEY (`Permission_ID`)
    REFERENCES `USERS`.`Permission` (`Permission_ID`)
    ,
  
    FOREIGN KEY (`Role_ID`)
    REFERENCES `USERS`.`Role` (`Role_ID`)
    )
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
