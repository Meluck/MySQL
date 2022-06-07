USE shop;

-- Task 1
-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
-- Заполните их текущими датой и временем.
UPDATE users SET created_at = current_timestamp(), 
         updated_at = current_timestamp();

-- Task 2
-- Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR
-- и в них долгое время помещались значения в формате "20.10.2017 8:10".
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

alter table users modify created_at VARCHAR(255);
alter table users modify updated_at VARCHAR(255);

alter table users modify created_at DATETIME;
alter table users modify updated_at DATETIME;

-- Task 3
-- В таблице складских запасов storehouses_products в поле value
-- могут встречаться самые разные цифры: 0, если товар закончился 
-- и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, 
-- чтобы они выводились в порядке увеличения значения value. 
-- Однако, нулевые запасы должны выводиться в конце, 
-- после всех записей.

insert into storehouses_products 
values (1, 2, 1, 12, '2014-03-16 15:28:28','2022-03-16 15:28:28'),
	   (2, 3, 3, 32, '2016-05-16 13:10:08','2021-04-10 01:34:28'),
	   (3, 4, 4, 43, '2013-12-30 15:28:28','2020-03-16 15:28:28'),
	   (4, 2, 1, 0,  '2020-02-16 15:00:28','2020-03-16 15:28:28'),
	   (5, 2, 1, 0,  '2019-03-15 10:28:28','2021-03-16 15:28:28');

select value from shop.storehouses_products
order by if(value=0, 1, 0);

-- Task 4
-- (по желанию) Из таблицы users необходимо извлечь пользователей, 
-- родившихся в августе и мае. Месяцы заданы в виде списка английских 
-- названий ('may', 'august')

-- В таблице др задан датой, поэтому добавим столбец и заполним 
-- данными о месяце рождения
ALTER TABLE users  
ADD birthday VARCHAR(15);

UPDATE users SET birthday = monthname(users.birthday_at);

-- Извлекаем пользователей, родившизся в августе и мае
select * from users
where birthday in ('may', 'august');

-- Task 5
-- (по желанию) Из таблицы catalogs извлекаются записи 
-- при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.
SELECT * FROM catalogs WHERE id IN (5, 1, 2)
order by field(id, 5, 1, 2) 

-- PART 2
-- Task 1
-- Подсчитайте средний возраст пользователей в таблице users
 
SELECT avg(TIMESTAMPDIFF(YEAR, users.birthday_at , CURDATE())) from users

-- Task 2
-- Подсчитайте количество дней рождения, 
-- которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, 
-- а не года рождения.


