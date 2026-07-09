# Installation & Setup Guide

## Prerequisites

1. **Windows 10/11**
2. **.NET 9 SDK** - https://dotnet.microsoft.com/download/dotnet/9.0
3. **MySQL Server 8.0** - https://dev.mysql.com/downloads/mysql/
4. **Visual Studio 2022** (optional) - https://visualstudio.microsoft.com/
5. **Git** - https://git-scm.com/

---

## Step 1: Clone Repository

```bash
git clone https://github.com/sathya2653/medical-shop-erp.git
cd medical-shop-erp
```

---

## Step 2: Setup MySQL Database

### Option A: Using MySQL Command Line (Windows)

1. Open **Command Prompt** (cmd.exe)
2. Connect to MySQL:
   ```cmd
   mysql -u root -p
   ```
3. When prompted, enter your MySQL root password
4. Copy and paste the entire content of `Database/Schema.sql`
5. Press Enter to execute

### Option B: Using MySQL Workbench (Easier)

1. Open **MySQL Workbench**
2. Connect to your MySQL server
3. Go to **File** → **Open SQL Script**
4. Select `Database/Schema.sql` from the project folder
5. Click **Open**
6. Click the **Lightning Bolt** icon (⚡) to execute
7. Wait for completion (you'll see "Execution finished without errors")

### Option C: Using Command Line (Direct Execution)

Open **Command Prompt** in your project folder and run:

```cmd
mysql -u root -p medical_shop_erp < Database\Schema.sql
```

When prompted, enter your MySQL root password.

---

## Step 3: Update Connection String

1. Open the file: `src/MedicalShopERP.UI/appsettings.json`
2. Replace `YOUR_MYSQL_PASSWORD` with your actual MySQL root password

**Example:**
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Database=medical_shop_erp;User=root;Password=mypassword123;Port=3306;"
  }
}
```

---

## Step 4: Open Solution in Visual Studio

1. Open **Visual Studio 2022**
2. Click **File** → **Open** → **Project/Solution**
3. Navigate to the cloned folder
4. Select **MedicalShopERP.sln**
5. Click **Open**

Visual Studio will load the solution with 4 projects.

---

## Step 5: Restore NuGet Packages

1. In Visual Studio, go to **Tools** → **NuGet Package Manager** → **Package Manager Console**
2. Run this command:
   ```powershell
   dotnet restore
   ```
3. Wait for all packages to download and install

---

## Step 6: Build the Solution

1. In Visual Studio, press `Ctrl + Shift + B` or go to **Build** → **Build Solution**
2. Wait for the build to complete (you should see "Build: 1 succeeded, 0 failed" at the bottom)

---

## Step 7: Set Startup Project

1. In **Solution Explorer**, right-click on **MedicalShopERP.UI**
2. Select **Set as Startup Project**

---

## Step 8: Run the Application

1. Press **F5** or click the **Run** button (green play icon) at the top
2. The application will launch in a window

---

## Login

**Default Credentials:**
- Username: `admin`
- Password: `Admin@123`

⚠️ **IMPORTANT**: Change your password immediately after first login!

Go to **Settings** → **User Management** → **Change Password**

---

## Troubleshooting

### "Cannot connect to database"

**Solution:**
1. Verify MySQL is running (check Windows Services)
2. Open Command Prompt and test:
   ```cmd
   mysql -u root -p -e "SELECT VERSION();"
   ```
3. Check that password in `appsettings.json` is correct
4. Verify database exists:
   ```cmd
   mysql -u root -p -e "SHOW DATABASES;"
   ```

### "Project files not found" error

**Solution:**
1. Verify you cloned the entire repository
2. Check that all folders are present:
   - `src/MedicalShopERP.Common/`
   - `src/MedicalShopERP.Data/`
   - `src/MedicalShopERP.Business/`
   - `src/MedicalShopERP.UI/`
3. Run `git status` to check repository state

### "NuGet package restore fails"

**Solution:**
1. Clear NuGet cache:
   ```powershell
   dotnet nuget locals all --clear
   ```
2. Restore packages again:
   ```powershell
   dotnet restore
   ```
3. Check internet connection

### "Application won't start"

**Solution:**
1. Check Build output for errors (View → Output)
2. Verify all dependencies are installed
3. Try Clean and Rebuild:
   - Right-click Solution → Clean Solution
   - Right-click Solution → Rebuild Solution

### MySQL password not working

**Solution:**
1. Reset MySQL root password:
   ```cmd
   mysql -u root
   ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
   FLUSH PRIVILEGES;
   EXIT;
   ```
2. Update `appsettings.json` with new password
3. Restart Visual Studio

---

## After Successful Login

1. **Change Admin Password**
   - Settings → User Management → Change Password

2. **Configure Shop Settings**
   - Settings → Application Settings
   - Enter your shop name, address, phone

3. **Add Masters** (Required for operations)
   - Masters → Medicine Categories
   - Masters → Manufacturers
   - Masters → Medicines
   - Masters → Customers
   - Masters → Suppliers

4. **Test First Purchase**
   - Purchases → New Purchase Bill
   - Add a medicine with batch details

5. **Test First Sale**
   - Sales → New Bill
   - Search and add medicine
   - Complete payment

---

## Useful Commands

```bash
# View .NET version
dotnet --version

# Check database connection
mysql -u root -p -e "SELECT DATABASE();"

# View running processes
tasklist | findstr mysql

# Clean build
dotnet clean

# Build only (without running)
dotnet build

# Run from command line
dotnet run --project src/MedicalShopERP.UI
```

---

## System Requirements

- **RAM**: Minimum 2GB (4GB+ recommended)
- **Disk**: 500MB for application + dependencies
- **MySQL**: Running and accessible
- **.NET 9**: SDK installed
- **Windows**: 10/11 (64-bit)

---

## Getting Help

If you encounter issues:

1. Check the troubleshooting section above
2. Verify all prerequisites are installed
3. Check MySQL is running and accessible
4. Ensure appsettings.json has correct connection string
5. Look at the application output window for error details

---

**Version**: 1.0.0  
**Last Updated**: 2026-07-09  
**Status**: Ready to Run
