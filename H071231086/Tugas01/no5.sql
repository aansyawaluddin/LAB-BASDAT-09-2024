ALTER table books
ADD published_year YEAR,
ADD genre VARCHAR(50),
ADD copies_available INT;

CREATE TABLE members(
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(100) UNIQUE,
	phone_number CHAR(10) DEFAULT NULL,
	join_date DATE,
	membership_type VARCHAR(50)
);


CREATE table borrowings(
	id INT PRIMARY KEY AUTO_INCREMENT,
	member_id INT,
	book_id INT,
	borrow_date DATE,
	return_date DATE DEFAULT 0,
	FOREIGN KEY (member_id) REFERENCES members(id),
	FOREIGN KEY (book_id) REFERENCES books(id) 
);

