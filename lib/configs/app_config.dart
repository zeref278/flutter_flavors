class AppConfig {
  static String baseUrl = '';

  static const String defaultLocale = 'en';

  static void configDev() {
    baseUrl = 'https://f43ea7f6-d185-4998-8f94-01f2a9f954f0.mock.pstmn.io/dev';
  }

  static void configTest() {
    baseUrl =
        'https://f43ea7f6-d185-4998-8f94-01f2a9f954f0.mock.pstmn.io/staging';
  }

  static void configProduction() {
    /// TODO
  }
}
