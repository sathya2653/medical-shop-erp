# Medical Shop ERP

## Overview

Medical Shop ERP is a production-grade Windows Desktop application designed specifically for retail pharmacy and medical shops. It provides comprehensive management of medicine inventory, billing, customer credit, supplier management, and financial reporting.

## Key Features

### 💊 Medicine & Inventory Management
- Batch-wise stock tracking with FIFO costing
- Multiple unit support (Box, Strip, Tablet, Capsule, Bottle, Piece)
- Unit conversion management
- Expiry date tracking with automatic alerts (30/60/90 days)
- Low stock alerts and automated reordering
- Stock movements history and ledger

### 💳 Billing & Sales
- Fast medicine search and billing
- Support for Cash, Credit, and Partial Payment sales
- Multiple payment methods (Cash, UPI)
- Financial Year-based bill numbering (2026-27/INV000001)
- Bill printing and reprinting
- Sales returns management
- Prescription tracking

### 👥 Customer Management
- Customer ledger with payment history
- Credit system with outstanding balance tracking
- Customer refill reminders (auto-calculated based on medicine usage)
- Due reports and payment tracking

### 🏭 Supplier Management
- Supplier ledger and payment history
- Purchase bill tracking
- Outstanding balance reports
- Purchase returns management

### 📊 Financial Management
- Profit & Loss reporting (Daily, Monthly, Yearly)
- FIFO-based inventory costing
- Cash book management
- Expense tracking
- Bank transactions
- Daily cash closing

### 📈 Reports & Analytics
- Sales reports (Daily, Monthly, Yearly)
- Purchase reports
- Inventory reports (Stock, Expiry, Low Stock)
- Customer and Supplier reports
- Export to PDF and Excel

### 🔒 Security & Audit
- Single admin user authentication
- Comprehensive audit logging (Insert, Update, Delete)
- Backup management (Manual and Automatic)
- Backup history tracking

## Technology Stack

- **Platform**: Windows Desktop
- **Framework**: .NET 9
- **Language**: C#
- **UI Framework**: WPF with Material Design
- **Architecture**: MVVM
- **Database**: MySQL 8.0
- **ORM**: Entity Framework Core
- **PDF Generation**: QuestPDF
- **Deployment**: Single-PC Installation

## Project Structure

```
MedicalShopERP/
├── src/
│   ├── MedicalShopERP.Common/           # Shared utilities and helpers
│   ├── MedicalShopERP.Data/             # Database layer (EF Core models)
│   ├── MedicalShopERP.Business/         # Business logic and services
│   └── MedicalShopERP.UI/               # WPF user interface
├── Database/
│   ├── Schema.sql                       # MySQL database schema
│   └── StoredProcedures.sql            # Database stored procedures
├── docs/
│   └── Installation.md                  # Setup and installation guide
└── README.md                            # This file
```

## Database Schema

The application uses 30+ normalized MySQL tables including:

- **Core Masters**: medicines, categories, manufacturers, suppliers, customers, doctors
- **Inventory**: medicine_batches, stock_movements, stock_adjustments
- **Transactions**: purchase_bills, sales_bills, customer_payments, supplier_payments
- **Ledgers**: customer_ledger, supplier_ledger, stock_ledger
- **Financial**: expenses, cash_book, bank_transactions, daily_cash_closing
- **System**: users, audit_logs, backup_history, notifications, settings

## Installation

