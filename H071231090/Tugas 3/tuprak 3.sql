USE library;

-- nomor 1
INSERT INTO authors(nama, nationality)
VALUES   ('Tere Liye','Indonesian'),
			('J.K. Rowling','British'),
			('Andrea Hirata', NULL);
			
INSERT INTO books(isbn, title, author_id, published_year, genre, copies_avaible)
VALUES 	(7040289780375, 'Ayah', 'Andrea Hirata', 2015, 'Fiction', 15),
			(9780375704025, 'Bumi', 'Tere Liye', 2014, 'Fantasy', 5),
			(8310371703024, 'Bulan', 'Tere Liye', 2015, 'Fantasy', 3),
			(9780747532699, 'Ayah', 'Andrea Hirata', 2015, 'Fiction', 15),
			(7210301703022, 'Ayah', 'Andrea Hirata', 2015, 'Fiction', 15);
			
INSERT INTO members(first_name, last_name, email, phone_number, join_date, membership_type)
VALUES 	('John', 'Doe', 'John.doe@example.com', NULL, '202304-29', NULL),
			('Alice', 'Johnson', 'alice.johnson@example.com', 1231231231, '2023-05-01', 'Standar'),
			('Bob', 'Williams', 'bob.williams@example.com', 321321431, '2023-06-20', 'Premium');
			
INSERT INTO borrowings(member_id, book_id, borrow_date, return_date)
VALUES 	(19, 9, '2023-07-10', '2023-07-25'),
			(21, 6,'2023-08-01', NULL),
			(20, 10, '2023-09-06', '2023-09-09'),
			(20, 8, '2023-09-08', NULL),
			(21, 7, '2023-09-10', NULL);

-- nomor 2
UPDATE books
SET copies_available = 14
WHERE id = 6;

UPDATE books
SET copies_available = 4
WHERE id = 7;

UPDATE books
SET copies_available = 2
WHERE id = 8;

-- nomor 3
SHOW CREATE TABLE books;
SHOW CREATE TABLE  borrowings;
SHOW CREATE TABLE members;

UPDATE members
SET membership_type = 'Standar'
WHERE id = 21;

ALTER TABLE books
DROP FOREIGN KEY books_ibfk_1;

ALTER TABLE borrowings
DROP FOREIGN KEY fk_book, 
DROP FOREIGN KEY fk_member;

DELETE FROM members
WHERE id = 20;

DELETE FROM members
WHERE id = 21;

-- option

DESCRIBE members;
DESCRIBE borrowings;
DESCRIBE authors;
DESCRIBE books;

SELECT * FROM authors;
SELECT * from books;
SELECT * from members;
SELECT * from borrowings;