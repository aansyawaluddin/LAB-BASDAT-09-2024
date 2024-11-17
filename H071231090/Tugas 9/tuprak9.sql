-- 1
CREATE DATABASE sepakbola;

USE DATABASE sepakbola;

CREATE TABLE Klub (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nma_klub VARCHAR(50) NOT NULL,
	kota_asal  VARCHAR(20) NOT NULL
);
`
CREATE TABLE Pemain (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nama_pemain VARCHAR(50) NOT NULL,
	posisi VARCHAR(20)  NOT NULL,
	id_klub INT,
	FOREIGN KEY(id_klub) REFERENCES Klub(id)
);

CREATE TABLE Pertandingan(
	id INT AUTO_INCREMENT PRIMARY KEY,
	id_klub_tuan_rumah INT,
	FOREIGN KEY(id_klub_tuan_rumah) REFERENCES Klub(id) ,
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT 0,
	skor_tamu  INT DEFAULT 0
)

USE sepakbola;
CREATE INDEX idx_posisi ON Pemain(posisi);
CREATE INDEX idx_kota_asal ON Klub(kota_asal);



-- 2
USE classicmodels;

SELECT customerName,
		 country,
		 ROUND(SUM(p.amount), 2) as TotalPayment,
  		 COUNT(o.orderNumber) as orderCount,
    	 MAX(p.paymentDate) as LastPaymentDate,
	    CASE
	        WHEN SUM(p.amount) > 100000 THEN 'VIP'
	        WHEN SUM(p.amount) BETWEEN 5000 AND 100000 THEN 'Loyal'
	        WHEN SUM(p.amount) < 5000 OR SUM(p.amount) IS NULL THEN 'New'
	    END as Status
FROM customers c
LEFT JOIN payments p
USING(customerNumber)
LEFT JOIN orders o
USING(customerNumber)
GROUP BY c.customerName
ORDER BY c.customerName;



-- 3
SELECT c.customerNumber, 
		 c.customerName,
		 SUM(od.quantityOrdered) AS total_quantity,
		 CASE 
			WHEN SUM(od.quantityOrdered) > 
			(SELECT AVG(total_quantity)
			 FROM (SELECT SUM(quantityOrdered) as total_quantity
							FROM orderdetails od2
							JOIN orders o2 
							USING(orderNumber)
							GROUP BY o2.customerNumber) total_quantity)
			THEN 'di atas rata-rata'
			ELSE 'di bawah rata-rata'
		 END AS kategori_pembelian
FROM customers c
JOIN orders 
USING(customerNumber)
JOIN orderdetails od 
USING(orderNumber)
GROUP BY c.customerNumber
ORDER BY total_quantity DESC;












