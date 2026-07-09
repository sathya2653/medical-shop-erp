namespace MedicalShopERP.Business.Services;

public interface IAuthService
{
    Task<(bool Success, string Message)> LoginAsync(string username, string password);
    Task<bool> ValidateCredentialsAsync(string username, string password);
    Task<(bool Success, string Message)> ChangePasswordAsync(string username, string oldPassword, string newPassword);
}
