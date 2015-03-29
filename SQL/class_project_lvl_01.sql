SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `class_project` ;
CREATE SCHEMA IF NOT EXISTS `class_project` DEFAULT CHARACTER SET latin1 ;
USE `class_project` ;

-- -----------------------------------------------------
-- Table `class_project`.`projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `class_project`.`projects` ;

CREATE TABLE IF NOT EXISTS `class_project`.`projects` (
  `pr_id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(50) NULL DEFAULT NULL,
  `description` VARCHAR(10000) NULL DEFAULT NULL,
  `file_01` VARCHAR(100) NULL DEFAULT NULL,
  `file_02` VARCHAR(100) NULL DEFAULT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pr_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 29
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `class_project`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `class_project`.`users` ;

CREATE TABLE IF NOT EXISTS `class_project`.`users` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(25) NULL DEFAULT NULL,
  `last_name` VARCHAR(50) NULL DEFAULT NULL,
  `user_name` VARCHAR(100) NULL DEFAULT NULL,
  `pass_key` VARCHAR(40) NULL DEFAULT NULL,
  `authority` ENUM('Admin User','Standard User','Instructor') NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `class_project`.`notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `class_project`.`notes` ;

CREATE TABLE IF NOT EXISTS `class_project`.`notes` (
  `notes_id` INT(11) NOT NULL AUTO_INCREMENT,
  `project` INT(11) NULL DEFAULT NULL,
  `member` INT(11) NULL DEFAULT NULL,
  `message` VARCHAR(140) NULL DEFAULT NULL,
  `tags` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`notes_id`),
  INDEX `project` (`project` ASC),
  INDEX `member` (`member` ASC),
  CONSTRAINT `notes_ibfk_1`
    FOREIGN KEY (`project`)
    REFERENCES `class_project`.`projects` (`pr_id`),
  CONSTRAINT `notes_ibfk_2`
    FOREIGN KEY (`member`)
    REFERENCES `class_project`.`users` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `class_project`.`team_project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `class_project`.`team_project` ;

CREATE TABLE IF NOT EXISTS `class_project`.`team_project` (
  `tp_id` INT(11) NOT NULL AUTO_INCREMENT,
  `member` INT(11) NOT NULL,
  `project` INT(11) NOT NULL,
  `clearance` ENUM('owner','regular','Instructor') NOT NULL DEFAULT 'regular',
  PRIMARY KEY (`tp_id`),
  INDEX `member` (`member` ASC),
  INDEX `team_project_ibfk_2_idx` (`project` ASC),
  CONSTRAINT `team_project_ibfk_1`
    FOREIGN KEY (`member`)
    REFERENCES `class_project`.`users` (`user_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `team_project_ibfk_2`
    FOREIGN KEY (`project`)
    REFERENCES `class_project`.`projects` (`pr_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 40;


-- -----------------------------------------------------
-- Table `class_project`.`tasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `class_project`.`tasks` ;

CREATE TABLE IF NOT EXISTS `class_project`.`tasks` (
  `t_id` INT(11) NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(1000) NULL DEFAULT NULL,
  `deadline_day` DATE NULL DEFAULT NULL,
  `deadline_time` TIME NULL DEFAULT NULL,
  `assignee` INT(11) NULL DEFAULT NULL,
  `project` INT(11) NULL DEFAULT NULL,
  `time_assigned` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`t_id`),
  INDEX `assignee` (`assignee` ASC),
  INDEX `project` (`project` ASC),
  CONSTRAINT `tasks_ibfk_1`
    FOREIGN KEY (`assignee`)
    REFERENCES `class_project`.`users` (`user_id`),
  CONSTRAINT `tasks_ibfk_2`
    FOREIGN KEY (`project`)
    REFERENCES `class_project`.`team_project` (`tp_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
