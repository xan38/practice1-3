create TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(250) NOT NULL,
    email VARCHAR(250) UNIQUE NOT NULL
);

create TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT,
    Foreign Key (customer_id) REFERENCES Customers(customer_id)
);

create TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(250) NOT NULL,
    price INT NOT NULL,
    quantity INT
);

create TABLE Product_orders (
    order_id INT,
    product_id INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
); 