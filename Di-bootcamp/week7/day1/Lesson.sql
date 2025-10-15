SELECT value, COUNT(*)
FROM sample_data
GROUP BY value
HAVING COUNT(*) > 1;

WITH CTE AS (
    SELECT "value", ROW_NUMBER() OVER (PARTITION BY "value" ORDER BY "value") AS rn
    FROM sample_data
)

INSERT INTO sample_data (id, value) VALUES (1, 10), (2, 20), (3, 10);

DROP TABLE IF EXISTS sample_data  
CREATE TABLE sample_data (id INT, value VARCHAR(50));
INSERT INTO sample_data (id, value) VALUES (1, 'apple'), (2, 'Apple'), (3, 'APPLE');

UPDATE sample_data
SET value = LOWER(value);

UPDATE sample_data
SET value = LOWER(TRIM(value));
SELECT * FROM sample_data

SELECT 
  CASE 
    WHEN "value" IS OF STRING THEN 'String'
    ELSE 'Other'
  END AS DataType
FROM 
  sample_data;

CREATE TABLE exercise_data (
    id INT,
    date VARCHAR(50),
    value INT,
    status VARCHAR(1)
);

INSERT INTO exercise_data (id, date, value, status) VALUES
(1, '2021-01-01', 10, 'A'),
(2, '2021-01-02', NULL, 'I'),
(3, '2021-01-03', -5, 'A'),
(4, '2021-01-04', 20, 'X');

UPDATE exercise_data
SET status = CASE
    WHEN LOWER(status) = 'a' THEN 'A'
    WHEN LOWER(status) = 'b' THEN 'B'
    ELSE 'U'
END;
UPDATE exercise_data
SET date = REPLACE(date, '-', '/');

ALTER TABLE exercise_data
ADD CONSTRAINT chk_value_positive
CHECK (value > 0);

CREATE OR REPLACE FUNCTION validate_order_amount()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.value <= 0 THEN
        RAISE EXCEPTION 'Value must be greater than 0';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_order_amount
BEFORE INSERT ON exercise_data
FOR EACH ROW
EXECUTE FUNCTION validate_order_amount();

UPDATE exercise_data
SET value = 0

INSERT INTO exercise_data (id, date, value, status) VALUES
(1, '2021-01-01', 1, 'A')


SELECT * FROM exercise_data


SELECT
    pid AS session_id,
    state AS status,
    query_start AS start_time,
    now() - query_start AS total_elapsed_time,
    query AS sql_text
FROM pg_stat_activity
WHERE state = 'active';
