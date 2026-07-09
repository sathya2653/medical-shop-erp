-- Medical Shop ERP Database Schema
-- MySQL 8.0

CREATE DATABASE IF NOT EXISTS medical_shop_erp;
USE medical_shop_erp;

-- Users Table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    email VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    INDEX idx_username (username)
);

-- Settings Table
CREATE TABLE settings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `key` VARCHAR(100) NOT NULL UNIQUE,
    `value` LONGTEXT NOT NULL,
    description VARCHAR(500),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_key (`key`)
);

-- Medicine Categories
CREATE TABLE medicine_categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    INDEX idx_name (name)
);

-- Manufacturers
CREATE TABLE manufacturers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    address VARCHAR(300),
    phone VARCHAR(20),
    email VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    INDEX idx_name (name)
);

-- Medicines
CREATE TABLE medicines (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    manufacturer_id INT NOT NULL,
    description VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (category_id) REFERENCES medicine_categories(id) ON DELETE RESTRICT,
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(id) ON DELETE RESTRICT,
    INDEX idx_name (name),
    INDEX idx_category (category_id),
    INDEX idx_manufacturer (manufacturer_id)
);

-- Medicine Substitutes
CREATE TABLE medicine_substitutes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT NOT NULL,
    substitute_medicine_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE CASCADE,
    FOREIGN KEY (substitute_medicine_id) REFERENCES medicines(id) ON DELETE CASCADE,
    UNIQUE KEY unique_substitutes (medicine_id, substitute_medicine_id)
);

-- Units
CREATE TABLE units (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    abbreviation VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_name (name)
);

-- Medicine Unit Conversions
CREATE TABLE medicine_unit_conversions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT NOT NULL,
    from_unit_id INT NOT NULL,
    to_unit_id INT NOT NULL,
    conversion_factor DECIMAL(10, 4) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE CASCADE,
    FOREIGN KEY (from_unit_id) REFERENCES units(id) ON DELETE RESTRICT,
    FOREIGN KEY (to_unit_id) REFERENCES units(id) ON DELETE RESTRICT,
    INDEX idx_medicine (medicine_id)
);

-- Customers
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(300),
    notes LONGTEXT,
    outstanding_balance DECIMAL(12, 2) DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    INDEX idx_name (name),
    INDEX idx_phone (phone)
);

-- Suppliers
CREATE TABLE suppliers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(300),
    outstanding_balance DECIMAL(12, 2) DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    INDEX idx_name (name),
    INDEX idx_phone (phone)
);

-- Doctors
CREATE TABLE doctors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    specialization VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    INDEX idx_name (name)
);

-- Medicine Batches
CREATE TABLE medicine_batches (
    id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT NOT NULL,
    batch_number VARCHAR(100) NOT NULL,
    purchase_price DECIMAL(12, 2) NOT NULL,
    selling_price DECIMAL(12, 2) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    expiry_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE RESTRICT,
    INDEX idx_medicine (medicine_id),
    INDEX idx_batch_number (batch_number),
    INDEX idx_expiry (expiry_date)
);

-- Stock Movements
CREATE TABLE stock_movements (
    id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_batch_id INT NOT NULL,
    movement_type INT NOT NULL,
    quantity INT NOT NULL,
    reference_id INT,
    reference_type VARCHAR(50),
    notes VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_batch_id) REFERENCES medicine_batches(id) ON DELETE RESTRICT,
    INDEX idx_medicine_batch (medicine_batch_id),
    INDEX idx_created_at (created_at)
);

-- Stock Adjustments
CREATE TABLE stock_adjustments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_batch_id INT NOT NULL,
    old_quantity INT NOT NULL,
    new_quantity INT NOT NULL,
    reason VARCHAR(500),
    adjusted_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_batch_id) REFERENCES medicine_batches(id) ON DELETE RESTRICT,
    FOREIGN KEY (adjusted_by) REFERENCES users(id) ON DELETE RESTRICT
);

-- Purchase Bills
CREATE TABLE purchase_bills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT NOT NULL,
    bill_number VARCHAR(50) NOT NULL UNIQUE,
    bill_date DATE NOT NULL,
    total_amount DECIMAL(12, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Completed',
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT,
    INDEX idx_bill_number (bill_number),
    INDEX idx_supplier (supplier_id),
    INDEX idx_date (bill_date)
);

