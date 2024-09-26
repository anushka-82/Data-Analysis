SELECT * FROM netflix.netflix_titles;


-- 1. Count the number of Movies vs TV Shows
SELeCT * FROM netflix.netflix_titles;

SELECT 
	type, 
    COUNT(*) as total_content
FROM netflix.netflix_titles
GROUP BY type;

-- 2. Find the most common rating for movies and TV shows
SELECT
	type,
    rating 
FROM
(
SELECT
	type,
	rating,
    COUNT(*),
    RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) as ranking
FROM netflix_titles 
GROUP BY 1,2 
) as t1  
WHERE 
	ranking = 1;

-- 3. List all movies released in a specific year (e.g., 2020)
SELECT *
FROM netflix_titles
WHERE 
	type = "Movies"
    AND
    release_year = 2020;


-- 4. Find the top 5 countries with the most content on Netflix
SELECT 
    COUNT(show_id) as total_content
FROM netflix_titles
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 5. Identify the longest movie
SELECT * FROM netflix_titles
WHERE
	type = 'Movie'
    AND
    duration = (SELECT MAX(duration) AS max_duration FROM netflix_titles);


-- 6. Find content added in the last 5 years
SELECT *
FROM netflix_titles
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= CURDATE() - INTERVAL 5 YEAR;

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT *
FROM netflix_titles
WHERE director LIKE '%Rajiv Chilaka%';

 -- 8. List all TV shows with more than 5 seasons
 
 SELECT * FROM netflix_titles
WHERE
	type = 'TV Show'
    AND
    CAST(SUBSTRING_INDEX(duration, ' ' , 1) AS UNSIGNED) > 5;
    
-- 9. Count the number of content items in each genre

SELECT 
	listed_in,
    show_id
FROM netflix_titles;

-- 10. List all movies that are documentaries
SELECT * FROM netflix.titles
WHERE listed_in LIKE '%Documentaries'
