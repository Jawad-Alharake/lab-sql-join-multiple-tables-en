-- 1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a USING (address_id)
JOIN city ci USING (city_id)
JOIN country co USING (country_id);

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT
	st.store_id,
	SUM(p.amount) AS total_business
FROM payment AS p
JOIN staff AS st USING (staff_id)
GROUP BY st.store_id;

-- 3. What is the average running time of films by category?
SELECT c.name AS category_name, AVG(f.length) AS average_running_time
FROM category c
JOIN film_category fc USING (category_id)
JOIN film f USING (film_id)
GROUP BY c.name
ORDER BY average_running_time DESC;

-- 4. Which film categories are longest?
SELECT category.name, SUM(film.length) as films_length
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY films_length DESC;

-- 5. Display the most frequently rented movies in descending order.
SELECT
	f.title,
	COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i USING (film_id)
JOIN rental r USING (inventory_id)
GROUP BY f.title
ORDER BY rental_count DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT
	c.name AS genre,
	SUM(p.amount) AS gross_revenue
FROM category c
JOIN film_category fc USING (category_id)
JOIN inventory i USING (film_id)
JOIN rental r USING (inventory_id)
JOIN payment p USING (rental_id)
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title, i.store_id, COUNT(i.inventory_id) AS total_copies
FROM film f
JOIN inventory i USING (film_id)
WHERE f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1;