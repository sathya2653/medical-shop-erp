using System.Windows;
using MedicalShopERP.Business.Services;

namespace MedicalShopERP.UI
{
    public partial class MainWindow : Window
    {
        private readonly IAuthService _authService;

        public MainWindow(IAuthService authService)
        {
            InitializeComponent();
            _authService = authService;
        }

        private async void LoginButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                LoginButton.IsEnabled = false;
                StatusMessage.Text = "Logging in...";

                string username = UsernameTextBox.Text;
                string password = PasswordBox.Password;

                if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
                {
                    StatusMessage.Text = "Please enter username and password";
                    LoginButton.IsEnabled = true;
                    return;
                }

                var user = await _authService.AuthenticateAsync(username, password);

                if (user != null)
                {
                    MessageBox.Show($"Welcome {user.Username}!", "Login Successful", MessageBoxButton.OK, MessageBoxImage.Information);
                    // TODO: Navigate to dashboard
                    StatusMessage.Text = "";
                }
                else
                {
                    StatusMessage.Text = "Invalid username or password";
                }
            }
            catch (Exception ex)
            {
                StatusMessage.Text = $"Error: {ex.Message}";
            }
            finally
            {
                LoginButton.IsEnabled = true;
            }
        }
    }
}
