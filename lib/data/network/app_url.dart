class AppUrl {
  static const String baseUrl = "http://192.168.1.12:8000";
  //!                                Authentication
  static const String loginUrl = "$baseUrl/reevauth/login/";
  static const String register = "$baseUrl/auth/register/";
  static const String logoutUrl = '$baseUrl/auth/logout/';
  static const String refreshToken = '$baseUrl/reevauth/token/refresh/';

  //!                                RESTRO
  static const String profile = "$baseUrl/auth/profile/";
  static const String employee = "$baseUrl/main/users/";
  static const String banners = "$baseUrl/main/banners/";
  static const String privacyUrl = "$baseUrl/restro/privacy/";
  static const String termsUrl = "$baseUrl/restro/terms/";
  static const String info = "$baseUrl/restro/aboutus/";
  static const String ourteam = "$baseUrl/restro/ourteam/";
  static const String items = "$baseUrl/main/items/";
  static const String payment = "$baseUrl/main/payments/";
  static const String tables = "$baseUrl/main/tables/";
  static const String orders = "$baseUrl/main/orders/";
  static const String dashboard = "$baseUrl/main/dashboard/dashboard/";
}
