CREATE DATABASE library;

USE library;

-- N0 1
CREATE TABLE authors(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL
);


CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(13),
    title VARCHAR(100) NOT NULL,
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(id)
);

-- NO 2
ALTER TABLE authors
ADD nationality VARCHAR(50);

-- NO 3
ALTER TABLE book
MODIFY isbn VARCHAR(13) UNIQUE;

-- N0 4
SHOW TABLES;
DESCRIBE authors;
DESCRIBE books;


-- NO 5
CREATE TABLE members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number CHAR(10), -- Nullable
    join_date DATE,
    membership_type VARCHAR(50)
);

ALTER TABLE members
ADD UNIQUE (email);

CREATE TABLE borrowings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE, -- Nullable
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);
 
DESCRIBE members;
DESCRIBE borrowings;




