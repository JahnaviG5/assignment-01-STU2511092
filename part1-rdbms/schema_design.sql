-- Schema Design: Normalized to 3NF from orders_flat.csv

CREATE TABLE customers (
    customer_id   VARCHAR(10)  PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50)  NOT NULL
);

CREATE TABLE sales_reps (
    sales_rep_id   VARCHAR(10)  PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL,
    office_address VARCHAR(200) NOT NULL
);

CREATE TABLE products (
    product_id   VARCHAR(10)    PRIMARY KEY,
    product_name VARCHAR(100)   NOT NULL,
    category     VARCHAR(50)    NOT NULL,
    unit_price   DECIMAL(10, 2) NOT NULL
);

CREATE TABLE orders (
    order_id     VARCHAR(10)  PRIMARY KEY,
    customer_id  VARCHAR(10)  NOT NULL,
    sales_rep_id VARCHAR(10)  NOT NULL,
    order_date   DATE         NOT NULL,
    FOREIGN KEY (customer_id)  REFERENCES customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);

CREATE TABLE order_items (
    item_id    INT            PRIMARY KEY AUTO_INCREMENT,
    order_id   VARCHAR(10)    NOT NULL,
    product_id VARCHAR(10)    NOT NULL,
    quantity   INT            NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- INSERT DATA (from actual orders_flat.csv)

INSERT INTO customers VALUES
('C001', 'Rohan Mehta',  'rohan@gmail.com',  'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com',  'Delhi'),
('C003', 'Amit Verma',   'amit@gmail.com',   'Bangalore'),
('C004', 'Sneha Iyer',   'sneha@gmail.com',  'Chennai'),
('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai'),
('C006', 'Neha Gupta',   'neha@gmail.com',   'Delhi'),
('C007', 'Arjun Nair',   'arjun@gmail.com',  'Bangalore'),
('C008', 'Kavya Rao',    'kavya@gmail.com',  'Hyderabad');

INSERT INTO sales_reps VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02', 'Anita Desai',  'anita@corp.com',  'Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03', 'Ravi Kumar',   'ravi@corp.com',   'South Zone, MG Road, Bangalore - 560001');

INSERT INTO products VALUES
('P001', 'Laptop',        'Electronics', 55000.00),
('P002', 'Mouse',         'Electronics',   800.00),
('P003', 'Desk Chair',    'Furniture',    8500.00),
('P004', 'Notebook',      'Stationery',    120.00),
('P005', 'Headphones',    'Electronics',  3200.00),
('P006', 'Standing Desk', 'Furniture',   22000.00),
('P007', 'Pen Set',       'Stationery',    250.00),
('P008', 'Webcam',        'Electronics',  2100.00);

INSERT INTO orders VALUES
('ORD1027', 'C002', 'SR02', '2023-11-02'),
('ORD1114', 'C001', 'SR01', '2023-08-06'),
('ORD1002', 'C002', 'SR02', '2023-01-17'),
('ORD1075', 'C005', 'SR03', '2023-04-18'),
('ORD1091', 'C001', 'SR01', '2023-07-24');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
('ORD1027', 'P004', 4,   120.00),
('ORD1114', 'P007', 2,   250.00),
('ORD1002', 'P005', 1,  3200.00),
('ORD1075', 'P003', 3,  8500.00),
('ORD1091', 'P006', 3, 22000.00);
