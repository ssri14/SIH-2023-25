class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://jade-mushy-lion.cyclic.cloud/user";

  // Receive timeout
  static const Duration receiveTimeout = Duration(seconds: 25);

  // Connection timeout
  static const Duration connectionTimeout = Duration(seconds: 25);

  static const login = "/loginUser";
  static const updateLocation = "/updateLocation/";


}
