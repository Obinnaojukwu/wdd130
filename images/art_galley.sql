SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema art_gallery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `art_galley` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `art_galley` ;

-- -----------------------------------------------------
-- Table `art_gallery`.`artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `art_gallery`.`artist` (
  `artist_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(20) NOT NULL,
  `mname` VARCHAR(20) NULL DEFAULT NULL,
  `lname` VARCHAR(25) NOT NULL,
  `dob` INT NOT NULL,
  `dod` INT NULL DEFAULT NULL,
  `country` VARCHAR(25) NOT NULL,
  `local_artist` ENUM('y', 'n') NULL DEFAULT NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `art_gallery`.`artwork`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `art_gallery`.`artwork` (
  `artwork_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(50) NOT NULL,
  `artyear` INT NOT NULL,
  `period` VARCHAR(25) NULL DEFAULT NULL,
  `arttype` VARCHAR(20) NULL DEFAULT NULL,
  `artfile` VARCHAR(25) NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`artwork_id`),
  INDEX `fk_artwork_artist1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_artwork_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `art_gallery`.`artist` (`artist_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `art_gallery`.`keyword`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `art_gallery`.`keyword` (
  `keyword_id` INT NOT NULL AUTO_INCREMENT,
  `keyword` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`keyword_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `art_gallery`.`artwork_has_keyword`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `art_gallery`.`artwork_has_keyword` (
  `artwork_id` INT NOT NULL,
  `keyword_id` INT NOT NULL,
  PRIMARY KEY (`artwork_id`, `keyword_id`),
  INDEX `fk_artwork_has_keyword_keyword1_idx` (`keyword_id` ASC) VISIBLE,
  INDEX `fk_artwork_has_keyword_artwork1_idx` (`artwork_id` ASC) VISIBLE,
  CONSTRAINT `fk_artwork_has_keyword_artwork1`
    FOREIGN KEY (`artwork_id`)
    REFERENCES `art_gallery`.`artwork` (`artwork_id`),
  CONSTRAINT `fk_artwork_has_keyword_keyword1`
    FOREIGN KEY (`keyword_id`)
    REFERENCES `art_gallery`.`keyword` (`keyword_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Insert data into artist
INSERT INTO artist VALUES
    (1, 'Vincent', NULL, 'van Gogh', 1853, 1890, 'France', DEFAULT),
    (2, 'Rembrandt', 'Harmenszoon', 'van Rijn', 1606, 1609, 'Netherland', DEFAULT),
    (3, 'Leonardo', NULL, 'da Vinci', 1452, 1519, 'Italy', DEFAULT),
    (4, 'Venture', 'Lonzo', 'Coy', 1965, NULL, 'United States', 'y'),
    (5, 'Deborah', NULL, 'Gill', 1970, NULL, 'United States', 'y'),
    (6, 'Claude', NULL, 'Monet', 1840, 1926, 'France', DEFAULT),
    (7, 'Pablo', NULL, 'Picasso', 1904, 1973, 'Spain', DEFAULT),
    (8, 'Michelangelo', 'di Lodovico', 'Simoni', 1475, 1564, 'Italy', DEFAULT);

-- Insert data into artwork
INSERT INTO artwork VALUES
    (1, 'Irises', 1889, 'Impressionism', 'Oil', 'irises.jpg', 1),
    (2, 'The Starry Night', 1889, 'Post-impressionism', 'Oil', 'starrynight.jpg', 1),
    (3, 'Sunflowers', 1888, 'Post-impressionism', 'Oil', 'sunflowers.jpg', 1),
    (4, 'Night Watch', 1642, 'Baroque', 'Oil', 'nightwatch.jpg', 2),
    (5, 'Storm on the Sea of Galilee', 1633, 'Dutch Golden Age', 'Oil', 'monalisa.jpg', 2),
    (6, 'Head of a Woman', 1508, 'High Renaissance', 'Oil', 'headwoman.jpg', 3),
    (7, 'Last Supper', 1498, 'Renaissance', 'Tempra', 'lastsupper.jpg', 3),
    (8, 'Mona Lisa', 1517, 'Renaissance', 'Oil', 'monalisa.jpg', 3),
    (9, 'Hillside Stream', 2005, 'Modern', 'Oil', 'hillside.jpg', 4),
    (10, 'Old Barn', 1992, 'Modern', 'Oil', 'oldbarn.jpg', 4),
    (11, 'Beach Baby', 1999, 'Modern', 'Watercolor', 'beachbaby.jpg', 5),
    (12, 'Women in the Garden', 1866, 'Impressionism', 'Oil', 'womengarden.jpg', 6),
    (13, 'Old Guitarist', 1904, 'Modern', 'Oil', 'guiltarist.jpg', 7);

-- Normalize the keyword table
TRUNCATE TABLE keyword;

INSERT INTO keyword VALUES
    (1, 'flowers'),
    (2, 'blue'),
    (3, 'landscape'),
    (4, 'girl'),
    (5, 'people'),
    (6, 'battle'),
    (7, 'boat'),
    (8, 'water'),
    (9, 'christ'),
    (10, 'food'),
    (11, 'baby');

-- Update the artwork_has_keyword table
TRUNCATE TABLE artwork_has_keyword;

INSERT INTO artwork_has_keyword (artwork_id, keyword_id) VALUES
    (1, 1),  -- Irises (flowers)
    (1, 2),  -- Irises (blue)
    (1, 3),  -- Irises (landscape)
    (2, 4),  -- The Starry Night (girl)
    (2, 5),  -- The Starry Night (people)
    (3, 1),  -- Sunflowers (flowers)
    (4, 6),  -- Night Watch (battle)
    (4, 5),  -- Night Watch (people)
    (5, 7),  -- Storm on the Sea of Galilee (boat)
    (5, 8),  -- Storm on the Sea of Galilee (water)
    (5, 9),  -- Storm on the Sea of Galilee (christ)
    (6, 4),  -- Head of a Woman (girl)
    (6, 5),  -- Head of a Woman (people)
    (7, 4),  -- Last Supper (girl)
    (7, 5),  -- Last Supper (people)
    (8, 4),  -- Mona Lisa (girl)
    (8, 5),  -- Mona Lisa (people)
    (9, 8),  -- Hillside Stream (water)
    (9, 3),  -- Hillside Stream (landscape)
    (10, 3), -- Old Barn (landscape)
    (11, 8), -- Beach Baby (water)
    (11, 5), -- Beach Baby (people)
    (11, 11),-- Beach Baby (baby)
    (12, 3), -- Women in the Garden (landscape)
    (12, 1), -- Women in the Garden (flowers)
    (12, 5), -- Women in the Garden (people)
    (13, 2), -- Old Guitarist (blue)
    (13, 5); -- Old Guitarist (people)

-- Select statements for verification
SELECT * FROM artist;
SELECT * FROM artwork;
SELECT * FROM artwork_has_keyword;
SELECT * FROM keyword;
