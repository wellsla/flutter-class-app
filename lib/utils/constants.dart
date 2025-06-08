const URL_MOCKAPI = "https://6840cac8d48516d1d3597297.mockapi.io";
class ApiConstants {
  static const String baseUrl = 'https://brasilapi.com.br/api';
  static const String holidaysEndpoint = '/feriados/v1/2023';

  static String get holidaysUrl => '$baseUrl$holidaysEndpoint';
}
