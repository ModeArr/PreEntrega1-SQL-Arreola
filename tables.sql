DROP DATABASE IF EXISTS `ecommerce` ;
CREATE DATABASE IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8 ;
USE `ecommerce` ;

-- -----------------------------------------------------
-- Table `ecommerce`.`product_inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`product_inventory` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `quantity` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  `modified_at` DATETIME NULL,
  `deleted_at` DATETIME NULL);

-- -----------------------------------------------------
-- Table `ecommerce`.`discount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`discount` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(80) NOT NULL,
  `description` VARCHAR(120) NULL,
  `discount_percent` TINYINT UNSIGNED NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 0,
  `created_at` DATETIME NOT NULL,
  `modified_at` DATETIME NULL,
  `deleted_at` DATETIME NULL);

-- -----------------------------------------------------
-- Table `ecommerce`.`product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`product_category` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(80) NOT NULL,
  `description` VARCHAR(180) NULL,
  `created_at` DATETIME NOT NULL,
  `modified_at` DATETIME NULL,
  `deleted_at` DATETIME NULL);

-- -----------------------------------------------------
-- Table `ecommerce`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(300) NULL,
  `SKU` VARCHAR(50) NOT NULL,
  `category_id` INT NOT NULL,
  `inventory_id` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `discount_id` INT NOT NULL DEFAULT 0,
  `created_at` DATETIME NOT NULL,
  `modified_at` DATETIME NULL,
  `deleted_at` DATETIME NULL);

-- -----------------------------------------------------
-- Table `ecommerce`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`order_details` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `payment_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `modified_at` DATETIME NULL);

-- -----------------------------------------------------
-- Table `ecommerce`.`payment_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`payment_details` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `order_id` INT NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `provider` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `modified_at` DATETIME NULL);

-- -----------------------------------------------------
-- Table `ecommerce`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(40) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(85) NULL,
  `telephone` VARCHAR(15) NULL,
  `created_at` DATETIME NOT NULL,
  `modified_at` DATETIME NULL);

-- -----------------------------------------------------
-- Table `ecommerce`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`order_items` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `modified_at` DATETIME NULL);

-- -----------------------------------------------------
-- Table `ecommerce`.`user_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`user_address` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `address_line1` VARCHAR(60) NOT NULL,
  `address_line2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(10) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(15) NULL,
  `mobile` VARCHAR(15) NULL);

-- -----------------------------------------------------
-- Table `ecommerce`.`user_payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`user_payment` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `payment_type` VARCHAR(45) NOT NULL,
  `provider` VARCHAR(45) NOT NULL,
  `account_no` VARCHAR(20) NOT NULL,
  `expiry` CHAR(5) NOT NULL);

-- -----------------------------------------------------
-- Table `ecommerce`.`shopping_session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`shopping_session` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `modified_at` DATETIME NULL);

-- -----------------------------------------------------
-- Table `ecommerce`.`cart_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`cart_item` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `session_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  `modified_at` DATETIME NULL);

-- -----------------------------------------------------
-- Foreign Key Constraints
-- -----------------------------------------------------
ALTER TABLE `ecommerce`.`product`
  ADD CONSTRAINT `fk_product_inventory`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `ecommerce`.`product_inventory` (`id`),
  ADD CONSTRAINT `fk_product_discount`
    FOREIGN KEY (`discount_id`)
    REFERENCES `ecommerce`.`discount` (`id`),
  ADD CONSTRAINT `fk_product_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `ecommerce`.`product_category` (`id`);

ALTER TABLE `ecommerce`.`order_details`
  ADD CONSTRAINT `fk_order_payment`
    FOREIGN KEY (`payment_id`)
    REFERENCES `ecommerce`.`payment_details` (`id`),
  ADD CONSTRAINT `fk_order_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `ecommerce`.`user` (`id`);

ALTER TABLE `ecommerce`.`payment_details`
  ADD CONSTRAINT `fk_payment_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `ecommerce`.`order_details` (`id`);

ALTER TABLE `ecommerce`.`order_items`
  ADD CONSTRAINT `fk_order_items_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `ecommerce`.`product` (`id`),
  ADD CONSTRAINT `fk_order_items_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `ecommerce`.`order_details` (`id`);

ALTER TABLE `ecommerce`.`user_address`
  ADD CONSTRAINT `fk_user_address_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `ecommerce`.`user` (`id`);

ALTER TABLE `ecommerce`.`user_payment`
  ADD CONSTRAINT `fk_user_payment_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `ecommerce`.`user` (`id`);

ALTER TABLE `ecommerce`.`shopping_session`
  ADD CONSTRAINT `fk_shopping_session_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `ecommerce`.`user` (`id`);

ALTER TABLE `ecommerce`.`cart_item`
  ADD CONSTRAINT `fk_cart_item_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `ecommerce`.`product` (`id`),
  ADD CONSTRAINT `fk_cart_item_session`
    FOREIGN KEY (`session_id`)
    REFERENCES `ecommerce`.`shopping_session` (`id`);
