## NO 1
create database sepakbola;
use sepakbole;
-- Membuat tabel klub
CREATE TABLE klub (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nama_klub VARCHAR(50) NOT NULL,
    kota_asal VARCHAR(20) NOT NULL
);
-- Membuat tabel pemain 
CREATE TABLE pemain (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nama_pemain VARCHAR(50) NOT NULL,
    posisi VARCHAR(20) NOT NULL,
    id_klub INTEGER,
    FOREIGN KEY (id_klub) REFERENCES klub(id)
);
-- Membuat tabel pertandingan
CREATE TABLE pertandingan (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_klub_tuan_rumah INTEGER,
    id_klub_tamu INTEGER,
    tanggal_pertandingan DATE NOT NULL,
    skor_tuan_rumah INTEGER DEFAULT 0,
    skor_tamu INTEGER DEFAULT 0,
    FOREIGN KEY (id_klub_tuan_rumah) REFERENCES klub(id),
    FOREIGN KEY (id_klub_tamu) REFERENCES klub(id)
);
-- Membuat index
CREATE INDEX idx_posisi ON pemain(posisi);
CREATE INDEX idx_kota_asal ON klub(kota_asal);


use classicmodels;

## NO 2
SELECT 
    c.customerName,
    c.country,
    ROUND(SUM(p.amount), 2) AS TotalPayment,
    COUNT(o.orderNumber) AS orderCount,
    MAX(p.paymentDate) AS latestPaymentDate,
    CASE 
        WHEN SUM(p.amount) > 100000 THEN 'VIP'
        WHEN SUM(p.amount) BETWEEN 5000 AND 100000 THEN 'Loyal'
        ELSE 'New'
    END AS status
FROM 
    customers c
    LEFT JOIN orders o ON c.customerNumber = o.customerNumber
    LEFT JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY 
    c.customerNumber, c.customerName, c.country
ORDER BY 
    customerName;

##NO 3
WITH CustomerTotal AS (
    SELECT 
        c.customerNumber,
        c.customerName,
        SUM(od.quantityOrdered) as total_quantity
    FROM 
        customers c
        JOIN orders o ON c.customerNumber = o.customerNumber
        JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY 
        c.customerNumber, c.customerName
),
AverageTotal AS (
    SELECT AVG(quantityOrdered) as avg_quantity
    FROM orderdetails
)
SELECT 
    ct.customerNumber,
    ct.customerName,
    ct.total_quantity,
    CASE 
        WHEN ct.total_quantity > (SELECT avg_quantity FROM AverageTotal) 
        THEN 'di atas rata-rata'
        ELSE 'di bawah rata-rata'
    END as kategori_pembelian
FROM 
    CustomerTotal ct
ORDER BY 
    ct.total_quantity DESC;
 