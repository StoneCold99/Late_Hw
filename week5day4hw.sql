CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    weekly_fee DECIMAL(8, 2) DEFAULT 3.0
);

ALTER TABLE customer
ADD COLUMN PlatinumMember BOOLEAN;

 

CREATE PROCEDURE UpdatePlatinumMembers()
BEGIN
    -- True for customers who spent over $200
    UPDATE customer c
    SET c.PlatinumMember = TRUE
    WHERE c.customer_id IN (
        SELECT p.customer_id
        FROM payment p
        GROUP BY p.customer_id
        HAVING SUM(p.amount) > 200
    );

    -- False for customers who spent less than $200
    UPDATE customer c
    SET c.PlatinumMember = FALSE
    WHERE c.customer_id NOT IN (
        SELECT p.customer_id
        FROM payment p
        GROUP BY p.customer_id
        HAVING SUM(p.amount) > 200
    );
END //

 ;


