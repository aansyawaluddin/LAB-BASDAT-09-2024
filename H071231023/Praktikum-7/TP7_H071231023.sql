USE classicmodels;

-- NO 1
SELECT 
    productCode, 
    productName, 
    buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products);


-- NO 2
SELECT 
    o.orderNumber, 
    o.orderDate
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber
WHERE c.salesRepEmployeeNumber IN (
        SELECT employeeNumber 
        FROM employees e
        JOIN offices o ON e.officeCode = o.officeCode
        WHERE o.city = 'Tokyo'
    );
    
    
-- NO 3
select 
	c.customerName, 
	o.orderNumber, 
    o.shippedDate, 
    o.requiredDate, 
    group_concat(p.productName) products, 
    sum(od.quantityOrdered)total_quantity_ordered , 
    concat(e.firstName, " ", e.lastName) employeeName 
from customers c
join orders o
using(customerNumber)
join orderdetails od
using (orderNumber)
join products p
using(productCode)
join employees e on c.salesRepEmployeeNumber = e.employeeNumber
where o.orderNumber in (
			select orderNumber from orders
			where shippedDate > requiredDate
            );


-- NO 4
select 
		p.productName, 
		p.productLine, 
        sum(od.quantityOrdered) total_quantity_ordered
from products p
join orderdetails od
using (productCode)
where p.productLine in (select * from(select productLine
									  from products
                                      join orderdetails
                                      using(productCode)
                                      group by productLine
                                      order by sum(quantityOrdered) desc
                                      limit 3) top3)
group by p.productCode
order by p.productLine,total_quantity_ordered desc;


