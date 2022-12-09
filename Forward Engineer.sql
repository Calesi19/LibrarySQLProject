-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `library` ;

-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `library` DEFAULT CHARACTER SET utf8 ;
USE `library` ;

-- -----------------------------------------------------
-- Table `library`.`publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`publisher` ;

CREATE TABLE IF NOT EXISTS `library`.`publisher` (
  `publisher_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`publisher_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`book` ;

CREATE TABLE IF NOT EXISTS `library`.`book` (
  `book_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `publisher_id` INT UNSIGNED NOT NULL,
  `rating` DECIMAL(2,1) NULL,
  `publish_date` DATE NULL,
  PRIMARY KEY (`book_id`, `publisher_id`),
  INDEX `fk_book_publisher1_idx` (`publisher_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_publisher1`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `library`.`publisher` (`publisher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`language` ;

CREATE TABLE IF NOT EXISTS `library`.`language` (
  `langugage_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `language` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`langugage_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`condition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`condition` ;

CREATE TABLE IF NOT EXISTS `library`.`condition` (
  `condition_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `condition` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`condition_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`format`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`format` ;

CREATE TABLE IF NOT EXISTS `library`.`format` (
  `format_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `format` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`format_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`state` ;

CREATE TABLE IF NOT EXISTS `library`.`state` (
  `state_abbrev` CHAR(2) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`state_abbrev`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`address` ;

CREATE TABLE IF NOT EXISTS `library`.`address` (
  `address_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address_line` VARCHAR(60) NOT NULL,
  `state_abbrev` CHAR(2) NOT NULL,
  `zip_code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_address_State1_idx` (`state_abbrev` ASC) VISIBLE,
  CONSTRAINT `fk_address_State1`
    FOREIGN KEY (`state_abbrev`)
    REFERENCES `library`.`state` (`state_abbrev`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`account` ;

CREATE TABLE IF NOT EXISTS `library`.`account` (
  `account_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address_id` INT UNSIGNED NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` CHAR(10) NULL,
  `password_hash` CHAR(64) NOT NULL,
  PRIMARY KEY (`account_id`, `address_id`),
  INDEX `fk_account_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_account_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `library`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`library`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`library` ;

CREATE TABLE IF NOT EXISTS `library`.`library` (
  `library_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`library_id`),
  INDEX `fk_library_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_library_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `library`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book_copy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`book_copy` ;

CREATE TABLE IF NOT EXISTS `library`.`book_copy` (
  `item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ISBN` CHAR(13) NULL,
  `book_id` INT UNSIGNED NOT NULL,
  `language_id` INT UNSIGNED NOT NULL,
  `condition_id` INT UNSIGNED NOT NULL,
  `format_id` INT UNSIGNED NOT NULL,
  `library_id` INT UNSIGNED NOT NULL,
  `account_id` INT UNSIGNED NULL,
  `turn_over` DATETIME NULL,
  PRIMARY KEY (`item_id`),
  INDEX `fk_bookCopy_book_idx` (`book_id` ASC) VISIBLE,
  INDEX `fk_bookCopy_language1_idx` (`language_id` ASC) VISIBLE,
  INDEX `fk_bookCopy_condition1_idx` (`condition_id` ASC) VISIBLE,
  INDEX `fk_bookCopy_format1_idx` (`format_id` ASC) VISIBLE,
  INDEX `fk_bookCopy_account1_idx` (`account_id` ASC) VISIBLE,
  INDEX `fk_bookCopy_library1_idx` (`library_id` ASC) VISIBLE,
  CONSTRAINT `fk_bookCopy_book`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookCopy_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `library`.`language` (`langugage_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookCopy_condition1`
    FOREIGN KEY (`condition_id`)
    REFERENCES `library`.`condition` (`condition_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookCopy_format1`
    FOREIGN KEY (`format_id`)
    REFERENCES `library`.`format` (`format_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookCopy_account1`
    FOREIGN KEY (`account_id`)
    REFERENCES `library`.`account` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookCopy_library1`
    FOREIGN KEY (`library_id`)
    REFERENCES `library`.`library` (`library_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`author` ;

CREATE TABLE IF NOT EXISTS `library`.`author` (
  `author_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`author_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`genre` ;

CREATE TABLE IF NOT EXISTS `library`.`genre` (
  `genre_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `genre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`series`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`series` ;

CREATE TABLE IF NOT EXISTS `library`.`series` (
  `series_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `series_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`series_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book_author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`book_author` ;

CREATE TABLE IF NOT EXISTS `library`.`book_author` (
  `book_id` INT UNSIGNED NOT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`book_id`, `author_id`),
  INDEX `fk_book_has_author_author1_idx` (`author_id` ASC) INVISIBLE,
  INDEX `fk_book_has_author_book1_idx` (`book_id` ASC) INVISIBLE,
  CONSTRAINT `fk_book_has_author_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`book` (`book_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_book_has_author_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `library`.`author` (`author_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book_series`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`book_series` ;

CREATE TABLE IF NOT EXISTS `library`.`book_series` (
  `book_id` INT UNSIGNED NOT NULL,
  `series_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`book_id`, `series_id`),
  INDEX `fk_book_has_series_series1_idx` (`series_id` ASC) VISIBLE,
  INDEX `fk_book_has_series_book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_has_series_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_series_series1`
    FOREIGN KEY (`series_id`)
    REFERENCES `library`.`series` (`series_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`book_genre` ;

CREATE TABLE IF NOT EXISTS `library`.`book_genre` (
  `book_id` INT UNSIGNED NOT NULL,
  `genre_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`book_id`, `genre_id`),
  INDEX `fk_book_has_genre_genre1_idx` (`genre_id` ASC) VISIBLE,
  INDEX `fk_book_has_genre_book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_has_genre_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_genre_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `library`.`genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`library_account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`library_account` ;

CREATE TABLE IF NOT EXISTS `library`.`library_account` (
  `library_library_id` INT UNSIGNED NOT NULL,
  `account_account_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`library_library_id`, `account_account_id`),
  INDEX `fk_account_has_library_library1_idx` (`library_library_id` ASC) VISIBLE,
  INDEX `fk_account_has_library_account1_idx` (`account_account_id` ASC) VISIBLE,
  CONSTRAINT `fk_account_has_library_account1`
    FOREIGN KEY (`account_account_id`)
    REFERENCES `library`.`account` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_account_has_library_library1`
    FOREIGN KEY (`library_library_id`)
    REFERENCES `library`.`library` (`library_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- Inserts

# state
INSERT INTO state(state_abbrev, name)
    VALUES
    ("ID", "Idaho"),
    ("UT", "Utah"),
    ("AZ", "Arizona"),
    ("TX", "Texas");

# address
INSERT INTO address(address_line, state_abbrev, zip_code)
VALUES
    ("77 2nd street", "AZ", "72954"),
    ("32 6th street", "TX", "25679"),
    ("78 44th avenue", "ID", "84567"),
    ("66 hawk lane", "UT", "22558");

# library
INSERT INTO library(address_id, name)
VALUES
    (1, "tall library"),
    (2, "wide library"),
    (3, "bad library"),
    (4, "good library");

# account
INSERT INTO account (address_id, first_name, last_name, email, password_hash, phone)
VALUES 
(1, 'Carlos', 'Lespin', 'carlos.lespin@gmail.com', 'FE8AC0266B55CEFB09EA420A87B324A284D4B18657589651E7E31A787FD78798', '7879889347'),
(2, 'Levi', 'Chudliegh', 'levi.chudliegh@icloud.com', '65E84BE33532FB784C48129675F9EFF3A682B27168C0EA744B2CF58EE02337C5', NULL),
(3, 'Aaron', 'Fox', 'aaron.fox@hotmail.com', '46FC2A92063E1AC1EED8AAD1423D8E7C05B6DFD9AC9BBD868DAE66233C7A9FF4', NULL),
(4, 'Ashley', 'DeMott', 'ashley.demott@yahoo.com', 'F609E0495D5B36AC68E6562DDDB87AFC409DECA902C549C8855A2EE0C37EFC5C', NULL);

# library_account
INSERT INTO library_account(library_library_id, account_account_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4);

# publisher
INSERT INTO publisher(name) VALUES
	("Another publisher"),
    ("The publisher"),
    ("Your publisher"),
    ("A publisher");

# author
INSERT INTO author(first_name, last_name) VALUES
	("Rodney", "Lantern"),
    ("Tim", "Wax"),
    ("Fred", "Sconce"),
    ("Brandon", "Candle");

# book
INSERT INTO book(title, publisher_id, rating, publish_date) 
VALUES 
("Tragic Events From Carlos' Life", 2, 4.5, '2002-06-15'),
("The Fellowship of the Ring' Life", 3, 4.8, '1954-07-26'),
("The Two Towers' Life", 3, 4.8, '1954-07-26'),
("The Return of the King", 3, 4.9, '1954-07-26'),
("Harry Potter and the Sorcerer's Stone Life", 1, 4.7, '1997-06-26'),
("Harry Potter and the Chamber of Secrets", 1, 4.6, '1998-07-02'),
("The Buddhist Bible", 2, 2.1, '1842-07-13'),
("The First Yearbook", 4, 0.4, '0001-12-31'),
("My diary", 1, 4.2, '2013-2-18'),
("YOUR diary", 3, 3.8, '2014-1-04');

# series
INSERT INTO series (series_name)
VALUES 
('Harry Potter'),
('The Hobbit'),
('Lord of the Rings');

# genre
INSERT INTO genre (genre)
VALUES 
('Horror'), #1
('Comedy'), #2
('Self-Help'), #3
('Cooking'), #4
('Educational'),#5
('Adventure'),#6
('Politics'),#7
('Fantasy'),#8
('Fiction'),#9
('Non-Ficiton'),#10
('Based-On-True-Story'),#11
('Historical'),#12
('Science'),#13
('Sci-Fi'),#14
('Medieval'),#15
('Poetry'),#16
('Drama'),#17
('Romance');#18

# language
INSERT INTO language (language)
VALUES 
('Spanish'),
('English'),
('Portuguese'),
('Dothraki'),
('Korean'),
('French'),
('Mandarin'),
('Canadian'),
('Klingon'),
('Japanese'),
('Dovahzul');

# format
INSERT INTO format (format)
VALUES
("Paperback"),
("Hardcover"),
("AudioBook"),
("AudioBook CD"),
("AudioBook Tape"),
("Golden Plates"),
("Scrolls");

# book_series
INSERT INTO book_series(book_id, series_id)
VALUES 
(2, 2),
(2, 3),
(3, 2),
(3, 3),
(4, 2),
(4, 3),
(5, 1),
(6, 1);

# book_genre
INSERT INTO book_genre(book_id, genre_id)
VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,10),
(1,11),
(1,12),
(1,16),
(1,17),
(1,18),
(2,6),
(2,8),
(3,6),
(3,8),
(4,6),
(4,8),
(5,6),
(5,8),
(6,6),
(6,8);
    
# condition
INSERT INTO library.condition(`condition`) VALUES
	("New"),
    ("Good"),
    ("Worn"),
    ("Destroyed");
    
# book_author
INSERT INTO book_author(book_id, author_id) VALUES
	(1, 3),
    (2, 2),
    (3, 2),
    (4, 2),
    (5, 1),
    (6, 1),
    (7, 4),
    (8, 4),
    (9, 4),
    (10, 4);

# book_copy
INSERT INTO book_copy(ISBN, book_id, language_id, condition_id, format_id, library_id) VALUES
	(1325479465132, 1, 1, 1, 1, 1),
    (1344682155223, 1, 2, 2, 1, 2),
    (8621485645586, 2, 3, 4, 1, 1),
    (1478566526632, 1, 1, 3, 1, 3);
    
    
INSERT INTO book_copy(ISBN, book_id, language_id, condition_id, format_id, library_id, account_id, turn_over) 
VALUES
(1325479465132, 1, 1, 1, 1, 1, 1, "2022-12-9"),
(1344682155223, 1, 2, 2, 1, 2, 2, "2003-04-15"),
(8621485645586, 2, 3, 4, 2, 1, 1, "2006-06-13"),
(1478566526632, 1, 1, 3, 2, 3, 1, "2001-07-15");