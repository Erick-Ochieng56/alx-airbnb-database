-- Task 5: Partitioning Large Tables

-- Create a partitioned version of the Booking table
-- If migrating an existing table, create we a temporary backup
-- CREATE TABLE Booking_Backup AS SELECT * FROM Booking;

-- Drop the existing table if it exists
-- DROP TABLE IF EXISTS Booking;

-- Create the new partitioned Booking table
CREATE TABLE Booking (
    booking_id CHAR(36) NOT NULL, -- UUID format
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date),
    KEY idx_property_id (property_id),
    KEY idx_user_id (user_id),
    KEY idx_booking_status (status),
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id) REFERENCES Property (property_id),
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES User (user_id)
)
ENGINE=InnoDB
-- Partition the table by RANGE based on start_date
-- This creates quarterly partitions for 2023-2026
PARTITION BY RANGE (TO_DAYS(start_date)) (
    -- 2023 Partitions
    PARTITION p_2023_q1 VALUES LESS THAN (TO_DAYS('2023-04-01')),
    PARTITION p_2023_q2 VALUES LESS THAN (TO_DAYS('2023-07-01')),
    PARTITION p_2023_q3 VALUES LESS THAN (TO_DAYS('2023-10-01')),
    PARTITION p_2023_q4 VALUES LESS THAN (TO_DAYS('2024-01-01')),
    
    -- 2024 Partitions
    PARTITION p_2024_q1 VALUES LESS THAN (TO_DAYS('2024-04-01')),
    PARTITION p_2024_q2 VALUES LESS THAN (TO_DAYS('2024-07-01')),
    PARTITION p_2024_q3 VALUES LESS THAN (TO_DAYS('2024-10-01')),
    PARTITION p_2024_q4 VALUES LESS THAN (TO_DAYS('2025-01-01')),
    
    -- 2025 Partitions
    PARTITION p_2025_q1 VALUES LESS THAN (TO_DAYS('2025-04-01')),
    PARTITION p_2025_q2 VALUES LESS THAN (TO_DAYS('2025-07-01')),
    PARTITION p_2025_q3 VALUES LESS THAN (TO_DAYS('2025-10-01')),
    PARTITION p_2025_q4 VALUES LESS THAN (TO_DAYS('2026-01-01')),
    
    -- 2026 Partitions
    PARTITION p_2026_q1 VALUES LESS THAN (TO_DAYS('2026-04-01')),
    PARTITION p_2026_q2 VALUES LESS THAN (TO_DAYS('2026-07-01')),
    PARTITION p_2026_q3 VALUES LESS THAN (TO_DAYS('2026-10-01')),
    PARTITION p_2026_q4 VALUES LESS THAN (TO_DAYS('2027-01-01')),
    
    -- Future bookings partition
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- If migrating from an existing table, restore the data
-- INSERT INTO Booking SELECT * FROM Booking_Backup;

-- Example queries that benefit from partitioning

-- Query 1: Find all bookings for a specific date range (Q2 2025)
-- This will only scan the p_2025_q2 partition
EXPLAIN SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    p.name AS property_name,
    p.location
FROM 
    Booking b
JOIN 
    Property p ON b.property_id = p.property_id
WHERE 
    b.start_date BETWEEN '2025-04-01' AND '2025-06-30'
ORDER BY 
    b.start_date;

-- Query 2: Find all bookings in the past year
-- This will scan only 4 partitions instead of the entire table
EXPLAIN SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    u.first_name,
    u.last_name,
    p.name AS property_name
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
WHERE 
    b.start_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND CURDATE()
ORDER BY 
    b.start_date DESC;

-- Adding a new partition for future years (maintenance query)
-- ALTER TABLE Booking ADD PARTITION (PARTITION p_2027_q1 VALUES LESS THAN (TO_DAYS('2027-04-01')));

-- Dropping old partitions that are no longer needed (data retention policy)
-- ALTER TABLE Booking DROP PARTITION p_2023_q1;
