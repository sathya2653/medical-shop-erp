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
    }
}
