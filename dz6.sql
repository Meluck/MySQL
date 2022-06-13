use vk;

-- Task 1
-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).


-- попытка со случайным id, но для текущего заполнения не наглядно: больше всего пишут себе
SET @user_rand_idx := (SELECT id FROM users ORDER BY RAND() LIMIT 1);
SELECT from_user_id, to_user_id, count(*) FROM messages 
WHERE to_user_id = @user_rand_idx 
GROUP BY from_user_id
ORDER BY count(*) DESC 
LIMIT 1

-- с фиксированным id
SET @user_rand_idx := 1;
SELECT from_user_id, to_user_id, count(*) FROM messages 
WHERE to_user_id = @user_rand_idx 
GROUP BY from_user_id
ORDER BY count(*) DESC 
LIMIT 1



SELECT * FROM messages 
WHERE to_user_id = 11 
ORDER BY from_user_id 


-- Task 2
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SELECT count(*)  FROM likes as like_id 
WHERE media_id  in (
	SELECT id FROM media 
	WHERE user_id in (
		SELECT user_id FROM profiles 
		WHERE TIMESTAMPDIFF(YEAR, birthday, curdate()) < 10))
		

-- Task 3
-- Определить кто больше поставил лайков (всего): мужчины или женщины.
	
SELECT gender, count(*) FROM profiles
WHERE user_id in (
			SELECT user_id  FROM likes as like_id 
			WHERE user_id in (SELECT user_id FROM profiles))
GROUP BY gender


