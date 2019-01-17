-- Select all columns and rows from the movies table
SELECT * FROM movies;
-- Select only the title and id of the first 10 rows
SELECT 
	`id`, 
	`title` 
FROM movies 
LIMIT 10;
-- Find the movie with the id of 485
SELECT
	`title`
FROM movies
WHERE id = 485;
-- Find the id (only that column) of the movie Made in America (1993)
SELECT
	`id`
FROM
	movies
WHERE `title` = "Made in America (1993)";
-- Find the first 10 sorted alphabetically
SELECT
	`title`
FROM
	movies
ORDER BY
	`title` ASC
LIMIT 10;
-- Find all movies from 2002
SELECT
	`title`
FROM
	movies
WHERE
	SUBSTR(`title`,-6) = "(2002)";
-- Find out what year the Godfather came out
SELECT
	SUBSTR(`title`,-6)
FROM
	movies
WHERE
	SUBSTR(`title`, 1,9) = "Godfather"
GROUP BY
	`title`
LIMIT 1;
-- Without using joins find all the comedies
SELECT
	`title`
FROM
	movies
WHERE
	INSTR(`genres`, 'Comedy') > 0;
-- Find all comedies in the year 2000
SELECT
	`title`
FROM
	movies
WHERE
	INSTR(`genres`, 'Comedy') > 0 AND
	SUBSTR(`title`, -6) = '(2000)';
-- Find any movies that are about death and are a comedy
SELECT *
FROM movies
WHERE `title` LIKE '%death%' AND `genres` LIKE '%comedy%';
-- Find any movies from either 2001 or 2002 with a title containing super
SELECT *
FROM movies
WHERE
	`title` LIKE '%super%(2001)' OR `title` LIKE '%super%(2002)';
-- Create a new table called actors (We are going to pretend the actor can only play in one movie). The table should include name, character name, foreign key to movies and date of birth at least plus an id field.
-- Pick 3 movies and create insert statements for 10 actors each. You should use the multi value insert statements
INSERT INTO actors (`name`, `char_name`, `movie_id`, `dob`)
VALUES
	('Tom Hanks', 'Woody (voice)', 1, '1956-07-09'), ('Tim Allen', 'Buzz Lightyear (voice)', 1, '1953-06-13'), ('Don Rickles', 'Mr. Potato Head (voice)', 1, '1926-05-08'),
	('Jim Varney', 'Slinky Dog (voice)', 1, '1949-06-15'), ('Wallace Shawn', 'Rex (voice)', 1, '1943-11-12'), ('John Ratzenberger', 'Hamm (voice)', 1, '1947-04-06'),
	('Annie Potts', 'Bo Peep (voice)', 1, '1952-10-28'), ('John Morris', 'Andy (voice)', 1, '1984-10-02'), ('Erik von Detten', 'Sid (voice)', 1, '1982-10-03'),
	('Laurie Metcalf', 'Mrs. Davis (voice)', 1, '1955-06-16');
INSERT INTO actors (`name`, `char_name`, `movie_id`, `dob`)
VALUES
	('Val Kilmer', 'Batman/Bruce Wayne', 153, '1959-12-31'), ('Tommy Lee Jones', 'Harvey Two-Face/Harvey Dent', 153, '1946-09-15'), 
	('Jim Carrey', 'Riddler/Edward Nygma', 153, '1962-01-17'), ('Nicole Kidman', 'Dr. Chase Meridian', 153, '1967-06-20'),
	("Chris O'Donnell", 'Robin/Dick Grayson', 153, '1970-06-26'), ('Michael Gough', 'Alfred', 153, '1916-11-23'),
	('Pat Hingle', 'Commissioner Gordon', 153, '1924-07-19'), ('Drew Barrymore', 'Sugar', 153, '1975-02-22'),
	('Debi Mazar', 'Spice', 153, '1964-08-13'), ('Rene Auberjonois', 'Dr. Burton', 153, '1940-06-01');
