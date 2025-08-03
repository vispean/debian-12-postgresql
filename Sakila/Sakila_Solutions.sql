/*############################################################*
 *#                                                          #*
 *#            SQL-Basics - Sakila - Solutions               #*
 *#                                                          #*
 *############################################################*/

# @author      Christian Locher <locher@faithpro.ch>
# @copyright   2025 Faithful programming
# @license     http://www.gnu.org/licenses/gpl-3.0.en.html GNU/GPLv3
# @version     2025-05-13

# Basics

/*
01. Output all information from the actor table.
*/
SELECT * FROM actor;

/*
02. Show only the first names of all actors.
*/
SELECT first_name FROM actor;

/*
03. How many movies are there in the database?
*/
SELECT COUNT(*) FROM film;

/*
04. Show the titles of all movies that have 'PG' as rating.
*/
SELECT title FROM film WHERE rating = 'PG';

/*
05. Show all unique first names of customers.
*/
SELECT DISTINCT first_name FROM customer;

/*
06. Find the longest movie title.
*/
SELECT title FROM film ORDER BY LENGTH(title) DESC LIMIT 1;

/*
07. Enter the number of actors with the surname 'KILMER'.
*/
SELECT COUNT(*) FROM actor WHERE last_name = 'KILMER';

/*
08. Show all movies longer than 120 minutes.
*/
SELECT title FROM film WHERE length > 120;


# JOINs and conditions

/*
09. Show all customers with their full name and city.
*/
SELECT customer.first_name, customer.last_name, city.city
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id;
/* or */
SELECT c.first_name, c.last_name, ci.city
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id;

/*
10. Show all movies and their categories.
*/
SELECT f.title, c.name AS category
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id;

/*
11. Showing all movies with the name of actress GINA DEGENERES (actor with ID = 107).
*/
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = 5;

/*
12. List the number of films per category.
*/
SELECT c.name, COUNT(*) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

/*
13. Find all customers who live in 'California'.
*/
SELECT c.first_name, c.last_name
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE a.district = 'California';

/*
14. Show the top 5 movies with the highest rental rate.
*/
SELECT title, rental_rate
FROM film
ORDER BY rental_rate DESC
LIMIT 5;

/*
15. Show customers who do not have an active account.
*/
SELECT first_name, last_name
FROM customer
WHERE active = 0;

/*
16. Show all movies that are not in any category (empty answer).
*/
SELECT title
FROM film
WHERE film_id NOT IN (
	SELECT film_id FROM film_category
);


# Aggregations and subqueries

/*
17. How many customers live in each city?
*/
SELECT ci.city, COUNT(*) AS customer_count
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city;

/*
18. Which category has the most movies?
*/
SELECT c.name
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY COUNT(*) DESC
LIMIT 1;

/*
19. Find the average rental price per category.
*/
SELECT c.name, AVG(f.rental_rate) AS avg_rate
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

/*
20. Find all customers who have made more than 40 payments.
*/
SELECT customer_id, COUNT(*) AS payments
FROM payment
GROUP BY customer_id
HAVING COUNT(*) > 40;

/*
21. Find all movies with a rental period above the average.
*/
SELECT title, rental_duration
FROM film
WHERE rental_duration > (
	SELECT AVG(rental_duration) FROM film
);


/*
22. Show all payments that are higher than the average value.
*/
SELECT * FROM payment
WHERE amount > (
	SELECT AVG(amount) FROM payment
);

/*
23. Find customers who have never rented anything (empty answer).
*/
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN (
	SELECT DISTINCT customer_id FROM rental
);

/*
24. Which actors have appeared in the most films?
*/
SELECT a.first_name, a.last_name, COUNT(*) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY film_count DESC
LIMIT 5;


# Complex analyses

/*
25. Find the movies that have been rented by the most different customers.
*/
SELECT f.title, COUNT(DISTINCT r.customer_id) AS unique_customers
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY unique_customers DESC
LIMIT 5;

/*
26. How much turnover was generated per store?
*/
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

/*
27. Show the total sales and average payment for each customer.
*/
SELECT customer_id, SUM(amount) AS total, AVG(amount) AS average
FROM payment
GROUP BY customer_id;

/*
28. Find all movies that have been rented multiple times within 24 hours (from the same inventory; empty answer).
*/
SELECT inventory_id, COUNT(*) AS rentals
FROM rental
GROUP BY inventory_id, DATE(rental_date)
HAVING COUNT(*) > 1;

/*
29. Use a window function to calculate the rank (by sales) of each customer.
*/
SELECT customer_id, SUM(amount) AS total,
	   RANK() OVER (ORDER BY SUM(amount) DESC) AS revenue_rank
FROM payment
GROUP BY customer_id;

/*
30. For each actor, show the number of films and his share (%) of all films.
*/
SELECT a.actor_id, a.first_name, a.last_name,
       COUNT(fa.film_id) AS film_count,
       ROUND(COUNT(fa.film_id) * 100.0 / (SELECT COUNT(*) FROM film), 2) AS percentage
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

/*
31. Create a view that shows all payments with customer name, store, movie, amount and date.
*/
CREATE VIEW payment_details AS
SELECT p.payment_id, p.amount, p.payment_date,
       c.first_name, c.last_name,
       f.title,
       s.store_id
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN store s ON i.store_id = s.store_id;

/*
32. [Very difficult] Find all customers whose average payment is higher than that of all customers in their country.
*/
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, co.country
HAVING AVG(p.amount) > (
	SELECT AVG(p2.amount)
	FROM customer c2
	JOIN address a2 ON c2.address_id = a2.address_id
	JOIN city ci2 ON a2.city_id = ci2.city_id
	JOIN country co2 ON ci2.country_id = co2.country_id
	JOIN payment p2 ON c2.customer_id = p2.customer_id
	WHERE co2.country = co.country
);
