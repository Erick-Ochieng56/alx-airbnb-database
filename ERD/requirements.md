# Task 0: Define Entities and Relationships in ER Diagram

## Objective
Create an Entity-Relationship (ER) diagram based on the database specification.

---

## Entities and Attributes

### User
- `user_id` (Primary Key, UUID)
- `first_name` (VARCHAR, NOT NULL)
- `last_name` (VARCHAR, NOT NULL)
- `email` (VARCHAR, UNIQUE, NOT NULL)
- `password_hash` (VARCHAR, NOT NULL)
- `phone_number` (VARCHAR, NULL)
- `role` (ENUM: guest, host, admin)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Property
- `property_id` (Primary Key, UUID)
- `host_id` (Foreign Key → User.user_id)
- `name` (VARCHAR, NOT NULL)
- `description` (TEXT, NOT NULL)
- `location` (VARCHAR, NOT NULL)
- `price_per_night` (DECIMAL, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- `updated_at` (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

### Booking
- `booking_id` (Primary Key, UUID)
- `property_id` (Foreign Key → Property.property_id)
- `user_id` (Foreign Key → User.user_id)
- `start_date` (DATE, NOT NULL)
- `end_date` (DATE, NOT NULL)
- `total_price` (DECIMAL, NOT NULL)
- `status` (ENUM: pending, confirmed, canceled)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Payment
- `payment_id` (Primary Key, UUID)
- `booking_id` (Foreign Key → Booking.booking_id)
- `amount` (DECIMAL, NOT NULL)
- `payment_date` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- `payment_method` (ENUM: credit_card, paypal, stripe)

### Review
- `review_id` (Primary Key, UUID)
- `property_id` (Foreign Key → Property.property_id)
- `user_id` (Foreign Key → User.user_id)
- `rating` (INTEGER, CHECK: 1–5, NOT NULL)
- `comment` (TEXT, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Message
- `message_id` (Primary Key, UUID)
- `sender_id` (Foreign Key → User.user_id)
- `recipient_id` (Foreign Key → User.user_id)
- `message_body` (TEXT, NOT NULL)
- `sent_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

---

## Relationships

- A **User** can be a host or guest and interact with many properties, bookings, and messages.
- A **Property** belongs to one host (User) but can be booked many times and reviewed by many users.
- A **Booking** connects one user and one property and must have one corresponding payment.
- A **Review** is made by a user about a property.
- A **Message** is exchanged between users.

---

## ER Diagram

> The ER Diagram visually represents the relationships above.  
> See the diagram image below:


![airbnb-er-diagram](https://github.com/user-attachments/assets/d1eb1093-daf6-430a-92d5-d2c9dc4996de)

