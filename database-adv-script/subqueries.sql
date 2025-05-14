-- Task 1: Practice Subqueries

-- Query 1: Non-correlated subquery to find all properties where the average rating is greater than 4.0
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night,
    (SELECT AVG(r.rating) FROM Review r WHERE r.property_id = p.property_id) AS average_rating
FROM 
    Property p
WHERE 
    (SELECT AVG(r.rating) FROM Review r WHERE r.property_id = p.property_id) > 4.0
ORDER BY 
    average_rating DESC;

-- Alternative approach using HAVING clause
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night,
    AVG(r.rating) AS average_rating
FROM 
    Property p
JOIN 
    Review r ON p.property_id = r.property_id
GROUP BY 
    p.property_id, p.name, p.location, p.price_per_night
HAVING 
    AVG(r.rating) > 4.0
ORDER BY 
    average_rating DESC;

-- Query 2: Correlated subquery to find users who have made more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    (SELECT COUNT(*) FROM Booking b WHERE b.user_id = u.user_id) AS booking_count
FROM 
    User u
WHERE 
    (SELECT COUNT(*) FROM Booking b WHERE b.user_id = u.user_id) > 3
ORDER BY 
    booking_count DESC;
