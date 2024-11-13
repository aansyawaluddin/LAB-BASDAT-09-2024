#no1
SELECT 
productcode AS 'Kode Produk',
productname AS 'Nama Produk',
quantityinstock AS 'Jumlah Stok'
FROM products
WHERE quantityinstock BETWEEN 5000 AND 6000;

#no2
SELECT 
ordernumber AS 'Nomor Pesanan',
orderdate AS 'Tanggal Pesanan',
STATUS,
customernumber AS 'Nomor Pelanggan'
FROM orders
WHERE STATUS != 'shipped'
ORDER BY customernumber;

#no3
SELECT 
employeenumber AS 'Nomor Karyawan',
firstname,
lastname,
email,
jobtitle AS 'Jabatan'
from employees
ORDER BY firstname
LIMIT 10;

#no4
SELECT 
productname AS 'Nama Produk',
productcode AS 'Kode Produk',
productline AS 'Lini Produk',
buyprice AS 'Harga Produk'
FROM products
ORDER BY buyprice DESC 
LIMIT 10 OFFSET 5;

#no5
SELECT DISTINCT country, city
FROM customers
ORDER BY country, city ASC;






