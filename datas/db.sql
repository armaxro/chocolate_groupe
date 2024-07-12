-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 04 juil. 2024 à 07:17
-- Version du serveur : 8.0.31
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `choco`
--
DROP DATABASE IF EXISTS `choco`;
CREATE DATABASE IF NOT EXISTS `choco` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `choco`;

CREATE TABLE `user` (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(40) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  is_admin BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

CREATE TABLE `recipe` (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  membre VARCHAR(40) NOT NULL,
  name VARCHAR(40) NOT NULL,
  description TEXT NOT NULL,
  nb_people INT UNSIGNED NOT NULL,
  image_url VARCHAR(255),
  preparation_time INT UNSIGNED NOT NULL,
  cooking_time INT UNSIGNED NOT NULL,
  rest_time INT UNSIGNED NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE `sub_recipe` (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  recipe_id INT UNSIGNED NOT NULL,
  title VARCHAR(100) NOT NULL,
  image_url VARCHAR(255),
  preparation_time SMALLINT UNSIGNED NOT NULL,
  sub_recipe_number TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (recipe_id) REFERENCES recipe(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `instruction` (
  id INT UNSIGNED AUTO_INCREMENT,
  sub_recipe_id INT UNSIGNED NOT NULL,
  text_content TEXT NOT NULL,
  image_url VARCHAR(255),
  instruction_number TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (sub_recipe_id) REFERENCES sub_recipe(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `ingredient` (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  ingredient TINYTEXT NOT NULL,
  image_url VARCHAR(255),
  PRIMARY KEY (id)
);

CREATE TABLE `ingredient_unity` (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  unit TINYTEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE `ingredient_has_recipe` (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  recipe_id INT UNSIGNED NOT NULL,
  ingredient_id INT UNSIGNED NOT NULL,
  ingredient_unity_id INT UNSIGNED,
  quantity SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (recipe_id) REFERENCES recipe(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (ingredient_id) REFERENCES ingredient(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (ingredient_unity_id) REFERENCES ingredient_unity(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `comment` (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  recipe_id INT UNSIGNED NOT NULL,
  user_name VARCHAR(50) NOT NULL,
  subject VARCHAR(50) NOT NULL,
  comment TEXT NOT NULL,
  created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  stars TINYINT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (recipe_id) REFERENCES recipe(id) ON DELETE CASCADE ON UPDATE CASCADE,
  -- FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT CHK_Stars CHECK ( stars >= 1 AND stars <= 5 )
);

CREATE TABLE `category` (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  category TINYTEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE `recipe_has_category` (
  recipe_id INT UNSIGNED NOT NULL,
  category_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (recipe_id) REFERENCES recipe(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;