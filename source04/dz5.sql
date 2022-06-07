USE SHOP;

-- TASK 1
-- ПУСТЬ В ТАБЛИЦЕ USERS ПОЛЯ CREATED_AT И UPDATED_AT ОКАЗАЛИСЬ НЕЗАПОЛНЕННЫМИ. 
-- ЗАПОЛНИТЕ ИХ ТЕКУЩИМИ ДАТОЙ И ВРЕМЕНЕМ.
UPDATE USERS SET CREATED_AT = CURRENT_TIMESTAMP(), 
         UPDATED_AT = CURRENT_TIMESTAMP();

-- TASK 2
-- ТАБЛИЦА USERS БЫЛА НЕУДАЧНО СПРОЕКТИРОВАНА. 
-- ЗАПИСИ CREATED_AT И UPDATED_AT БЫЛИ ЗАДАНЫ ТИПОМ VARCHAR
-- И В НИХ ДОЛГОЕ ВРЕМЯ ПОМЕЩАЛИСЬ ЗНАЧЕНИЯ В ФОРМАТЕ "20.10.2017 8:10".
-- НЕОБХОДИМО ПРЕОБРАЗОВАТЬ ПОЛЯ К ТИПУ DATETIME, СОХРАНИВ ВВЕДЕНЫЕ РАНЕЕ ЗНАЧЕНИЯ.

ALTER TABLE USERS MODIFY CREATED_AT VARCHAR(255);
ALTER TABLE USERS MODIFY UPDATED_AT VARCHAR(255);

ALTER TABLE USERS MODIFY CREATED_AT DATETIME;
ALTER TABLE USERS MODIFY UPDATED_AT DATETIME;

-- TASK 3
-- В ТАБЛИЦЕ СКЛАДСКИХ ЗАПАСОВ STOREHOUSES_PRODUCTS В ПОЛЕ VALUE
-- МОГУТ ВСТРЕЧАТЬСЯ САМЫЕ РАЗНЫЕ ЦИФРЫ: 0, ЕСЛИ ТОВАР ЗАКОНЧИЛСЯ 
-- И ВЫШЕ НУЛЯ, ЕСЛИ НА СКЛАДЕ ИМЕЮТСЯ ЗАПАСЫ. 
-- НЕОБХОДИМО ОТСОРТИРОВАТЬ ЗАПИСИ ТАКИМ ОБРАЗОМ, 
-- ЧТОБЫ ОНИ ВЫВОДИЛИСЬ В ПОРЯДКЕ УВЕЛИЧЕНИЯ ЗНАЧЕНИЯ VALUE. 
-- ОДНАКО, НУЛЕВЫЕ ЗАПАСЫ ДОЛЖНЫ ВЫВОДИТЬСЯ В КОНЦЕ, 
-- ПОСЛЕ ВСЕХ ЗАПИСЕЙ.

INSERT INTO STOREHOUSES_PRODUCTS 
VALUES (1, 2, 1, 12, '2014-03-16 15:28:28','2022-03-16 15:28:28'),
	   (2, 3, 3, 32, '2016-05-16 13:10:08','2021-04-10 01:34:28'),
	   (3, 4, 4, 43, '2013-12-30 15:28:28','2020-03-16 15:28:28'),
	   (4, 2, 1, 0,  '2020-02-16 15:00:28','2020-03-16 15:28:28'),
	   (5, 2, 1, 0,  '2019-03-15 10:28:28','2021-03-16 15:28:28');

SELECT  VALUE FROM SHOP.STOREHOUSES_PRODUCTS
ORDER BY IF(VALUE=0, 1, 0);

-- TASK 4
-- (ПО ЖЕЛАНИЮ) ИЗ ТАБЛИЦЫ USERS НЕОБХОДИМО ИЗВЛЕЧЬ ПОЛЬЗОВАТЕЛЕЙ, 
-- РОДИВШИХСЯ В АВГУСТЕ И МАЕ. МЕСЯЦЫ ЗАДАНЫ В ВИДЕ СПИСКА АНГЛИЙСКИХ 
-- НАЗВАНИЙ ('MAY', 'AUGUST')

-- В ТАБЛИЦЕ ДР ЗАДАН ДАТОЙ, ПОЭТОМУ ДОБАВИМ СТОЛБЕЦ И ЗАПОЛНИМ 
-- ДАННЫМИ О МЕСЯЦЕ РОЖДЕНИЯ
ALTER TABLE USERS  
ADD BIRTHDAY VARCHAR(15);

UPDATE USERS SET BIRTHDAY = MONTHNAME(USERS.BIRTHDAY_AT);

-- ИЗВЛЕКАЕМ ПОЛЬЗОВАТЕЛЕЙ, РОДИВШИЗСЯ В АВГУСТЕ И МАЕ
SELECT * FROM  USERS
WHERE BIRTHDAY IN ('MAY', 'AUGUST');

-- TASK 5
-- (ПО ЖЕЛАНИЮ) ИЗ ТАБЛИЦЫ CATALOGS ИЗВЛЕКАЮТСЯ ЗАПИСИ 
-- ПРИ ПОМОЩИ ЗАПРОСА. SELECT * FROM CATALOGS WHERE ID IN (5, 1, 2); 
-- ОТСОРТИРУЙТЕ ЗАПИСИ В ПОРЯДКЕ, ЗАДАННОМ В СПИСКЕ IN.
SELECT * FROM CATALOGS WHERE ID IN (5, 1, 2)
ORDER BY FIELD(ID, 5, 1, 2) 

-- PART 2
-- TASK 1
-- ПОДСЧИТАЙТЕ СРЕДНИЙ ВОЗРАСТ ПОЛЬЗОВАТЕЛЕЙ В ТАБЛИЦЕ USERS
 
SELECT AVG(TIMESTAMPDIFF(YEAR, USERS.BIRTHDAY_AT , CURDATE())) FROM USERS

-- TASK 2
-- ПОДСЧИТАЙТЕ КОЛИЧЕСТВО ДНЕЙ РОЖДЕНИЯ, 
-- КОТОРЫЕ ПРИХОДЯТСЯ НА КАЖДЫЙ ИЗ ДНЕЙ НЕДЕЛИ. 
-- СЛЕДУЕТ УЧЕСТЬ, ЧТО НЕОБХОДИМЫ ДНИ НЕДЕЛИ ТЕКУЩЕГО ГОДА, 
-- А НЕ ГОДА РОЖДЕНИЯ.

-- SELECT TIMESTAMP((DAY, MONTH), BIRTHDAY_AT) FROM USERS
-- 
-- SELECT   COUNT(BIRTHDAY_AT), DAYNAME(BIRTHDAY_AT) AS DAY
-- FROM     USERS
-- GROUP BY DAY
-- 
-- SELECT YEAR(CURDATE())
-- 
-- SELECT DATE(CONCAT_WS('-', YEAR(CURDATE()) , MONTH(BIRTHDAY_AT), DAY(BIRTHDAY_AT))) FROM USERS AS NEW_DATES;


SELECT COUNT(*), 
	   DAYNAME(DATE(CONCAT_WS('-', YEAR(CURDATE()) , MONTH(BIRTHDAY_AT), DAY(BIRTHDAY_AT)))) 
AS MY_DAY
FROM USERS 
GROUP BY MY_DAY
ORDER BY MY_DAY


-- TASK 3
-- (ПО ЖЕЛАНИЮ) ПОДСЧИТАЙТЕ ПРОИЗВЕДЕНИЕ ЧИСЕЛ В СТОЛБЦЕ ТАБЛИЦЫ

SELECT EXP(SUM(LOG(PRICE))) FROM PRODUCTS
