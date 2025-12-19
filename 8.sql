DROP TABLE IF EXISTS Order_Items;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- Создание таблицы Покупателей
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    recommended_by INT,
    FOREIGN KEY (recommended_by) REFERENCES Customers(customer_id)
);

-- Создание таблицы Товаров
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Создание таблицы Заказов
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Создание таблицы Состава Заказа
CREATE TABLE Order_Items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Наполнение таблиц данными
INSERT INTO Customers (customer_id, full_name, email, registration_date, recommended_by) VALUES
(1, 'Иван Иванов', 'ivan.ivanov@example.com', '2023-01-15', NULL),
(2, 'Мария Петрова', 'maria.petrova@example.com', '2023-02-20', 1),
(3, 'Алексей Смирнов', 'alex.smirnov@example.com', '2023-03-10', 1),
(4, 'Елена Васильева', 'elena.v@example.com', '2023-04-01', 2),
(5, 'Андрей Николаев', 'andrey.n@example.com', '2023-05-01', NULL);

INSERT INTO Products (product_name, category, price) VALUES
('Смартфон', 'Электроника', 70000.00),
('Ноутбук', 'Электроника', 120000.00),
('Кофемашина', 'Бытовая техника', 25000.00),
('Книга "Основы SQL"', 'Книги', 1500.00),
('Фен', 'Бытовая техника', 4500.00),
('Пылесос', 'Бытовая техника', 15000.00);

INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2024-05-10', 'Доставлен'),
(2, '2024-05-12', 'В обработке'),
(1, '2024-05-15', 'Отправлен'),
(3, '2024-05-16', 'Доставлен');

INSERT INTO Order_Items (order_id, product_id, quantity, price_per_unit) VALUES
(1, 1, 1, 70000.00),  -- Иван купил Смартфон
(1, 4, 2, 1400.00),   -- и 2 книги
(2, 2, 1, 120000.00), -- Мария купила Ноутбук
(3, 3, 1, 25000.00),  -- Иван купил Кофемашину
(4, 1, 1, 70000.00),  -- Алексей купил Смартфон
(4, 5, 1, 4500.00);   -- и Фен


SELECT --Задание 1
    c.full_name, 
    o.order_date
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;


SELECT --Задание 2
    c.full_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

SELECT --Задание 3
    p.product_name,
    oi.quantity,
    oi.price_per_unit
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_id = 1;

SELECT --Задание 4
    full_name 
FROM Customers 
WHERE customer_id IN (SELECT DISTINCT customer_id
FROM Orders 
WHERE order_id  IN(SELECT DISTINCT order_id
FROM Order_items
Where product_id  IN (SELECT DISTINCT product_id
FROM Products
    WHERE product_name = 'Смартфон'
)));

SELECT --Задание 5
    product_name,
    price 
FROM Products
WHERE price > (SELECT AVG(price) FROM Products);

SELECT --Задание 6
    order_id,
    order_date
FROM Orders o
WHERE (
    SELECT SUM(oi.quantity * oi.price_per_unit)
    FROM Order_Items oi
    WHERE oi.order_id = o.order_id 
) > 100000;

SELECT DISTINCT --Задание 7
    c.full_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
LEFT JOIN Products p ON oi.product_id = p.product_id AND p.product_name = 'Ноутбук'
WHERE p.product_id IS NULL;

SELECT --Задание 7
    full_name 
FROM Customers 
WHERE customer_id NOT IN (SELECT DISTINCT customer_id
FROM Orders 
WHERE order_id NOT IN (SELECT DISTINCT order_id
FROM order_items
WHERE product_id NOT IN (SELECT DISTINCT product_id
FROM Products 
WHERE product_name = 'Ноутбук'
)));

SELECT --Задание 8
    p.product_name
FROM Order_Items oi
RIGHT JOIN Products p ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;

SELECT -- Задание 9
    c.full_name,
    p.product_name,
    oi.quantity
FROM Customers c
FULL OUTER JOIN Orders o ON c.customer_id = o.customer_id
FULL OUTER JOIN Order_Items oi ON o.order_id = oi.order_id
FULL OUTER JOIN Products p ON oi.product_id = p.product_id;

SELECT -- Задание 10
    c.full_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
WHERE oi.price_per_unit = 120000
;

SELECT --Задание 10
    full_name 
FROM Customers
WHERE customer_id IN (SELECT DISTINCT customer_id
FROM Orders
WHERE order_id IN (SELECT DISTINCT order_id
FROM Order_Items
WHERE price_per_unit = (SELECT MAX(price_per_unit)
FROM Order_Items
)))
;

SELECT DISTINCT--Задание 11
    c.full_name,
    p.category
FROM Customers c
CROSS JOIN Products p

SELECT -- Задание 11
    c.full_name,
    p.product_name
FROM Customers c
CROSS JOIN Products p;

SELECT -- Задание 12
    r.full_name AS recommended_by,
    c.full_name AS new_customer
FROM Customers c
JOIN Customers r ON c.recommended_by = r.customer_id;