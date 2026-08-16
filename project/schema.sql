DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ecommerce_db;

-- categories
CREATE TABLE categories (
    id          BIGINT        NOT NULL AUTO_INCREMENT,
    name        VARCHAR(100)  NOT NULL,
    slug        VARCHAR(100)  NOT NULL,
    description TEXT,
    created_at  DATETIME,
    updated_at  DATETIME,
    PRIMARY KEY (id),
    UNIQUE KEY uk_categories_name (name),
    UNIQUE KEY uk_categories_slug (slug)
);

-- products
CREATE TABLE products (
    id             BIGINT        NOT NULL AUTO_INCREMENT,
    name           VARCHAR(200)  NOT NULL,
    description    TEXT,
    price          DECIMAL(10,2) NOT NULL,
    sku            VARCHAR(100)  NOT NULL,
    stock_quantity INT           NOT NULL DEFAULT 0,
    active         BOOLEAN       NOT NULL DEFAULT TRUE,
    category_id    BIGINT        NOT NULL,
    created_at     DATETIME,
    updated_at     DATETIME,
    PRIMARY KEY (id),
    UNIQUE KEY uk_products_sku (sku),
    CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories (id)
);

-- customers
CREATE TABLE customers (
    id         BIGINT        NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100)  NOT NULL,
    last_name  VARCHAR(100)  NOT NULL,
    email      VARCHAR(255)  NOT NULL,
    phone      VARCHAR(20),
    address    TEXT,
    created_at DATETIME,
    PRIMARY KEY (id),
    UNIQUE KEY uk_customers_email (email)
);

-- orders
CREATE TABLE orders (
    id               BIGINT        NOT NULL AUTO_INCREMENT,
    order_number     VARCHAR(20)   NOT NULL,
    customer_id      BIGINT        NOT NULL,
    status           VARCHAR(20)   NOT NULL DEFAULT 'PENDING',
    total_amount     DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    shipping_address TEXT          NOT NULL,
    notes            TEXT,
    created_at       DATETIME,
    updated_at       DATETIME,
    PRIMARY KEY (id),
    UNIQUE KEY uk_orders_order_number (order_number),
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers (id)
);

-- order_items
CREATE TABLE order_items (
    id         BIGINT        NOT NULL AUTO_INCREMENT,
    order_id   BIGINT        NOT NULL,
    product_id BIGINT        NOT NULL,
    quantity   INT           NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal   DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_order_items_order   FOREIGN KEY (order_id)   REFERENCES orders   (id),
    CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products (id)
);

-- payments
CREATE TABLE payments (
    id             BIGINT        NOT NULL AUTO_INCREMENT,
    order_id       BIGINT        NOT NULL,
    payment_method VARCHAR(30)   NOT NULL,
    payment_status VARCHAR(20)   NOT NULL DEFAULT 'PENDING',
    amount         DECIMAL(12,2) NOT NULL,
    created_at     DATETIME,
    PRIMARY KEY (id),
    UNIQUE KEY uk_payments_order_id (order_id),
    CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders (id)
);

-- indexes
CREATE INDEX idx_products_category   ON products    (category_id);
CREATE INDEX idx_products_active     ON products    (active);
CREATE INDEX idx_orders_customer     ON orders      (customer_id);
CREATE INDEX idx_orders_status       ON orders      (status);
CREATE INDEX idx_order_items_order   ON order_items (order_id);
CREATE INDEX idx_order_items_product ON order_items (product_id);

-- ---------------------------------------------------------------------------
-- Seed data (reference data + customers only).
-- Orders, order_items and payments are intentionally left empty — create those
-- through the API so order-number generation, stock reduction and the cascade
-- save all run as designed.
-- ---------------------------------------------------------------------------

-- categories
INSERT INTO categories (name, slug, description, created_at, updated_at) VALUES
('Electronics',    'electronics',    'Gadgets, accessories and devices',   NOW(), NOW()),
('Books',          'books',          'Printed and reference books',        NOW(), NOW()),
('Clothing',       'clothing',       'Apparel and everyday wear',          NOW(), NOW()),
('Home & Kitchen', 'home-kitchen',   'Homeware and kitchen essentials',    NOW(), NOW());

-- products
INSERT INTO products (name, description, price, sku, stock_quantity, active, category_id, created_at, updated_at) VALUES
('Wireless Mouse',              'Ergonomic 2.4GHz wireless mouse',            24.99, 'ELEC-MOU-001', 150, TRUE, 1, NOW(), NOW()),
('Mechanical Keyboard',         'Tactile mechanical keyboard, RGB backlit',   79.99, 'ELEC-KEY-002',  80, TRUE, 1, NOW(), NOW()),
('USB-C Hub',                   '7-in-1 USB-C multiport adapter',             39.99, 'ELEC-HUB-003',  60, TRUE, 1, NOW(), NOW()),
('Noise-Cancelling Headphones', 'Over-ear ANC wireless headphones',          199.99, 'ELEC-HDP-004',  40, TRUE, 1, NOW(), NOW()),
('Clean Code',                  'A Handbook of Agile Software Craftsmanship', 32.50, 'BOOK-CLN-001', 200, TRUE, 2, NOW(), NOW()),
('The Pragmatic Programmer',    'Your Journey to Mastery',                    41.00, 'BOOK-PRG-002', 120, TRUE, 2, NOW(), NOW()),
('Cotton T-Shirt',              'Soft 100% cotton crew-neck tee',             15.00, 'CLTH-TSH-001', 300, TRUE, 3, NOW(), NOW()),
('Hooded Sweatshirt',           'Fleece-lined pullover hoodie',               45.00, 'CLTH-HOD-002',  90, TRUE, 3, NOW(), NOW()),
('Stainless Steel Bottle',      'Insulated 750ml water bottle',               18.99, 'HOME-BTL-001', 250, TRUE, 4, NOW(), NOW()),
('Ceramic Coffee Mug',          '350ml glazed ceramic mug',                   12.50, 'HOME-MUG-002', 180, TRUE, 4, NOW(), NOW());

-- customers
INSERT INTO customers (first_name, last_name, email, phone, address, created_at) VALUES
('John',  'Doe',   'john.doe@example.com',   '+1-202-555-0101', '123 Maple Street, Springfield', NOW()),
('Jane',  'Smith', 'jane.smith@example.com', '+1-202-555-0142', '88 Oak Avenue, Riverdale',       NOW()),
('Ravi',  'Kumar', 'ravi.kumar@example.com', '+91-90000-12345', '12 MG Road, Bengaluru',          NOW());

-- ---------------------------------------------------------------------------
-- Verification (run after the script to confirm the seed loaded)
-- ---------------------------------------------------------------------------
SELECT * FROM categories;
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;
