///Live Server
// const String _baseUrl = 'https://devapi.propsoft.ai';

///Test Server
const String _baseUrl = 'https://devapi.propsoft.ai';

class ApiEndpoints {
  ApiEndpoints._();

  /// Authentications
  static Uri userLogin() => Uri.parse('$_baseUrl/api/interview/login');

  /// Dashboard
  static Uri getPurchaseData(int page) => Uri.parse('$_baseUrl/api/auth/interview/material-purchase?page=$page');
  static Uri purchaseRequest() => Uri.parse('$_baseUrl/api/auth/interview/material-purchase');
}
