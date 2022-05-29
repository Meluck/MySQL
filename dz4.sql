USE vk;


-- ii. Написать скрипт, возвращающий список имен (только firstname)
-- пользователей без повторений в алфавитном порядке
SELECT firstname FROM vk.users
ORDER BY firstname  

-- iii. Написать скрипт, отмечающий несовершеннолетних 
-- пользователей как неактивных (поле is_active = false). 
-- Предварительно добавить такое поле в таблицу profiles со 
-- значением по умолчанию = true (или 1)

-- SELECT * FROM profiles; 
-- 
-- ALTER TABLE profiles 
-- DROP COLUMN is_active;

ALTER TABLE profiles 
ADD is_active BOOL DEFAULT true;

UPDATE profiles SET is_active = false
WHERE profiles.user_id IN (  
SELECT id FROM vk.users
WHERE TIMESTAMPDIFF(YEAR, vk.users.birthday, CURDATE()) < 18);

-- iv. Написать скрипт, удаляющий сообщения 
-- «из будущего» (дата больше сегодняшней)

DELETE FROM vk.messages 
WHERE current_timestamp() < messages.created_at  





