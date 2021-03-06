-- MySQL Script generated by MySQL Workbench
-- 2016年10月15日 星期六 15时15分59秒
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema happy_help
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema happy_help
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `happy_help` DEFAULT CHARACTER SET utf8 ;
USE `happy_help` ;

-- -----------------------------------------------------
-- Table `happy_help`.`hh_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `salt` VARCHAR(50) NOT NULL,
  `is_locked` TINYINT(1) NULL DEFAULT 0,
  `role_ids` VARCHAR(45) NULL,
  `organization` VARCHAR(45) NULL,
  `nickname` VARCHAR(45) NULL,
  `real_name` VARCHAR(45) NULL,
  `user_identify` VARCHAR(100) NULL,
  `area` VARCHAR(45) NULL,
  `current_area` VARCHAR(45) NULL,
  `is_admin` TINYINT(1) NULL DEFAULT 0,
  `is_new` TINYINT(1) NULL DEFAULT 1,
  `create_time` DATETIME NULL,
  `account` DOUBLE NULL,
  `contribute_score` DOUBLE NULL,
  `honer_score` DOUBLE NULL,
  `grade_total` VARCHAR(45) NULL,
  `grade_times` INT NULL,
  `withdraw_account` VARCHAR(100) NULL,
  `wirhdraw_accont_type` VARCHAR(45) NULL,
  `regId` VARCHAR(45) NULL,
  `alias` VARCHAR(45) NULL,
  `topic` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `resource_ids` VARCHAR(45) NULL,
  `is_available` INT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_resource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_resource` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `type` VARCHAR(45) NULL,
  `priority` VARCHAR(45) NULL,
  `parent_id` BIGINT(20) NULL,
  `parent_ids` VARCHAR(100) BINARY NULL,
  `permission` VARCHAR(100) NULL,
  `is_available` INT(1) NULL DEFAULT 0,
  `url` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_user_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_user_role` (
  `hh_user_id` INT NOT NULL,
  `hh_role_id` INT NOT NULL,
  PRIMARY KEY (`hh_user_id`, `hh_role_id`),
  INDEX `fk_hh_user_role_hh_role1_idx` (`hh_role_id` ASC),
  CONSTRAINT `fk_hh_user_role_hh_user`
    FOREIGN KEY (`hh_user_id`)
    REFERENCES `happy_help`.`hh_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hh_user_role_hh_role1`
    FOREIGN KEY (`hh_role_id`)
    REFERENCES `happy_help`.`hh_role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_role_resource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_role_resource` (
  `hh_role_id` INT NOT NULL,
  `hh_resource_id` INT NOT NULL,
  PRIMARY KEY (`hh_role_id`, `hh_resource_id`),
  INDEX `fk_hh_role_resource_hh_resource1_idx` (`hh_resource_id` ASC),
  CONSTRAINT `fk_hh_role_resource_hh_role1`
    FOREIGN KEY (`hh_role_id`)
    REFERENCES `happy_help`.`hh_role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hh_role_resource_hh_resource1`
    FOREIGN KEY (`hh_resource_id`)
    REFERENCES `happy_help`.`hh_resource` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_article` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `context` VARCHAR(45) NULL,
  `image_url` VARCHAR(450) NULL,
  `create_time` DATETIME NULL,
  `visit_click` VARCHAR(100) NULL,
  `is_checked` TINYINT(1) NULL DEFAULT 0,
  `is_deleted` TINYINT(1) NULL DEFAULT 0,
  `is_pass` VARCHAR(45) NULL,
  `hh_user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hh_article_hh_user1_idx` (`hh_user_id` ASC),
  CONSTRAINT `fk_hh_article_hh_user1`
    FOREIGN KEY (`hh_user_id`)
    REFERENCES `happy_help`.`hh_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_user_click`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_user_click` (
  `id` INT NOT NULL,
  `user_id` VARCHAR(45) NULL,
  `hh_article_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hh_user_click_hh_article1_idx` (`hh_article_id` ASC),
  CONSTRAINT `fk_hh_user_click_hh_article1`
    FOREIGN KEY (`hh_article_id`)
    REFERENCES `happy_help`.`hh_article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_comment` (
  `id` INT NOT NULL,
  `context` VARCHAR(1000) NULL,
  `image_url` VARCHAR(300) NULL,
  `user_name` VARCHAR(45) NULL,
  `nick_name` VARCHAR(45) NULL,
  `create_time` DATETIME NULL,
  `is_deleted` TINYINT(1) NULL DEFAULT 0,
  `type` VARCHAR(45) NULL,
  `type_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_prize`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_prize` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `prize_num` VARCHAR(45) NULL,
  `prize_money` DOUBLE NULL,
  `user_names` VARCHAR(45) NULL,
  `create_time` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_area_range`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_area_range` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `area_range` VARCHAR(100) NULL,
  `money` DOUBLE NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_task_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_task_info` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NULL,
  `context` VARCHAR(500) NULL,
  `image_url` VARCHAR(300) NULL,
  `money` DOUBLE NULL,
  `phone` VARCHAR(50) NULL,
  `create_time` DATETIME NULL,
  `end_time` VARCHAR(45) NULL,
  `is_free` TINYINT(1) NULL DEFAULT 1,
  `is_accept` TINYINT(1) NULL DEFAULT 0,
  `is_top` TINYINT(1) NULL DEFAULT 0,
  `is_compeleted` TINYINT(1) NULL DEFAULT 0,
  `is_deleted` TINYINT(1) NULL DEFAULT 0,
  `area` VARCHAR(45) NULL,
  `hh_category_id` INT NOT NULL,
  `hh_user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hh_message_hh_category1_idx` (`hh_category_id` ASC),
  INDEX `fk_hh_message_hh_user1_idx` (`hh_user_id` ASC),
  CONSTRAINT `fk_hh_message_hh_category1`
    FOREIGN KEY (`hh_category_id`)
    REFERENCES `happy_help`.`hh_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hh_message_hh_user1`
    FOREIGN KEY (`hh_user_id`)
    REFERENCES `happy_help`.`hh_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_help_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_help_info` (
  `id` INT NOT NULL,
  `title` VARCHAR(50) NULL,
  `context` VARCHAR(500) NULL,
  `image_url` VARCHAR(300) NULL,
  `phome` VARCHAR(50) NULL,
  `publish_area` VARCHAR(100) NULL,
  `area_range` VARCHAR(50) NULL,
  `hh_area_range_id` INT NOT NULL,
  `hh_user_id` INT NOT NULL,
  `need_user_number` INT NULL,
  `apply_user_ids` VARCHAR(100) NULL,
  `use_user_ids` VARCHAR(100) NULL,
  `compeleted_user_ids` VARCHAR(45) NULL,
  `is_compeleted` TINYINT(1) NULL DEFAULT 0,
  `is_deleted` TINYINT(1) NULL DEFAULT 0,
  `hh_category_id` INT NOT NULL,
  `republish_times` INT NULL DEFAULT 3,
  PRIMARY KEY (`id`),
  INDEX `fk_hh_help_info_hh_area_range1_idx` (`hh_area_range_id` ASC),
  INDEX `fk_hh_help_info_hh_user1_idx` (`hh_user_id` ASC),
  INDEX `fk_hh_help_info_hh_category1_idx` (`hh_category_id` ASC),
  CONSTRAINT `fk_hh_help_info_hh_area_range1`
    FOREIGN KEY (`hh_area_range_id`)
    REFERENCES `happy_help`.`hh_area_range` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hh_help_info_hh_user1`
    FOREIGN KEY (`hh_user_id`)
    REFERENCES `happy_help`.`hh_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hh_help_info_hh_category1`
    FOREIGN KEY (`hh_category_id`)
    REFERENCES `happy_help`.`hh_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_judge_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_judge_record` (
  `id` INT NOT NULL,
  `help_info_id` VARCHAR(45) NULL,
  `require_user_id` VARCHAR(45) NULL,
  `server_user_id` VARCHAR(100) NULL,
  `score` DOUBLE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_server_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_server_info` (
  `id` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `context` VARCHAR(500) NULL,
  `phone` VARCHAR(45) NULL,
  `address` VARCHAR(200) NULL,
  `area` VARCHAR(45) NULL,
  `create_time` DATETIME NULL,
  `hh_user_id` INT NOT NULL,
  `is_pass` TINYINT(1) NULL DEFAULT 0,
  `is_deleted` TINYINT(1) NULL DEFAULT 0,
  `hh_category_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hh_suport_server_info_hh_user1_idx` (`hh_user_id` ASC),
  INDEX `fk_hh_server_info_hh_category1_idx` (`hh_category_id` ASC),
  CONSTRAINT `fk_hh_suport_server_info_hh_user1`
    FOREIGN KEY (`hh_user_id`)
    REFERENCES `happy_help`.`hh_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hh_server_info_hh_category1`
    FOREIGN KEY (`hh_category_id`)
    REFERENCES `happy_help`.`hh_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_show`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_show` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `image_url` VARCHAR(300) NULL,
  `create_time` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_message` (
  `id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `title` VARCHAR(45) NULL,
  `message` VARCHAR(45) NULL,
  `callback_regid` VARCHAR(45) NULL,
  `callback_alias` VARCHAR(45) NULL,
  `callback_topic` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_task_comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_task_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `context` VARCHAR(45) NULL,
  `hh_task_info_id` INT NOT NULL,
  `user_id` INT NULL,
  `user_nickname` VARCHAR(45) NULL,
  `create_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hh_talk_message_hh_task_info1_idx` (`hh_task_info_id` ASC),
  CONSTRAINT `fk_hh_talk_message_hh_task_info1`
    FOREIGN KEY (`hh_task_info_id`)
    REFERENCES `happy_help`.`hh_task_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_task_comment2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_task_comment2` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `parent_user_id` INT NULL,
  `child_user_id` INT NULL,
  `context` VARCHAR(45) NULL,
  `hh_task_info_id` VARCHAR(45) NULL,
  `hh_task_comment_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hh_task_comment2_hh_task_comment1_idx` (`hh_task_comment_id` ASC),
  CONSTRAINT `fk_hh_task_comment2_hh_task_comment1`
    FOREIGN KEY (`hh_task_comment_id`)
    REFERENCES `happy_help`.`hh_task_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_system_setting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_system_setting` (
  `id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `value` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_server_contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_server_contract` (
  `id` INT NOT NULL,
  `detail` VARCHAR(45) NULL,
  `status` INT NULL,
  `hh_server_info_id` INT NOT NULL,
  `hh_user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hh_server_contract_hh_server_info1_idx` (`hh_server_info_id` ASC),
  INDEX `fk_hh_server_contract_hh_user1_idx` (`hh_user_id` ASC),
  CONSTRAINT `fk_hh_server_contract_hh_server_info1`
    FOREIGN KEY (`hh_server_info_id`)
    REFERENCES `happy_help`.`hh_server_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hh_server_contract_hh_user1`
    FOREIGN KEY (`hh_user_id`)
    REFERENCES `happy_help`.`hh_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_help_contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_help_contract` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` INT NULL,
  `hh_user_id` INT NOT NULL,
  `hh_help_info_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hh_help_contract_hh_user1_idx` (`hh_user_id` ASC),
  INDEX `fk_hh_help_contract_hh_help_info1_idx` (`hh_help_info_id` ASC),
  CONSTRAINT `fk_hh_help_contract_hh_user1`
    FOREIGN KEY (`hh_user_id`)
    REFERENCES `happy_help`.`hh_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hh_help_contract_hh_help_info1`
    FOREIGN KEY (`hh_help_info_id`)
    REFERENCES `happy_help`.`hh_help_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `happy_help`.`hh_task_contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happy_help`.`hh_task_contract` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` INT NULL,
  `money` VARCHAR(45) NULL,
  `hh_task_info_id` INT NOT NULL,
  `talk_times` INT NULL,
  `hh_user_id` INT NOT NULL,
  `create_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hh_task_contract_hh_task_info1_idx` (`hh_task_info_id` ASC),
  INDEX `fk_hh_task_contract_hh_user1_idx` (`hh_user_id` ASC),
  CONSTRAINT `fk_hh_task_contract_hh_task_info1`
    FOREIGN KEY (`hh_task_info_id`)
    REFERENCES `happy_help`.`hh_task_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hh_task_contract_hh_user1`
    FOREIGN KEY (`hh_user_id`)
    REFERENCES `happy_help`.`hh_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
