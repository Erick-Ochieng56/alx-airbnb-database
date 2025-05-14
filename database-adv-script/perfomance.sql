-- Task 4: Complex Query for Performance Optimization

-- Initial complex query that retrieves all bookings with user, property, and payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.price_per_night,
    
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    host.email AS host_email,
    
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method,
    
    (SELECT AVG(r.rating) 
     FROM Review r 
     WHERE r.property_id = p.property_id) AS average_property_rating,
    
    (SELECT COUNT(r.review_id) 
     FROM Review r 
     WHERE r.property_id = p.property_id) AS property_review_count
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
JOIN 
    User host ON p.host_id = host.user_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.start_date >= CURDATE()
    AND b.status = 'confirmed'
ORDER BY 
    b.start_date, 
    p.location;
