CREATE TABLE colors(
color_id SERIAL PRIMARY KEY,
color_name TEXT);

INSERT INTO colors (color_name)
VALUES('grey'), ('blue'), ('red');

SELECT * FROM colors

CREATE TABLE cars(
car_id SERIAL PRIMARY KEY,
car_color INTEGER REFERENCES colors (color_id),
car_name TEXT);

INSERT INTO cars (car_color, car_name)
VALUES
((SELECT color_id FROM colors WHERE color_name ='grey'), 'Mazda'),
((SELECT color_id FROM colors WHERE color_name ='blue'), 'Honda'),
((SELECT color_id FROM colors WHERE color_name ='red'), 'Mazda')

DELETE FROM cars
WHERE car_color = 2

ROP TABLE cars_cascade
DROP TABLE cars

CREATE TABLE cars_cascade(
car_id SERIAL PRIMARY KEY,
car_color INTEGER REFERENCES colors (color_id) ON DELETE CASCADE,
car_name TEXT);

DELETE FROM colors
WHERE color_name = 'grey'

SELECT FROM cars_cascade


