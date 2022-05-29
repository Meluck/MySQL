DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(100),
	lastname VARCHAR(100),
	email VARCHAR(100) UNIQUE,
	phone BIGINT UNSIGNED UNIQUE,
	password_hash VARCHAR(256),
	
	INDEX idx_users_username(firstname, lastname)
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	gender CHAR(1),
	hometown VARCHAR(200),
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (user_id) REFERENCES users(id)
);

-- ALTER TABLE profiles ADD CONSTRAINT fk_profiles_user_id
-- FOREIGN KEY (user_id) REFERENCES users(id);
-- 
-- ALTER TABLE profiles ADD COLUMN birthday DATE;

DROP TABLE IF EXISTS messages;
CREATE TABLE messages(
	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_request;
CREATE TABLE friend_resquest(
	initiator_user_id BIGINT UNSIGNED NOT NULL,
	target_user_id BIGINT UNSIGNED NOT NULL,
	status ENUM('requested', 'approved', 'declined', 'unfriended'),
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
	PRIMARY KEY (initiator_user_id, target_user_id),
	FOREIGN KEY (initiator_user_id) REFERENCES users(id),
	FOREIGN KEY (target_user_id) REFERENCES users(id),
	CHECK (initiator_user_id != target_user_id)
);


DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL,
	name VARCHAR(255),
	admin_user_id BIGINT UNSIGNED NOT NULL,
	
	INDEX (name),
	FOREIGN KEY(admin_user_id) REFERENCES users(id)
);


DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY (user_id, community_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL,
	name VARCHAR(255),
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL,
	media_type_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	body VARCHAR(255),
-- 	file BLOB,
	filename VARCHAR(255),
	metadata  VARCHAR(255),

	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);


DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (media_id) REFERENCES media(id)
);

-- ALTER TABLE vk.likes 
-- ADD CONSTRAINT likes_fk 
-- FOREIGN KEY (media_id) REFERENCES vk.media(id);
-- 
-- ALTER TABLE vk.likes 
-- ADD CONSTRAINT likes_fk_1 
-- FOREIGN KEY (user_id) REFERENCES vk.users(id);


DROP TABLE IF EXISTS post;
CREATE TABLE post(
	id SERIAL,
	autor_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT now() ON UPDATE now(),
	
	FOREIGN KEY (autor_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS reposts;
CREATE TABLE reposts(
	id SERIAL,
	post_id BIGINT UNSIGNED NOT NULL,
	repost_autor_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT now() ON UPDATE now(),
	
	FOREIGN KEY (post_id) REFERENCES post(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (repost_autor_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS comments;
CREATE TABLE comments(
	id SERIAL,
	autor_id BIGINT UNSIGNED NOT NULL, 
	post_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT now(),
	updated_at DATETIME DEFAULT now() ON UPDATE now(),
-- 	PRIMARY KEY (autor_id, media_id) # может быть несколько комментов от одного автора
	
	FOREIGN KEY (autor_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (post_id) REFERENCES post(id) ON UPDATE CASCADE ON DELETE CASCADE
);


INSERT INTO `users` 
VALUES
(1,'Arnoldo','Bahringer','lexie.trantow@example.net',89771556229,'f789730841dfd848711efabf4b26296c5a8a3353'),
(2,'Efrain','Goyette','eo\'hara@example.com',89585679203,'a5399373304f30d3bee2bc430d7bc792b6ea9917'),
(3,'Emily','Mraz','isobel72@example.com',89769234336,'c42600ed3e3580a261541720feabefda18297e29'),
(4,'Claude','Corwin','epowlowski@example.net',89703017023,'5a482e2d94a3850f36127d50fbdcee842879855c'),
(5,'Kyra','Bartoletti','frida.kling@example.com',89273735147,'51e8e4ef47343e3c81a1003c99e3ccd356748461'),
(6,'Silas','Ratke','hammes.lori@example.net',89404990917,'2a2a914ba54c561419ca45721ae8dcf0a52dd236'),
(7,'Gerda','O\'Kon','alessia40@example.org',89380043562,'5971eb3ef4384361de71fcd0cc8b6afbe4f0ddac'),
(8,'Alverta','Klocko','xschaden@example.com',89134499002,'202f8ba25dc305fb40a357362c98365ab78930b8'),
(9,'Clementina','Mayer','hamill.isaias@example.com',89942529363,'b78eb259c7942b39fbce8be7c1632ccf1d7f01a2'),
(10,'Jabari','Bailey','colin73@example.com',89569786677,'fef56f9443f4f241557fc0331ae616f82bf65498'),
(11,'Sandrine','Cassin','lelia35@example.net',89504873829,'7cbf2224b01daa4d7fb93b5db2b7221dd550f11e'),
(12,'Katlyn','Fay','nader.marlin@example.net',89195194578,'298d2d7a8eefaea22844b94cfa19280ea7deac6e'),
(13,'Johnson','Wolff','guy40@example.org',89953736667,'e1d866926a7f1326891cb213d820a078c3713a1c'),
(14,'Amaya','Batz','eliezer.langworth@example.com',89837839267,'2836339226ac17a29e521a8952b3287930e0e6a7'),
(15,'Kenton','Fisher','kenny83@example.net',89054408319,'9272b9203a76e0de9a5cf614ab807a1744efba88'),
(16,'Seth','Macejkovic','zoe.abernathy@example.com',89749754325,'4413033a3b8320d89925891c5e2074b1d7d22619'),
(17,'Natalia','Langworth','von.alyson@example.com',89584093486,'00abac016a847aec6affb0d72c9448a9640314d1'),
(18,'Lonnie','Shields','casper.hahn@example.net',89466940350,'e0e832e748a091081cbada7cc6fcb560d3904e3f'),
(19,'Scotty','Walker','lexie.leuschke@example.net',89027660565,'b3529e1ed1b04a9192f3d8532c18142bc5bdc32c'),
(20,'Hobart','Yost','dave61@example.com',89833343709,'a074d578df35bcbce513e3fc19a5327603bbe7b6')
