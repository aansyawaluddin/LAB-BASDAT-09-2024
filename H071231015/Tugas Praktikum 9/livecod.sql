

-- live code
CREATE DATABASE football;

USE football;


BEGIN;


CREATE TABLE klub(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL
)


CREATE TABLE pemain(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_pemain VARCHAR(50) NOT NULL,
	posisi VARCHAR(20) NOT NULL,
	id_klub INT,
	FOREIGN KEY(id_klub) REFERENCES klub(id)
)


CREATE TABLE pertandingan(
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_klub_tuan_rumah INT,
	FOREIGN KEY(id_klub_tuan_rumah) REFERENCES klub(id),
	id_klub_tamu INT,
	FOREIGN KEY(id_klub_tamu) REFERENCES klub(id),
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0
)


CREATE INDEX idx_pemain_posisi ON pemain(posisi)

CREATE INDEX idx_klub_kota_asal ON klub(kota_asal)


DESCRIBE pemain

DESCRIBE klub


-- nomor 2

USE classicmodels


SELECT c.customerName,
c.country,
SUM(p.amount) 'TotalPayment',
COUNT(o.orderNumber) 'orderCount',
MAX(p.paymentDate) 'LastPaymentDate',
case
	when SUM(p.amount) > 100000 then 'VIP'
	when SUM(p.amount) BETWEEN 5000 AND 100000 then 'Loyal'
	when SUM(p.amount) < 5000 then 'New'
END AS status
FROM customers c
left JOIN payments p USING(customerNumber)
left JOIN orders o USING(customernumber)
GROUP BY c.customerNumber
ORDER BY c.customerName


-- nomor 3

SELECT c.customerNumber,
c.customerName,
SUM(od.quantityOrdered) 'total_quantity',
case
	when od.quantityOrdered > AVG(od.quantityOrdered) 
	then 'di atas rata-rata'
	when od.quantityOrdered = AVG(od.quantityOrdered) 
	then 'rata-rata'
	when od.quantityOrdered < AVG(od.quantityOrdered) 
	then 'di bawah rata-rata'
END AS 'kategori_pembelian'
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(ordernumber)
GROUP BY c.customerNumber
ORDER BY total_quantity DESC


-- soal tambahan

USE football;

BEGIN;

INSERT INTO klub(nama_klub, kota_asal)
VALUES ('Persija', 'Jakarta'),
('Arema FC', 'Malang'),
('Persebaya', 'Surabaya'),
('PSM Makassar', 'Makassar'),
('Bali United', 'Bali');


INSERT INTO pemain(nama_pemain, posisi, id_klub)
VALUES ('Evan Dimas', 'Midfielder', 1), 
('Riko Simanjuntak', 'Forward', 1),
('Hanif Sjahbandi', 'Defender', 2),
('Makan Konate', 'Midfielder', 2),
('David da Silva', 'Forward', 3),
('Irfan Jaya', 'Forward', 4),
('Rizky Pellu', 'Midfielder', 4),
('Ilija Spasojevic', 'Forward', 5),
('Andhika Wijaya', 'Defender', 5)


INSERT INTO pertandingan(id_klub_tuan_rumah, 
id_klub_tamu, tanggal_pertandingan, skor_tuan_rumah, skor_tamu)
VALUES (1, 2, '2024-09-10', 2, 1),
(3, 4, '2024-09-12', 1, 1),
(5, 1, '2024-09-15', 0, 3),
(2, 5, '2024-09-20', 1, 2),
(4, 3, '2024-09-25', 2, 0)


SELECT * FROM klub

SELECT * FROM pemain

SELECT * FROM pertandingan

ROLLBACK 


COMMIT 


drop database football;


-- lagi tambahan


USE classicmodels 


SELECT c.customerName 'Pelanggan',
pdt.productName 'Nama Produk',
pdt.productLine 'Kategori Produk',
od.priceEach 'Harga per unit',
o.orderDate 'Tanggal Pesanan',
case
	when od.priceEach > AVG(od.priceEach) 
	then 'Harga tinggi'
	when od.priceEach < AVG(od.priceEach)
	then 'Harga terjangkau'
	when od.priceEach = AVG(od.priceEach)
	then 'Rata-rata'
END AS 'Keterangan'
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products pdt USING(productCode)
WHERE MONTH(o.orderDate) IN (1, 3, 5, 7, 9, 11)
AND right(DAY(o.orderDate), 1) IN (0, 2, 4, 6, 8)
AND LEFT(pdt.productName, 1) NOT IN ('A', 'I', 'U', 'E', 'O')
AND length(pdt.productName) > 20
GROUP BY pdt.productName
ORDER BY `Harga per unit` DESC



-- latihan sakila


use sakila;

-- nomor 1


select a.last_name,
sum(f.film_id) 'jumlah film',
f.title
from actor a
join film_actor fa using(actor_id)
join film f using(film_id)
where right(a.last_name, 2) = 'ER'
group by a.actor_id
order by `jumlah film` desc;


-- nomor 2


(select f.title, 
c.name,
'Disukai' as status
from film f
join film_category fc using(film_id)
join category c using(category_id)
where rating > (select avg(rating) from film)
limit 50)
union
(select f.title, 
c.name,
'Standar' as status
from film f
join film_category fc using(film_id)
join category c using(category_id)
where rating < (select avg(rating) from film)
limit 50)
order by status

