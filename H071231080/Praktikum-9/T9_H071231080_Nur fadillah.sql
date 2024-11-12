-- nama : nur fadillah
-- nim : H071231080


-- NO.1
CREATE DATABASE sepak_bola;

USE sepak_bola;

CREATE TABLE klub(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL
);


CREATE TABLE pemain(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_pemain VARCHAR(50) NOT NULL,
	posisi VARCHAR(20) NOT NULL,
	id_klub INT,
	FOREIGN KEY (id_klub) REFERENCES klub(id)
);


CREATE TABLE pertandingan(
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_klub_tuan_rumah INT,
	FOREIGN KEY (id_klub_tuan_rumah) REFERENCES pemain(id_klub),
	id_klub_tamu INT,
	FOREIGN KEY (id_klub_tamu) REFERENCES klub(id),
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0
);

DESCRIBE klub;

SELECT * FROM klub;


ALTER TABLE pemain
ADD INDEX index_posisi(posisi);

ALTER TABLE klub
ADD INDEX index_kota(kota_asal);


-- no.2
USE classicmodels;

SELECT 
    c.customerName,
    c.country,
    SUM(p.amount) AS TotalPayment,
    COUNT(o.orderNumber) AS orderCount,
    MAX(p.paymentDate) AS LastPaymentDate,
    
    CASE
        WHEN SUM(p.amount) > 100000 THEN 'VIP'
        WHEN SUM(p.amount) BETWEEN 5000 AND 100000 THEN 'Loyal'
        ELSE 'New'
    END AS Status
FROM 
    customers c
LEFT JOIN payments p 
USING(customerNumber)
LEFT JOIN orders o 
USING(customerNumber)
GROUP BY c.customerNumber, c.customerName, c.country
ORDER BY c.customerName;



-- NO.3
SELECT 
	c.customerNumber,
	c.customerName,
	SUM(od.quantityOrdered) AS 'total_quantity',
	case 
	when SUM(od.quantityOrdered) > (SELECT AVG(total)
												FROM (SELECT SUM(quantityOrdered) AS total
												FROM orderdetails
												JOIN orders
												USING(orderNumber)
												GROUP BY customerNumber) AS totalquantity) then 'di atas rata-rata'
	
	ELSE 'di bawah rata-rata'
	END AS 'kategori_pembelian'
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
GROUP BY c.customerNumber
ORDER BY `total_quantity` DESC;






















ROLLBACK; 

SELECT * FROM klub

INSERT INTO klub(nama_klub, kota_asal) 
VALUES ("Persija", " Jakarta");

