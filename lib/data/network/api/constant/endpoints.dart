class Endpoints {
  Endpoints._();

  //api key
  static const String API_KEY = '';
  // base url
  static const String baseNewsUrl = "https://jade-mushy-lion.cyclic.cloud";
  static const String news = "/news";

  // Receive timeout
  static const Duration receiveTimeout = Duration(seconds: 25);

  // Connection timeout
  static const Duration connectionTimeout = Duration(seconds: 25);

}
