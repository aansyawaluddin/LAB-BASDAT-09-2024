use classicmodels;


## NO 1
(SELECT p.productName, 
SUM(od.quantityOrdered * od.priceEach) AS TotalRevenue,
'Pendapatan Tertinggi' AS pendapatan
FROM products AS p
JOIN orderdetails AS od USING(productcode)
JOIN orders AS o USING(ordernumber)
WHERE MONTH(o.orderDate) = 9
GROUP BY p.productName
order by totalrevenue DESC LIMIT 5)
UNION 
(SELECT p.productName, 
SUM(od.quantityOrdered * od.priceEach) AS TotalRevenue,
'Pendapatan Tertinggi' AS pendapatan
FROM products AS p
JOIN orderdetails AS od USING(productcode)
JOIN orders AS o USING(ordernumber)
WHERE MONTH(o.orderDate) = 9
GROUP BY p.productName
order by totalrevenue ASC LIMIT 5);



## NO 2
(SELECT
	p.productName
FROM products p)
EXCEPT
(SELECT DISTINCT
	p.productName
FROM products p
JOIN orderdetails od
ON od.productCode = p.productCode
JOIN orders o
ON od.orderNumber = o.orderNumber
WHERE o.customerNumber IN (
						SELECT o1.customerNumber
                        FROM orders o1
                        GROUP BY o1.customerNumber
						HAVING COUNT(o1.orderNumber) > 10)
);

## NO 3
select c.customerName
from customers c
join payments p
using(customerNumber)
group by customerNumber
having sum(amount) > (select avg(amount)* 2 from payments)
and customerNumber in (  select o.customerNumber
						 from orders o
                         join orderdetails od
                         using(orderNumber) 
                         join products p
                         using(productCode)
                         where productLine = "Planes"
                         group by o.customerNumber, p.productLine
                         having sum(quantityOrdered * priceEach) > 20000
                         intersect
                         select o.customerNumber
						 from orders o
                         join orderdetails od
                         using(orderNumber) 
                         join products p
                         using(productCode)
                         where productLine = "Trains"
                         group by o.customerNumber, p.productLine
                         having sum(quantityOrdered * priceEach) > 20000);
                         

## NO 4
select Tanggal, customerNumber , group_concat(Riwayat separator " Dan ") Riwayat
from (  select o.orderDate `Tanggal`, c.customerNumber, "Memesan Barang" Riwayat
		from orders o
		join customers c
		using(customerNumber)
		where o.orderDate like ("2003-09-%")
        union
		select p.paymentDate `Tanggal`, c.customerNumber, "Membayar Pesanan" Riwayat
		from payments p
		join customers c
		using(customerNumber)
		where p.paymentDate like ("2003-09-%")
        order by customerNumber) s
group by Tanggal;

## NO 5
select p.productCode
	from products p
	join orderdetails od
	using(productCode)
	join orders o
	using(orderNumber)
	join customers c
	using(customerNumber)
where od.quantityOrdered > 48
and left(productVendor, 1) in ("A", "I", "U", "E", "O") 
and p.buyPrice > (select avg(p.buyPrice) 
						from products p
						join orderdetails od
						using(productCode)
						join orders o
						using(orderNumber)
						where orderDate between "2001-01-01" and "2004-03-31")
group by p.productCode
except
select p.productCode
	from products p
	join orderdetails od
	using(productCode)
	join orders o
	using(orderNumber)
	join customers c
	using(customerNumber)
where c.country in ("Italy", "Japan", "Germany");