-- Purchase Items
CREATE TABLE purchase_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    purchase_bill_id INT NOT NULL,
    medicine_batch_id INT NOT NULL,
    quantity INT NOT NULL,
    rate DECIMAL(12, 2) NOT NULL,
    total DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (purchase_bill_id) REFERENCES purchase_bills(id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_batch_id) REFERENCES medicine_batches(id) ON DELETE RESTRICT
);

-- Purchase Returns
CREATE TABLE purchase_returns (
    id INT PRIMARY KEY AUTO_INCREMENT,
    purchase_bill_id INT NOT NULL,
    return_date DATE NOT NULL,
    total_amount DECIMAL(12, 2) NOT NULL,
    reason VARCHAR(500),
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (purchase_bill_id) REFERENCES purchase_bills(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT
);

-- Purchase Return Items
CREATE TABLE purchase_return_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    purchase_return_id INT NOT NULL,
    medicine_batch_id INT NOT NULL,
    quantity INT NOT NULL,
    rate DECIMAL(12, 2) NOT NULL,
    total DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (purchase_return_id) REFERENCES purchase_returns(id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_batch_id) REFERENCES medicine_batches(id) ON DELETE RESTRICT
);

-- Sales Bills
CREATE TABLE sales_bills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    bill_number VARCHAR(50) NOT NULL UNIQUE,
    bill_date DATE NOT NULL,
    customer_id INT,
    sales_type INT NOT NULL,
    payment_method INT NOT NULL,
    cash_received DECIMAL(12, 2) NOT NULL DEFAULT 0,
    credit_amount DECIMAL(12, 2) NOT NULL DEFAULT 0,
    total_amount DECIMAL(12, 2) NOT NULL,
    discount DECIMAL(12, 2) NOT NULL DEFAULT 0,
    net_amount DECIMAL(12, 2) NOT NULL,
    prescription_id INT,
    status VARCHAR(20) DEFAULT 'Completed',
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT,
    INDEX idx_bill_number (bill_number),
    INDEX idx_customer (customer_id),
    INDEX idx_date (bill_date)
);

-- Sales Items
CREATE TABLE sales_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sales_bill_id INT NOT NULL,
    medicine_batch_id INT NOT NULL,
    quantity INT NOT NULL,
    rate DECIMAL(12, 2) NOT NULL,
    total DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (sales_bill_id) REFERENCES sales_bills(id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_batch_id) REFERENCES medicine_batches(id) ON DELETE RESTRICT
);

-- Sales Returns
CREATE TABLE sales_returns (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sales_bill_id INT NOT NULL,
    return_date DATE NOT NULL,
    total_amount DECIMAL(12, 2) NOT NULL,
    reason VARCHAR(500),
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sales_bill_id) REFERENCES sales_bills(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT
);

-- Sales Return Items
CREATE TABLE sales_return_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sales_return_id INT NOT NULL,
    medicine_batch_id INT NOT NULL,
    quantity INT NOT NULL,
    rate DECIMAL(12, 2) NOT NULL,
    total DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (sales_return_id) REFERENCES sales_returns(id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_batch_id) REFERENCES medicine_batches(id) ON DELETE RESTRICT
);

-- Customer Payments
CREATE TABLE customer_payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method INT NOT NULL,
    reference_number VARCHAR(100),
    notes VARCHAR(500),
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT,
    INDEX idx_customer (customer_id),
    INDEX idx_date (payment_date)
);

-- Supplier Payments
CREATE TABLE supplier_payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method INT NOT NULL,
    reference_number VARCHAR(100),
    notes VARCHAR(500),
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT,
    INDEX idx_supplier (supplier_id),
    INDEX idx_date (payment_date)
);

-- Customer Ledger
CREATE TABLE customer_ledger (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    reference_id INT,
    debit DECIMAL(12, 2) DEFAULT 0,
    credit DECIMAL(12, 2) DEFAULT 0,
    balance DECIMAL(12, 2) NOT NULL DEFAULT 0,
    notes VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    INDEX idx_customer (customer_id),
    INDEX idx_date (created_at)
);

-- Supplier Ledger
CREATE TABLE supplier_ledger (
    id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    reference_id INT,
    debit DECIMAL(12, 2) DEFAULT 0,
    credit DECIMAL(12, 2) DEFAULT 0,
    balance DECIMAL(12, 2) NOT NULL DEFAULT 0,
    notes VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE CASCADE,
    INDEX idx_supplier (supplier_id),
    INDEX idx_date (created_at)
);

