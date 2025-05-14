-- Task 2: Apply Aggregations and Window Functions

-- Query 1: Find the total number of bookings made by each user using COUNT and GROUP BY
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_price) AS total_spent
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name, u.email
ORDER BY 
    total_bookings DESC, total_spent DESC;

-- Query 2: Rank properties based on the total number of bookings they have received using window functions
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night,
    COUNT(b.booking_id) AS booking_count,
    RANK() OVER(ORDER BY COUNT(b.booking_id) DESC) AS booking_rank,
    DENSE_RANK() OVER(ORDER BY COUNT(b.booking_id) DESC) AS booking_dense_rank,
    ROW_NUMBER() OVER(ORDER BY COUNT(b.booking_id) DESC, p.price_per_night ASC) AS booking_row_number
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name, p.location, p.price_per_night
ORDER BY 
    booking_count DESC, p.price_per_night ASC;

-- Query 3: Calculate average rating and ranking within location using window functions
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night,
    AVG(r.rating) AS average_rating,
    COUNT(r.review_id) AS review_count,
    RANK() OVER(PARTITION BY p.location ORDER BY AVG(r.rating) DESC) AS location_rank
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
GROUP BY 
    p.property_id, p.name, p.location, p.price_per_night
ORDER BY 
    p.location, location_rank;
