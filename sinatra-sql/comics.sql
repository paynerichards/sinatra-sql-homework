CREATE DATABASE comics2;

\c comics2;

CREATE TABLE series (id SERIAL PRIMARY KEY, title VARCHAR(255), publisher VARCHAR(255), year_of_release INT);

CREATE TABLE characters (id SERIAL PRIMARY KEY, name VARCHAR(255), location VARCHAR(255), series_id INT);