-- Customer Medicine History
CREATE TABLE customer_medicine_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    medicine_id INT NOT NULL,
    purchase_date DATE NOT NULL,
    quantity INT NOT NULL,
    estimated_refill_date DATE,
    last_refill_date DATE,
    notes VARCHAR(500),
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE RESTRICT,
    INDEX idx_customer (customer_id),
    INDEX idx_refill (estimated_refill_date)
);

-- Expenses
CREATE TABLE expenses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    amount DECIMAL(12, 2) NOT NULL,
    expense_date DATE NOT NULL,
    payment_method INT,
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT,
    INDEX idx_date (expense_date),
    INDEX idx_category (category)
);

-- Cash Book
CREATE TABLE cash_book (
    id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_date DATE NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    description VARCHAR(500),
    amount DECIMAL(12, 2) NOT NULL,
    balance DECIMAL(12, 2) NOT NULL,
    reference_id INT,
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT,
    INDEX idx_date (transaction_date)
);

-- Bank Transactions
CREATE TABLE bank_transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_type VARCHAR(20) NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    transaction_date DATE NOT NULL,
    description VARCHAR(500),
    reference_number VARCHAR(100),
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT,
    INDEX idx_date (transaction_date)
);

-- Daily Cash Closing
CREATE TABLE daily_cash_closing (
    id INT PRIMARY KEY AUTO_INCREMENT,
    closing_date DATE NOT NULL UNIQUE,
    opening_cash DECIMAL(12, 2) NOT NULL DEFAULT 0,
    sales_cash DECIMAL(12, 2) NOT NULL DEFAULT 0,
    expenses_cash DECIMAL(12, 2) NOT NULL DEFAULT 0,
    closing_cash DECIMAL(12, 2) NOT NULL DEFAULT 0,
    notes VARCHAR(500),
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT,
    INDEX idx_date (closing_date)
);

-- Financial Years
CREATE TABLE financial_years (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL UNIQUE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Notifications
CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    notification_type VARCHAR(50) NOT NULL,
    title VARCHAR(200),
    message LONGTEXT,
    reference_id INT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_created_at (created_at),
    INDEX idx_read (is_read)
);

-- Audit Logs
CREATE TABLE audit_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    action_type INT NOT NULL,
    table_name VARCHAR(100) NOT NULL,
    record_id INT,
    old_values LONGTEXT,
    new_values LONGTEXT,
    performed_by INT NOT NULL,
    performed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (performed_by) REFERENCES users(id) ON DELETE RESTRICT,
    INDEX idx_table (table_name),
    INDEX idx_date (performed_at),
    INDEX idx_user (performed_by)
);

-- Backup History
CREATE TABLE backup_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    backup_date TIMESTAMP NOT NULL,
    backup_file_path VARCHAR(500) NOT NULL,
    backup_size_mb DECIMAL(10, 2),
    backup_type VARCHAR(20),
    status VARCHAR(20) DEFAULT 'Success',
    notes VARCHAR(500),
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT,
    INDEX idx_date (backup_date)
);

-- Insert Default Admin User
INSERT INTO users (username, password_hash, full_name, email, is_active)
VALUES ('admin', '$2a$11$duia3lq.IZsUkrD3TgNfEOCaPQ5hKvkPLnEFBD.ECzIbO5rDL7iXG', 'Admin User', 'admin@medicalshop.local', TRUE);

-- Insert Default Settings
INSERT INTO settings (`key`, `value`, description) VALUES
('ShopName', 'My Medical Shop', 'Name of the shop'),
('ShopAddress', '', 'Shop address'),
('ShopPhone', '', 'Shop phone number'),
('BillFooterMessage', 'Thank you for your visit!', 'Message to display on bills'),
('ExpiryAlertDays', '30,60,90', 'Days for expiry alerts'),
('RefillReminderDays', '30', 'Days for refill reminders'),
('BackupLocation', 'Backups/', 'Backup folder location'),
('FinancialYearStart', '4', 'Financial year start month');

-- Insert Default Units
INSERT INTO units (name, abbreviation) VALUES
('Box', 'Box'),
('Strip', 'Strip'),
('Tablet', 'Tablet'),
('Capsule', 'Capsule'),
('Bottle', 'Bottle'),
('Piece', 'Piece');
