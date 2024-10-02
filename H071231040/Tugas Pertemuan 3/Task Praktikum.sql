-- Query 1

# Authors
INSERT INTO authors (name, nationality)
VALUES ('Tere Liye', 'Indonesia'),
			('J.K. Rowling', 'British'),
			('Andrea Hirata', '');

SELECT * FROM authors;

# Books
INSERT INTO books (id, isbn, title, author_id, published_year, genre, copies_available)
VALUES (1, '7040289780375', 'Ayah', 3, 2015, 'Fiction', 15),
			(2, '9780375704025', 'Buborrowingsmi', 1, 2014, 'Fantasy', 5),
			(3, '8310371703024', 'Bulan', 1, 2015, 'Fantasy', 3),
			(4, '9780747532699', "Harry Potter and the Philosopher's Stone", 2, 1997, '', 10),
			(5, '7210301703022', 'The Running Grave', 2, 2016, 'Fiction', 11);

SELECT * FROM books;

# Members
INSERT INTO members 
VALUES (1, 'John', 'Doe', 'John.doe@example.com', NULL, '2023-04-29', ''),
			(2, 'Alice', 'Johnson', 'alice.johnson@example.com', 1231231231, '2023-06-20', 'Standar'),
			(3, 'Bob', 'Williams', 'bob.williams@example.com', 3213214321, '2023-06-20', 'Premium');

SELECT * FROM members;

# Borrowings
INSERT INTO borrowings
VALUES (1, 1, 4, '2023-07-10', '2023-07-25'),
			(2, 3, 1, '2023-08-01', NULL),
			(3, 2, 5, '2023-09-06', '2023-09-09'),
			(4, 2, 3, '2023-09-08', NULL),
			(5, 3, 2, '2023-09-10', NULL);
			
SELECT * FROM borrowings;


-- Query 2
SELECT book_id FROM borrowings WHERE return_date IS NULL;

UPDATE books
SET copies_available = copies_available - 1
WHERE id <= 3;


-- Query 3
SELECT member_id FROM borrowings WHERE return_date IS NULL;

UPDATE members
SET membership_type = 'Standar'
WHERE membership_type = 'Premium'
AND id = 3;

DELETE FROM members
WHERE membership_type = 'Standar' 
AND id = 2;