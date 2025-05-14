-- Task 3: Implement Indexes for Optimization

-- Before adding indexes, measure baseline performance
EXPLAIN ANALYZE
SELECT * FROM User WHERE role = 'host';

EXPLAIN ANALYZE
SELECT * FROM Property WHERE location = 'New York' AND price_per_night < 200;

EXPLAIN ANALYZE
SELECT * FROM Booking WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30';

-- User table indexes
-- Note: user_id is already indexed as primary key
-- email is already indexed due to UNIQUE constraint
-- Adding index for frequent queries filtering by role
CREATE INDEX idx_user_role ON User(role);

-- After adding index, measure performance improvement
EXPLAIN ANALYZE
SELECT * FROM User WHERE role = 'host';

-- Property table indexes
-- Note: property_id is already indexed as primary key
-- host_id is already indexed as foreign key
-- Adding composite index for location and price queries (common search parameters)
CREATE INDEX idx_property_location_price ON Property(location, price_per_night);

-- Measure performance improvement
EXPLAIN ANALYZE
SELECT * FROM Property WHERE location = 'New York' AND price_per_night < 200;

-- Adding index for property creation date (for sorting by newest properties)
CREATE INDEX idx_property_created_at ON Property(created_at);

-- Booking table indexes
-- Note: booking_id is already indexed as primary key
-- property_id and user_id are already indexed as foreign keys
-- Adding indexes for date range queries which are very common for availability searches
CREATE INDEX idx_booking_date_range ON Booking(property_id, start_date, end_date);

-- Measure performance improvement
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30';

-- Adding index for status for filtering bookings by status
CREATE INDEX idx_booking_status ON Booking(status);

-- Adding composite index for user bookings by date (for user history)
CREATE INDEX idx_user_bookings_date ON Booking(user_id, start_date);

-- Payment table indexes
-- Note: payment_id is already indexed as primary key
-- booking_id is already indexed as foreign key
-- Adding index for payment method and date for financial reporting
CREATE INDEX idx_payment_method_date ON Payment(payment_method, payment_date);

-- Review table indexes
-- Note: review_id is already indexed as primary key
-- property_id and user_id are already indexed as foreign keys
-- Adding index for rating to quickly find highly rated properties
CREATE INDEX idx_review_rating ON Review(rating);

-- Adding composite index for property reviews by date (newest reviews first)
CREATE INDEX idx_property_review_date ON Review(property_id, created_at);

-- Message table indexes
-- Note: message_id is already indexed as primary key
-- sender_id and recipient_id are already indexed as foreign keys
-- Adding index for conversation retrieval (messages between two users)
CREATE INDEX idx_conversation ON Message(sender_id, recipient_id, sent_at);

-- Adding index for user's inbox (all messages received by a user)
CREATE INDEX idx_user_inbox ON Message(recipient_id, sent_at);

-- Final complex query test with all indexes in place
EXPLAIN ANALYZE
SELECT 
    b.booking_id, b.start_date, b.end_date, b.status,
    u.first_name, u.last_name, u.email,
    p.name AS property_name, p.location, p.price_per_night
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
WHERE 
    b.start_date >= CURDATE()
    AND b.status = 'confirmed'
ORDER BY 
    b.start_date;
