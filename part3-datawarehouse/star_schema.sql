-- Star Schema for retail_transactions.csv

CREATE TABLE dim_date (
    date_id    INT PRIMARY KEY,
    full_date  DATE        NOT NULL,
    day        INT         NOT NULL,
    month      INT         NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    quarter    INT         NOT NULL,
    year       INT         NOT NULL
);

CREATE TABLE dim_store (
    store_id   INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    city       VARCHAR(50)  NOT NULL
);

CREATE TABLE dim_product (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(100)  NOT NULL,
    category     VARCHAR(50)   NOT NULL,
    unit_price   DECIMAL(10,2) NOT NULL
);

CREATE TABLE fact_sales (
    sale_id    VARCHAR(10)    PRIMARY KEY,
    date_id    INT            NOT NULL,
    store_id   INT            NOT NULL,
    product_id INT            NOT NULL,
    units_sold INT            NOT NULL,
    revenue    DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (date_id)    REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id)   REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- Dimension inserts (cleaned data)

INSERT INTO dim_date VALUES
(1, '2023-01-15', 15, 1, 'January',  1, 2023),
(2, '2023-02-05', 5,  2, 'February', 1, 2023),
(3, '2023-03-31', 31, 3, 'March',    1, 2023),
(4, '2023-08-09', 9,  8, 'August',   3, 2023),
(5, '2023-08-29', 29, 8, 'August',   3, 2023),
(6, '2023-10-26', 26, 10,'October',  4, 2023),
(7, '2023-12-08', 8,  12,'December', 4, 2023),
(8, '2023-12-12', 12, 12,'December', 4, 2023);

INSERT INTO dim_store VALUES
(1, 'Chennai Anna',   'Chennai'),
(2, 'Delhi South',    'Delhi'),
(3, 'Bangalore MG',   'Bangalore'),
(4, 'Mumbai Central', 'Mumbai'),
(5, 'Pune FC Road',   'Pune');

-- category normalized to title case, Grocery -> Groceries standardized
INSERT INTO dim_product VALUES
(1,  'Speaker',    'Electronics', 49262.78),
(2,  'Tablet',     'Electronics', 23226.12),
(3,  'Phone',      'Electronics', 48703.39),
(4,  'Smartwatch', 'Electronics', 58851.01),
(5,  'Atta 10kg',  'Groceries',   52464.00),
(6,  'Jeans',      'Clothing',     2317.47),
(7,  'Laptop',     'Electronics', 55000.00),
(8,  'Biscuits',   'Groceries',     500.00),
(9,  'Headphones', 'Electronics',  3200.00),
(10, 'T-Shirt',    'Clothing',     1500.00);

-- Fact inserts (10 rows, cleaned from raw transactions)
INSERT INTO fact_sales VALUES
('TXN5000', 5, 1, 1,  3,  147788.34),
('TXN5001', 8, 1, 2,  11, 255487.32),
('TXN5002', 2, 1, 3,  20, 974067.80),
('TXN5003', 2, 2, 2,  14, 325165.68),
('TXN5004', 1, 1, 4,  10, 588510.10),
('TXN5005', 4, 3, 5,  12, 629568.00),
('TXN5006', 3, 5, 4,  6,  353106.06),
('TXN5007', 6, 5, 6,  16,  37079.52),
('TXN5008', 7, 1, 7,  2,  110000.00),
('TXN5009', 4, 4, 10, 8,   12000.00);
