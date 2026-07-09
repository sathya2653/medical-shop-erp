namespace MedicalShopERP.Common;

public static class Constants
{
    public const string AppName = "Medical Shop ERP";
    public const string AppVersion = "1.0.0";
    public const string DefaultAdminUsername = "admin";
    public const string DefaultAdminPassword = "Admin@123";
    
    // Expiry Alert Days
    public const int ExpiryAlert30Days = 30;
    public const int ExpiryAlert60Days = 60;
    public const int ExpiryAlert90Days = 90;
    
    // Refill Reminder Days
    public const int DefaultRefillReminderDays = 30;
    
    // Bill Numbering
    public const string BillNumberFormat = "yyyy-yy/INV{0:D6}";
    
    // Financial Year
    public const int FinancialYearStartMonth = 4; // April
    
    public static class DateFormats
    {
        public const string DateFormat = "dd/MM/yyyy";
        public const string DateTimeFormat = "dd/MM/yyyy HH:mm:ss";
        public const string TimeFormat = "HH:mm:ss";
    }
    
    public static class ErrorMessages
    {
        public const string DatabaseConnectionError = "Unable to connect to database. Please check your connection settings.";
        public const string InvalidCredentials = "Invalid username or password.";
        public const string UnauthorizedAccess = "You do not have permission to perform this action.";
        public const string RecordNotFound = "The requested record was not found.";
        public const string DuplicateRecord = "A record with this information already exists.";
        public const string ValidationError = "Please check your input and try again.";
    }
    
    public static class SuccessMessages
    {
        public const string RecordSaved = "Record saved successfully.";
        public const string RecordUpdated = "Record updated successfully.";
        public const string RecordDeleted = "Record deleted successfully.";
        public const string BackupCreated = "Backup created successfully.";
    }
}

public enum PaymentMethod
{
    Cash = 1,
    UPI = 2,
    Card = 3,
    Cheque = 4
}

public enum SalesType
{
    Cash = 1,
    Credit = 2,
    PartialPayment = 3
}

public enum StockMovementType
{
    Purchase = 1,
    Sale = 2,
    PurchaseReturn = 3,
    SaleReturn = 4,
    Adjustment = 5
}

public enum AuditActionType
{
    Insert = 1,
    Update = 2,
    Delete = 3,
    View = 4
}
