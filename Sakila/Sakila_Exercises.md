[//]: # (######################################################)
[//]: # (#                                                    #)
[//]: # (#            SQL-Basics - Sakila - Exercises         #)
[//]: # (#                                                    #)
[//]: # (######################################################)

[//]: # (@author      Christian Locher <locher@faithpro.ch>)
[//]: # (@copyright   2025 Faithful programming)
[//]: # (@license     http://www.gnu.org/licenses/gpl-3.0.en.html GNU/GPLv3)
[//]: # (@version     2025-05-13)

# SQL-Exercises

## Basics

01. Output all information from the actor table.
02. Show only the first names of all actors.
03. How many movies are there in the database?
04. Show the titles of all movies that have 'PG' as rating.
05. Show all unique first names of customers.
06. Find the longest movie title.
07. Enter the number of actors with the surname 'KILMER'.
08. Show all movies longer than 120 minutes.

## JOINs and conditions

09. Show all customers with their full name and city.
10. Show all movies and their categories.
11. Showing all movies with the name of actress GINA DEGENERES (actor with ID = 107).
12. List the number of films per category.
13. Find all customers who live in 'California'.
14. Show the top 5 movies with the highest rental rate.
15. Show customers who do not have an active account.
16. Show all movies that are not in any category (empty answer).

## Aggregations and subqueries

17. How many customers live in each city?
18. Which category has the most movies?
19. Find the average rental price per category.
20. Find all customers who have made more than 40 payments.
21. Find all movies with a rental period above the average.
22. Show all payments that are higher than the average value.
23. Find customers who have never rented anything (empty answer).
24. Which actors have appeared in the most films?

## Complex analyses

25. Find the movies that have been rented by the most different customers.
26. How much turnover was generated per store?
27. Show the total sales and average payment for each customer.
28. Find all movies that have been rented multiple times within 24 hours (from the same inventory; empty answer).
29. Use a window function to calculate the rank (by sales) of each customer.
30. For each actor, show the number of films and his share (%) of all films.
31. Create a view that shows all payments with customer name, store, movie, amount and date.
32. [Very difficult] Find all customers whose average payment is higher than that of all customers in their country.
