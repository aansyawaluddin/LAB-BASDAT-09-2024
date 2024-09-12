# Query 1
CREATE DATABASE library;

USE library;

CREATE TABLE authors(
	id INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL
);

CREATE TABLE books (
	id INT PRIMARY KEY AUTO_INCREMENT,
	isbn CHAR(13),
	title VARCHAR(100) NOT NULL,
	author_id INT,
	FOREIGN KEY(author_id) REFERENCES authors(id)
);

# Query 2
ALTER TABLE authors
ADD nationality VARCHAR(50);

# Query 3
ALTER TABLE books
MODIFY isbn CHAR(13) UNIQUE;

# Query 4
DESCRIBE authors;
DESCRIBE books;

# Query 5
CREATE TABLE members (
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	phone_number CHAR(10),
	join_date DATE NOT NULL,
	membership_type VARCHAR(50) NOT NULL
);

CREATE TABLE borrowings (
	id INT PRIMARY KEY AUTO_INCREMENT,
	member_id INT NOT NULL,
	book_id INT NOT NULL,
	borrow_date DATE NOT NULL,
	return_date DATE,
	FOREIGN KEY (member_id) REFERENCES members(id),
	FOREIGN KEY (book_id) REFERENCES books(id)
);

ALTER TABLE books
	ADD publisher_year YEAR NOT NULL,
	ADD genre VARCHAR(50) NOT NULL,
	ADD copies_available INT NOT NULL,
	MODIFY title VARCHAR(150) NOT NULL,
	MODIFY isbn CHAR(13) UNIQUE NOT NULL,
	MODIFY author_id INT NOT NULL;
	
DESCRIBE members;
DESCRIBE borrowings;
DESCRIBE authors;
DESCRIBE books;

DROP DATABASE library;