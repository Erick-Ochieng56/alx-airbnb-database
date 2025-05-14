# Task 0: Complex Queries with Joins

In this task, I've created three SQL queries that demonstrate different types of SQL joins to retrieve data from the Airbnb database.

## Query 1: INNER JOIN

This query retrieves all bookings along with the details of users who made those bookings using an INNER JOIN. The INNER JOIN ensures that only bookings with corresponding users in the User table are included in the results.

## Query 2: LEFT JOIN

This query retrieves all properties and their reviews using a LEFT JOIN. The LEFT JOIN ensures that all properties are included in the results, even if they don't have any reviews. This is useful for identifying properties that haven't been reviewed yet.

## Query 3: FULL OUTER JOIN Simulation

Since MySQL doesn't directly support FULL OUTER JOIN, I've simulated it using a UNION of a LEFT JOIN and a RIGHT JOIN. This query retrieves all users and all bookings, regardless of whether a user has any bookings or whether a booking is associated with a user in the database.

The simulation is done by:
1. First, getting all users and their bookings with a LEFT JOIN
2. Then, using UNION to combine with a RIGHT JOIN that specifically targets bookings that might not have associated users
3. Ordering the results by user_id and booking_id for readability


# Task 1: Practice Subqueries

This task demonstrates the use of both correlated and non-correlated subqueries in SQL to extract specific insights from the Airbnb database.

## Query 1: Finding Properties with High Ratings

I've provided two approaches to find properties with an average rating greater than 4.0:

### Using a Subquery in the WHERE Clause
The first approach uses a correlated subquery in the WHERE clause to calculate the average rating for each property and filter those with ratings > 4.0. The same subquery is used in the SELECT list to display the average rating.

### Using GROUP BY with HAVING
The second approach uses a JOIN combined with GROUP BY and HAVING clauses. This method can be more efficient for larger datasets as it calculates the average rating only once per property.

## Query 2: Finding Active Users

This query identifies users who have made more than 3 bookings using a correlated subquery:

- The subquery `(SELECT COUNT(*) FROM Booking b WHERE b.user_id = u.user_id)` is executed for each user in the outer query
- Only users with more than 3 bookings are included in the result set
- The booking count is also included in the output to show exactly how many bookings each user has made

This type of correlated subquery is powerful for filtering based on aggregated values related to each record in the main table.

This approach ensures we get the complete set of data, equivalent to what a FULL OUTER JOIN would provide.
