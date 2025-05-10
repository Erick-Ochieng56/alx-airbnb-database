-- Users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES 
('1', 'Alice', 'Smith', 'alice@example.com', 'hashed_pw1', '1234567890', 'guest'),
('2', 'Bob', 'Johnson', 'bob@example.com', 'hashed_pw2', '0987654321', 'host');

-- Properties
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight)
VALUES 
('10', '2', 'Ocean View Apartment', 'Sea-facing 2-bedroom apartment.', 'Mombasa', 120.00),
('11', '2', 'Nairobi City Loft', 'Modern loft in the city center.', 'Nairobi', 80.00);

-- Bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES 
('100', '10', '1', '2025-05-15', '2025-05-20', 600.00, 'confirmed'),
('101', '11', '1', '2025-06-01', '2025-06-05', 320.00, 'pending');

-- Payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES 
('200', '100', 600.00, 'credit_card'),
('201', '101', 320.00, 'paypal');

-- Reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES 
('300', '10', '1', 5, 'Amazing stay! Super clean and great view.');

-- Messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES 
('400', '1', '2', 'Hi, is the property available from May 15?'),
('401', '2', '1', 'Yes, it’s available. Go ahead and book!');
