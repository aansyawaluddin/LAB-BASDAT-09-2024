-- Query 1
CREATE DATABASE sepakbola;

USE sepakbola;

CREATE TABLE klub (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama_klub VARCHAR(50) NOT NULL,
    kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE pemain (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama_pemain VARCHAR(50) NOT NULL,
    posisi VARCHAR(20) NOT NULL,
    id_klub INT,
    FOREIGN KEY (id_klub) REFERENCES klub(id)
);

CREATE TABLE pertandingan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_klub_tuan_rumah INT,
    id_klub_tamu INT,
    tanggal_pertandingan DATE NOT NULL,
    skor_tuan_rumah INT DEFAULT(0),
    skor_tamu INT DEFAULT(0),
    FOREIGN KEY (id_klub_tuan_rumah) REFERENCES klub(id),
    FOREIGN KEY (id_klub_tamu) REFERENCES klub(id)
);

ALTER TABLE pemain
ADD INDEX idx_posisi (posisi);

ALTER TABLE klub
ADD INDEX idx_kota_asal (kota_asal);

DESCRIBE klub;
DESCRIBE pemain;
DESCRIBE pertandingan;

DROP DATABASE sepakbola;

-- Query 2
USE classicmodels;

SELECT
    c.customerName,
    c.country,
    SUM(p.amount) AS totalPayment,
	COUNT(o.orderNumber) AS orderCount,
	MAX(p.paymentDate) AS LastPaymentDate,
    CASE 
        WHEN SUM(p.amount) > 100000 THEN 'VIP'
        WHEN SUM(p.amount) BETWEEN 5000 AND 100000 THEN 'Loyal'
        ELSE 'New'
    END AS `status`
FROM customers AS c
LEFT JOIN orders AS o 
	USING (customerNumber)
LEFT JOIN payments AS p
    USING (customerNumber)
GROUP BY c.customerName;

-- 3
SELECT
	customerNumber,
	customerName,
	SUM(quantityOrdered) AS total_quantity,
	CASE
		when SUM(quantityOrdered) > (SELECT AVG(quantityOrdered) FROM orderdetails) then 'di atas rata-rata'
		ELSE 'di bawah rata-rata'
	END AS kategori_pembelian
FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
GROUP by customerNumber
ORDER BY total_quantity DESC;


-- 4 (Soal Tambahan)
USE sepakbola;

SET AUTOCOMMIT = 0;

START TRANSACTION;

INSERT INTO klub (nama_klub, kota_asal)
VALUES ('Persija', 'Jakarta'),
('AArema FC', 'Malang'),
('Persebaya', 'Surabaya'),
('PSM Makassar', 'Makassar'),
('Bali United', 'Bali');

INSERT INTO pemain (nama_pemain, posisi, id_klub)
VALUES ('Evan Dimas', 'Midfielder', 1),
('Riko Simanjuntak', 'Forward', 1),
('Hanif Sjahbandi', 'Defender', 2),
('Makan Konate', 'Midfielder', 2),
('David da Silva', 'Forward', 3),
('Irfan Jaya', 'Forward', 4),
('Rizky Pellu', 'Midfielder', 4),
('Ilija Spasojevic', 'Forward', 5),
('Andhika Wijaya', 'Defender', 5);

INSERT INTO pertandingan(tanggal_pertandingan, id_klub_tuan_rumah, skor_tuan_rumah, skor_tamu, id_klub_tamu)
VALUES ('2024-09-10', 1, 2, 1, 2),
('2024-09-12', 3, 1, 1, 5),
('2024-09-15', 5, 0, 3, 1),
('2024-09-20', 2, 1, 2, 5),
('2024-09-25', 5, 2, 0, 3);

ROLLBACK;

SELECT * FROM pemain;

COMMIT;