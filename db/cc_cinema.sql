DROP TABLE tickets;
DROP TABLE films;
DROP TABLE customers;
DROP TABLE titles;

CREATE TABLE customers (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  funds INT4
);

CREATE TABLE titles(
  id SERIAL8 PRIMARY KEY,
  film_title VARCHAR(255),
  age_rating VARCHAR(255),
  genre VARCHAR(255)
);

CREATE TABLE films (
  id SERIAL8 PRIMARY KEY,
  title_id INT8 REFERENCES titles(id) ON DELETE CASCADE,
  show_time INT4,
  price INT4,
  capacity INT4
);

CREATE TABLE tickets (
  id SERIAL8 PRIMARY KEY,
  customer_id INT8 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT8 REFERENCES films(id) ON DELETE CASCADE
)
