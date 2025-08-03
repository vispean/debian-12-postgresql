/*############################################################*
 *#                                                          #*
 *#            SQL-Grundlagen - Sakila - Lösungen            #*
 *#                                                          #*
 *############################################################*/

# @author      Christian Locher <locher@faithpro.ch>
# @copyright   2025 Faithful programming
# @license     http://www.gnu.org/licenses/gpl-3.0.en.html GNU/GPLv3
# @version     2025-05-13

# Grundlagen

/*
01. Gib alle Informationen aus der Tabelle actor aus.
*/
SELECT * FROM actor;

/*
02. Zeige nur die Vornamen aller Schauspieler.
*/
SELECT first_name FROM actor;

/*
03. Wie viele Filme gibt es in der Datenbank?
*/
SELECT COUNT(*) FROM film;

/*
04. Zeige die Titel aller Filme, die 'PG' als Rating haben.
*/
SELECT title FROM film WHERE rating = 'PG';

/*
05. Zeige alle einzigartigen Vornamen der Kunden (customer).
*/
SELECT DISTINCT first_name FROM customer;

/*
06. Finde den längsten Filmtitel.
*/
SELECT title FROM film ORDER BY LENGTH(title) DESC LIMIT 1;

/*
07. Gib die Anzahl der Schauspieler mit dem Nachnamen 'KILMER' aus.
*/
SELECT COUNT(*) FROM actor WHERE last_name = 'KILMER';

/*
08. Zeige alle Filme, die länger als 120 Minuten dauern.
*/
SELECT title FROM film WHERE length > 120;


# JOINs und Bedingungen

/*
09. Zeige alle Kunden mit ihrem vollständigen Namen und der Stadt.
*/
SELECT customer.first_name, customer.last_name, city.city
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id;
/* oder */
SELECT c.first_name, c.last_name, ci.city
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id;

/*
10. Zeige alle Filme und ihre Kategorien.
*/
SELECT f.title, c.name AS category
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id;

/*
11. Zeige alle Filme mit dem Namen der Schauspielerin GINA DEGENERES (actor mit ID = 107).
*/
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = 5;

/*
12. Liste die Anzahl der Filme pro Kategorie.
*/
SELECT c.name, COUNT(*) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

/*
13. Finde alle Kunden, die in 'California' wohnen.
*/
SELECT c.first_name, c.last_name
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE a.district = 'California';

/*
14. Zeige die Top 5 Filme mit der höchsten Mietrate.
*/
SELECT title, rental_rate
FROM film
ORDER BY rental_rate DESC
LIMIT 5;

/*
15. Zeige Kunden, die keinen aktiven Account haben.
*/
SELECT first_name, last_name
FROM customer
WHERE active = 0;

/*
16. Zeige alle Filme, die in keiner Kategorie sind (leere Antwort).
*/
SELECT title
FROM film
WHERE film_id NOT IN (
	SELECT film_id FROM film_category
);


# Aggregationen und Unterabfragen

/*
17. Wie viele Kunden wohnen in jeder Stadt?
*/
SELECT ci.city, COUNT(*) AS customer_count
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city;

/*
18. Welche Kategorie hat die meisten Filme?
*/
SELECT c.name
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY COUNT(*) DESC
LIMIT 1;

/*
19. Finde den durchschnittlichen Mietpreis pro Kategorie.
*/
SELECT c.name, AVG(f.rental_rate) AS avg_rate
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

/*
20. Finde alle Kunden, die mehr als 40 Zahlungen getätigt haben.
*/
SELECT customer_id, COUNT(*) AS payments
FROM payment
GROUP BY customer_id
HAVING COUNT(*) > 40;

/*
21. Finde alle Filme, deren Mietdauer über dem Durchschnitt liegt.
*/
SELECT title, rental_duration
FROM film
WHERE rental_duration > (
	SELECT AVG(rental_duration) FROM film
);


/*
22. Zeige alle Zahlungen, die höher als der Durchschnittswert sind.
*/
SELECT * FROM payment
WHERE amount > (
	SELECT AVG(amount) FROM payment
);

/*
23. Finde Kunden, die niemals etwas gemietet haben (leere Antwort).
*/
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN (
	SELECT DISTINCT customer_id FROM rental
);

/*
24. Welche Schauspieler haben in den meisten Filmen mitgespielt?
*/
SELECT a.first_name, a.last_name, COUNT(*) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY film_count DESC
LIMIT 5;


# Komplexe Analysen

/*
25. Finde die Filme, die von den meisten verschiedenen Kunden ausgeliehen wurden.
*/
SELECT f.title, COUNT(DISTINCT r.customer_id) AS unique_customers
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY unique_customers DESC
LIMIT 5;

/*
26. Wie viel Umsatz wurde pro Store gemacht?
*/
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

/*
27. Zeige für jeden Kunden den Gesamtumsatz und die durchschnittliche Zahlung.
*/
SELECT customer_id, SUM(amount) AS total, AVG(amount) AS average
FROM payment
GROUP BY customer_id;

/*
28. Finde alle Filme, die innerhalb von 24 Stunden mehrfach ausgeliehen wurden (vom selben Inventory; leere Antwort).
*/
SELECT inventory_id, COUNT(*) AS rentals
FROM rental
GROUP BY inventory_id, DATE(rental_date)
HAVING COUNT(*) > 1;

/*
29. Verwende eine Window Function, um den Rang (nach Umsatz) jedes Kunden zu berechnen.
*/
SELECT customer_id, SUM(amount) AS total,
	   RANK() OVER (ORDER BY SUM(amount) DESC) AS revenue_rank
FROM payment
GROUP BY customer_id;

/*
30. Zeige für jeden Schauspieler die Anzahl Filme und seinen Anteil (%) an allen Filmen.
*/
SELECT a.actor_id, a.first_name, a.last_name,
       COUNT(fa.film_id) AS film_count,
       ROUND(COUNT(fa.film_id) * 100.0 / (SELECT COUNT(*) FROM film), 2) AS percentage
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

/*
31. Erstelle eine View, die alle Zahlungen mit Kundenname, Store, Film, Betrag und Datum zeigt.
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
32. [Sehr schwer] Finde alle Kunden, deren durchschnittliche Zahlung höher ist als die aller Kunden ihres Landes.
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