INSERT INTO actors (`name`, `char_name`, `movie_id`, `dob`)
VALUES
	('Macaulay Culkin', 'Richard Tyler', 558, '1980-08-26'), ('Ed Begley Jr.', 'Alan Tyler', 558, '1949-09-16'), 
	('Christopher Lloyd', 'Mr. Dewey/The Pagemaster', 558, '1938-10-22'), ('Patrick Stewart', 'Adventure (voice)', 558, '1940-07-13'),
	('Whoopi Goldberg', 'Fantasy (voice)', 558, '1955-11-13'), ('Frank Welker', 'Horror (voice)', 558, '1946-03-12'),
	('Leonard Nimoy', 'Dr. Jekyll/Mr. Hyde (voice)', 558, '1931-03-26'), ('George Hearn', 'Captain Ahab (voice)', 558, '1934-06-18'),
	('Dorian Harewood', 'Jamaican Pirates (voice)', 558, '1950-08-06'), ('Jim Cummings', 'Long John Silver (voice)', 558, '1952-11-03');
-- Create a new column in the movie table  to hold the MPAA rating. UPDATE 5 different movies to their correct rating
UPDATE movies SET `mpaa_rating` = 'G'
WHERE `title` LIKE '%toy story%'; -- technically not fully correct thanks to the presence of sequels i think?
UPDATE movies SET `mpaa_rating` = 'PG'
WHERE `title` = "Jumanji (1995)";
UPDATE movies SET `mpaa_rating` = 'PG-13'
WHERE `title` = "Grumpier Old Men (1995)";
UPDATE movies SET `mpaa_rating` = 'R'
WHERE `title` = "Waiting to Exhale (1995)";
UPDATE movies SET `mpaa_rating` = 'PG'
WHERE `title` = "Father of the Bride Part II (1995)";
-- Find all the ratings for the movie Godfather, show just the title and the rating
SELECT 
	title,
	rating
FROM
	movies as m
LEFT JOIN
	ratings as r ON r.movie_id = m.id
WHERE
	m.title = 'Godfather, The (1972)';
-- Order the previous objective by newest to oldest
SELECT 
	title,
	rating,
	`timestamp`
FROM
	movies as m
LEFT JOIN
	ratings as r ON r.movie_id = m.id
WHERE
	m.title = 'Godfather, The (1972)'
ORDER BY
	r.timestamp DESC;
-- Find the comedies from 2005 and get the title and imdbid from the links table
SELECT
	title,
	imdb_Id
FROM
	movies as m
LEFT JOIN links as l ON l.movie_Id = m.id
WHERE
	m.title LIKE '%(2005)%' AND m.genres LIKE '%comedy%';
-- Find all movies that have no ratings
SELECT
	title
FROM
	movies as m
LEFT JOIN
	ratings as r ON r.movie_id = m.id
WHERE
	r.rating = NULL; -- finds nothing, there are no movies with no ratings
-- Get the average rating for a movie
SELECT
	movie_id,
	AVG(rating) as avg_rating
FROM
	ratings
GROUP BY
	movie_id
HAVING
	movie_id = 1;
-- Get the total ratings for a movie
SELECT
	movie_id,
	SUM(rating) as total_ratings
FROM
	ratings
GROUP BY
	movie_id
HAVING
	movie_id = 1;
-- Get the total movies for a genre
SELECT
	COUNT(DISTINCT genres)
FROM
	movies
WHERE
	genres LIKE '%horror%';
-- Get the average rating for a user
SELECT
	user_id,
	AVG(DISTINCT rating)
FROM
	ratings
GROUP BY
	user_id;
-- Find the user with the most ratings
SELECT
	user_id,
	COUNT(DISTINCT rating)
FROM
	ratings
GROUP BY
	user_id
ORDER BY
	COUNT(DISTINCT rating) DESC;
-- Find the user with the highest average rating
SELECT
	user_id,
	AVG(DISTINCT rating)
FROM
	ratings
GROUP BY
	user_id
ORDER BY
	AVG(DISTINCT rating) DESC;
-- Find the user with the highest average rating with more than 50 reviews
SELECT
	user_id,
	AVG(DISTINCT rating)
FROM
	ratings
GROUP BY
	user_id
HAVING
	COUNT(user_id) >= 50
ORDER BY
	AVG(DISTINCT rating) DESC;
-- Find the movies with an average rating over 4
SELECT
	movie_id,
	AVG(DISTINCT rating)
FROM
	ratings
GROUP BY
	movie_id
HAVING
	AVG(DISTINCT rating) > 4
ORDER BY
	AVG(DISTINCT rating) DESC;