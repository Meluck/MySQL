USE shop

-- Task 1
-- Составьте список пользователей users, 
-- которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT name FROM users u 
WHERE id IN (SELECT user_id FROM orders)

SELECT * FROM orders


-- Task 2
-- Выведите список товаров products и разделов catalogs, 
-- который соответствует товару

SELECT products.name, catalogs.name FROM products JOIN catalogs 

-- Task 3
-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) 
-- и таблица городов cities (label, name). Поля from, to и label 
-- содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

CREATE DATABASE dz7;
USE dz7;

DROP TABLE IF EXISTS flights;

CREATE TABLE flights(
	`id`   SERIAL PRIMARY KEY,
	`from` VARCHAR(255),
	`to`   VARCHAR(255)
);

INSERT INTO flights (`id`, `from`, `to`) 
VALUES	(1, 'Moscow', 'Kostroma'),
		(2, 'Ekaterenburg', 'Galich'),
		(3, 'Yaroslavl', 'Moscow'),
		(4, 'Kostroma', 'Salehard'),
		(5, 'Salehard', 'Galich');
		
		

DROP TABLE IF EXISTS cities;

CREATE TABLE cities(
	`label` VARCHAR (255),
	`name`  VARCHAR (255)
);

INSERT INTO  cities (`label`, `name`) 
VALUES	('Moscow', 'Москва'),
		('Kostroma', 'Кострома'),
		('Ekaterenburg', 'Екатеренбург'),
		('Yaroslavl', 'Ярославь'),
		('Salehard', 'Салехард'),
		('Galich', 'Галич')

		
##############################################
SELECT * FROM (
SELECT flights.id, cities.`name`  FROM flights JOIN cities
ON 
	flights.`from` = cities.label) AS res1
JOIN (
SELECT flights.id, cities.`name`  FROM flights JOIN cities
ON 
	flights.`to` = cities.label) AS res2 
USING(id)
ORDER BY id

