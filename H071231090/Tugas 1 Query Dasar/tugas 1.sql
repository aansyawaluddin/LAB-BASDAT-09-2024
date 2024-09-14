-- H071231090 | Nur Wahida 

-- nomor 1
CREATE DATABASE library

USE library
mysql
CREATE TABLE authors(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama VARCHAR(100) NOT NULL
);

CREATE TABLE books(
	id INT PRIMARY KEY AUTO_INCREMENT,
	isbn VARCHAR(13),
	title VARCHAR(100) NOT NULL,
	author_id INT,
	FOREIGN KEY(author_id) REFERENCES authors(id)
);

-- nomor 2
ALTER TABLE authors
ADD nationality VARCHAR(50);

-- nomor 3
ALTER TABLE books
MODIFY isbn VARCHAR(13) UNIQUE;

-- nomor 4
SHOW TABLES;
DESCRIBE books;
DESCRIBE authors;

-- nomor 5
ALTER TABLE books
ADD published_year YEAR;

ALTER TABLE books
ADD genre VARCHAR(50);

ALTER TABLE books
ADD copies_avaible INT;

CREATE TABLE members(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	phone_number CHAR(10),
	join_date DATE NOT NULL,
	membership_type VARCHAR(50) NOT NULL
);

CREATE TABLE borrowings(
	id INT PRIMARY KEY AUTO_INCREMENT,
	member_id INT NOT NULL,
	book_id INT NOT NULL,
	FOREIGN KEY(member_id) REFERENCES members(id),
	FOREIGN KEY(book_id) REFERENCES books(id),
	borrow_date DATE NOT NULL,
	return_date DATE 
);

DESCRIBE authors;
DESCRIBE books;
DESCRIBE members;
DESCRIBE borrowings;