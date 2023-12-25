class TokenManager {
  String? _token;

  // Singleton instance
  static final TokenManager _instance = TokenManager._();

  // Factory constructor to get the instance
  factory TokenManager() {
    return _instance;
  }

  TokenManager._();

  // Method to set the token
  void setToken(String newToken) {
    _token = newToken;
  }

  // Method to retrieve the token
  String? getToken() {
    return _token;
  }
}
