using MedicalShopERP.Data;
using MedicalShopERP.Common;
using Microsoft.EntityFrameworkCore;

namespace MedicalShopERP.Business.Services;

public class AuthService : IAuthService
{
    private readonly MedicalShopDbContext _context;

    public AuthService(MedicalShopDbContext context)
    {
        _context = context;
    }

    public async Task<(bool Success, string Message)> LoginAsync(string username, string password)
    {
        try
        {
            var user = await _context.Users
                .FirstOrDefaultAsync(u => u.Username == username);

            if (user == null || !VerifyPassword(password, user.PasswordHash))
            {
                return (false, Constants.ErrorMessages.InvalidCredentials);
            }

            if (!user.IsActive)
            {
                return (false, "User account is inactive.");
            }

            user.LastLoginAt = DateTime.Now;
            await _context.SaveChangesAsync();

            return (true, "Login successful.");
        }
        catch (Exception ex)
        {
            return (false, $"Login error: {ex.Message}");
        }
    }

    public async Task<bool> ValidateCredentialsAsync(string username, string password)
    {
        var user = await _context.Users
            .FirstOrDefaultAsync(u => u.Username == username);

        return user != null && VerifyPassword(password, user.PasswordHash) && user.IsActive;
    }

    public async Task<(bool Success, string Message)> ChangePasswordAsync(string username, string oldPassword, string newPassword)
    {
        try
        {
            var user = await _context.Users
                .FirstOrDefaultAsync(u => u.Username == username);

            if (user == null)
            {
                return (false, Constants.ErrorMessages.RecordNotFound);
            }

            if (!VerifyPassword(oldPassword, user.PasswordHash))
            {
                return (false, "Current password is incorrect.");
            }

            user.PasswordHash = HashPassword(newPassword);
            user.UpdatedAt = DateTime.Now;
            await _context.SaveChangesAsync();

            return (true, Constants.SuccessMessages.RecordUpdated);
        }
        catch (Exception ex)
        {
            return (false, $"Error: {ex.Message}");
        }
    }

    private string HashPassword(string password)
    {
        return BCrypt.Net.BCrypt.HashPassword(password);
    }

    private bool VerifyPassword(string password, string hash)
    {
        return BCrypt.Net.BCrypt.Verify(password, hash);
    }
}
