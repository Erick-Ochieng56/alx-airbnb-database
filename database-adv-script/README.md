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


# Task 2: Aggregations and Window Functions

This task demonstrates the use of SQL aggregation functions and window functions to analyze booking data in the Airbnb database.

## Query 1: Bookings per User

This query counts the total number of bookings made by each user using the COUNT function with GROUP BY. 

Key features:
- Uses LEFT JOIN to include all users, even those without bookings
- Calculates both the total number of bookings and the total amount spent by each user
- Orders results by booking count and total spent, showing the most active users first

## Query 2: Property Ranking by Bookings

This query ranks properties based on their booking counts using three different window functions:

1. **RANK()**: Assigns a rank to each property, with ties receiving the same rank (skipping subsequent ranks)
2. **DENSE_RANK()**: Similar to RANK but without gaps in the ranking sequence
3. **ROW_NUMBER()**: Assigns a unique sequential number to each property, with ties broken by the secondary ordering criterion (price_per_night)

The query demonstrates how different window functions handle the same dataset differently, particularly when there are ties.

## Query 3: Location-Based Property Ranking

This query extends the analysis by:
- Calculating the average rating and review count for each property
- Using the PARTITION BY clause to create rankings within each location
- Allowing you to see the best-rated properties in each location separately

This location-based analysis is particularly valuable for:
- Market analysis in different regions
- Identifying top-performing properties in each area
- Understanding local competition dynamics
