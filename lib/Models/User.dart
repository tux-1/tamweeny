class User {
  int? Id;
  String? NationalId;
  String? Phone_number;
  String? Name;
  String? email;
  String? password;
  String? password_confirmation;
  String? deviceName;
  String? token;
  String? City;
  String? State;
  String? Street;
  DateTime? BirthDate;
  String? CardName;
  String? CardNumber;
  String? CardNationalId;
  String? CardPassword;

  // Singleton instance
  static final User _instance = User._();

  // Private constructor for the singleton pattern
  User._();

  // Named constructor for creating a User instance with required fields
  User(
      {this.Id,
      this.Name,
      this.email,
      this.password,
      this.password_confirmation,
      this.deviceName,
      this.token,
      this.BirthDate,
      this.CardName,
      this.CardNationalId,
      this.CardNumber,
      this.CardPassword,
      this.City,
      this.NationalId,
      this.Phone_number,
      this.State,
      this.Street});

  //Named constructor for creating a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        Id: json['Id'],
        Name: json['Name'],
        email: json['email'],
        password: json['password'],
        deviceName: json['device_name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'Name': Name,
      'password_confirmation': password_confirmation,
      'device_name': deviceName,
      'NationalId': NationalId,
      'Phone_number': Phone_number,
      'City': City,
      'State': State,
      'Street': Street,
      'BirthDate': BirthDate?.toIso8601String(), // Corrected line
      'CardName': CardName,
      'CardNumber': CardNumber,
      'CardNationalId': CardNationalId,
      'CardPassword': CardPassword,
    };
  }

  // Method to set the token
  void setToken(String newToken) {
    token = newToken;
  }

  // Method to retrieve the token
  String? getToken() {
    return token;
  }

  String? device() {
    return deviceName;
  }

  // Method to store the user's token

  User getInstance() {
    return _instance;
  }
}
