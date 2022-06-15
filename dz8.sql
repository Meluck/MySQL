use vk;

-- Task 1
-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).

-- с фиксированным id

-- Без понятия, где и зачем здесь использовать JOIN: 
-- для запроса нужна всего одна таблица
SET @user_rand_idx := 1;
SELECT from_user_id, to_user_id, count(*) FROM messages 
WHERE to_user_id = @user_rand_idx 
GROUP BY from_user_id
ORDER BY count(*) DESC 
LIMIT 1


-- Task 2
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

		
SELECT count(*) 
FROM likes AS l 
	JOIN media AS m ON m.id = l.media_id
	JOIN profiles 	AS p ON p.user_id = m.user_id 
WHERE
	TIMESTAMPDIFF(YEAR, p.birthday, curdate()) < 10	

-- Task 3
-- Определить кто больше поставил лайков (всего): мужчины или женщины.
	
SELECT gender, count(*) FROM profiles AS p
JOIN likes AS l ON
l.user_id = p.user_id 
GROUP BY gender

