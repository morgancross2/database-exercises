-- 1. Create file named select_exercises.sql
-- 2. Use albums_db
USE albums_db;
-- 3. Explore the table
DESCRIBE albums;
-- 3.a There are 31 rows
SELECT * FROM albums;
-- 3.b There are 23 unique artists.
SELECT DISTINCT artist FROM albums;
-- 3.c 'id' column is the primary key.
-- 3.d The oldest release date is The Beatles "Sgt. Pepper's Lonely Hearth Club Band" in 1967
-- The newest release date is Adele's "21" in 2011
SELECT artist, name, release_date FROM albums ORDER BY release_date;

-- 4.a The name of all Pink Floyd Albums are "The Dark Side of the Moon" and "The Wall"
SELECT * FROM albums WHERE artist = "Pink Floyd";
-- 4.b "Sgt Pepper's Lonely Hearts Club Band" was released in 1967
SELECT * FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
-- 4.c The genre for Nevermind is Grunge, Alternative rock
SELECT * FROM albums WHERE name = "Nevermind";
-- 4.d The following were released in the 1990s:
SELECT * FROM albums WHERE (release_date >=1990 AND release_date <2000);
-- 4.e The following had less than 20 million certified sales:
SELECT * FROM albums WHERE sales < 20;
-- 4.f List all of the rock albums:
SELECT * FROM albums WHERE genre = "Rock";
-- 4.f cont. This query does not include "Hard rock" or "progressive rock" because it is
-- searching for exact matches to "Rock". 