### Prerequisites
- Windows 10/11
- .NET 9 Runtime
- MySQL Server 8.0
- Visual Studio 2022 (for development)

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/sathya2653/medical-shop-erp.git
   cd medical-shop-erp
   ```

2. **Setup MySQL Database**
   - Create a MySQL database: `medical_shop_erp`
   - Execute `Database/Schema.sql` to create tables
   - Execute `Database/StoredProcedures.sql`

3. **Configure Connection String**
   - Open `src/MedicalShopERP.UI/appsettings.json`
   - Update MySQL connection string with your server details

4. **Build Solution**
   ```bash
   dotnet build
   ```

5. **Run Application**
   - Set `MedicalShopERP.UI` as startup project
   - Press F5 or click Run

## Default Admin Credentials

- **Username**: `admin`
- **Password**: `Admin@123`

*Change password immediately after first login*

## Configuration

Application settings can be configured from the Settings module:

- Shop Name and Address
- Bill Footer Message
- Expiry Alert Days (default: 30, 60, 90)
- Refill Reminder Days (default: 30)
- Backup Location
- Financial Year Settings

## Usage Guide

### Quick Start - Daily Operations

1. **Login** with admin credentials
2. **Dashboard** shows today's sales, profit, low stock, and expiry alerts
3. **New Sale**:
   - Go to Sales → New Bill
   - Search and add medicines
   - Select payment method
   - Print or save bill
4. **Customer Credit**:
   - Allow partial payment during billing
   - Track in Customers → Customer Ledger
   - Mark payment when received
5. **Inventory**:
   - Monitor low stock from Dashboard
   - Create purchase order from Purchases module
6. **Reports**:
   - Generate P&L, sales, inventory reports
   - Export to PDF or Excel

## Features by Module

### Dashboard
- Today's/Monthly Sales & Profit
- Low Stock Count
- Expiry Alerts (30/60/90 days)
- Customer & Supplier Due Amounts
- Refill Reminders
- Recent Bills

### Masters
- Medicines, Categories, Manufacturers
- Customers, Suppliers, Doctors
- Medicine Units and Conversions
- Medicine Substitutes

### Purchases
- New Purchase Entry
- Purchase History
- Supplier Ledger
- Purchase Returns

### Sales
- Fast Billing (Cash/Credit/Partial)
- Bill History and Search
- Bill Printing
- Sales Returns

### Inventory
- Batch Management
- Stock Ledger
- Stock Adjustments
- Expiry Management

### Customers
- Customer Master
- Customer Ledger
- Payment History
- Refill Reminders
- Due Reports

### Suppliers
- Supplier Master
- Supplier Ledger
- Payment History
- Outstanding Balance

### Accounts
- Cash Book
- Expense Tracking
- Bank Transactions
- Daily Cash Closing

### Reports
- Sales Reports (Daily/Monthly/Yearly)
- Purchase Reports
- Inventory Reports
- Customer/Supplier Reports
- P&L Statement
- Export to PDF/Excel

### Settings
- User Management
- Shop Configuration
- Backup Management
- System Settings
- Audit Logs

## System Requirements

- **OS**: Windows 10/11 (64-bit)
- **RAM**: 4 GB minimum (8 GB recommended)
- **Disk**: 500 MB minimum
- **Database**: MySQL 8.0
- **Framework**: .NET 9 Runtime

## Performance Considerations

- Batch operations optimized for large inventories
- Indexed database queries for fast searches
- FIFO costing algorithm optimized for calculation speed
- Responsive UI with async operations
- Automatic backup scheduling

## Security Features

- Admin authentication with password hashing
- Role-based access control (ready for future expansion)
- Comprehensive audit logging
- Data backup and recovery
- Transaction integrity

## Troubleshooting

### Database Connection Issues
- Verify MySQL server is running
- Check connection string in `appsettings.json`
- Ensure database and user have proper permissions

### Slow Performance
- Check MySQL query performance
- Verify database indexes are created
- Check available disk space

### Backup Issues
- Verify backup location has write permissions
- Check disk space for backup file
- Ensure MySQL backup tools are installed

## Support & Contribution

For issues, feature requests, or contributions, please:
1. Create an issue on GitHub
2. Provide detailed description
3. Include screenshots or error logs

## License

MIT License - See LICENSE file for details

## Roadmap

- [ ] Multi-user support with role-based access
- [ ] Cloud backup integration
- [ ] Mobile app for inventory tracking
- [ ] Advanced analytics and dashboards
- [ ] Barcode/QR code scanning
- [ ] Integration with online pharmacies
- [ ] Customer loyalty program
- [ ] GST compliance reporting

## Author

Developed for standalone retail pharmacy management.

---

**Version**: 1.0.0  
**Last Updated**: 2026-07-09  
**Status**: Production Ready
