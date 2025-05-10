# 🌱 Seed Data for Airbnb Database

This SQL script (`seed.sql`) populates the Airbnb clone database with sample data for testing and demonstration purposes. It simulates real-world scenarios of users booking properties, making payments, leaving reviews, and exchanging messages.

## 🗂️ Tables Seeded

### 👤 Users
Simulates both guests and hosts.

```sql
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES 
('1', 'Alice', 'Smith', 'alice@example.com', 'hashed_pw1', '1234567890', 'guest'),
('2', 'Bob', 'Johnson', 'bob@example.com', 'hashed_pw2', '0987654321', 'host');
