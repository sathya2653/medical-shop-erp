namespace MedicalShopERP.Common.Helpers;

public static class DateHelper
{
    public static string GetFinancialYear(DateTime date)
    {
        int year = date.Year;
        int month = date.Month;
        
        if (month >= Constants.FinancialYearStartMonth)
        {
            return $"{year}-{year + 1 % 100}";
        }
        else
        {
            return $"{year - 1}-{year % 100}";
        }
    }
    
    public static (DateTime Start, DateTime End) GetFinancialYearRange(DateTime date)
    {
        int year = date.Year;
        int month = date.Month;
        
        DateTime start, end;
        
        if (month >= Constants.FinancialYearStartMonth)
        {
            start = new DateTime(year, Constants.FinancialYearStartMonth, 1);
            end = new DateTime(year + 1, Constants.FinancialYearStartMonth - 1, DateTime.DaysInMonth(year + 1, Constants.FinancialYearStartMonth - 1));
        }
        else
        {
            start = new DateTime(year - 1, Constants.FinancialYearStartMonth, 1);
            end = new DateTime(year, Constants.FinancialYearStartMonth - 1, DateTime.DaysInMonth(year, Constants.FinancialYearStartMonth - 1));
        }
        
        return (start, end);
    }
    
    public static bool IsWithinDays(DateTime targetDate, int days)
    {
        return targetDate <= DateTime.Now.AddDays(days) && targetDate >= DateTime.Now;
    }
}
