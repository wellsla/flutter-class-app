class ApiConstants {
  static const String baseUrl = 'https://brasilapi.com.br/api';
  static const String holidaysEndpoint = '/feriados/v1/2023';

  static String get holidaysUrl => '$baseUrl$holidaysEndpoint';
}
