class AppConfig {
  static String baseUrl = '';

  static const String defaultLocale = 'en';

  static void configDev() {
    baseUrl = 'https://dd47327b-1823-4d83-b642-c64124bc5bd0.mock.pstmn.io/dev';
  }

  static void configTest() {
    baseUrl =
        'https://dd47327b-1823-4d83-b642-c64124bc5bd0.mock.pstmn.io/staging';
  }

  static void configProduction() {
    /// TODO
  }
}
