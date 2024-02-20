// ignore: file_names
class User {
  int? id;
  String? nationalId;
  String? phoneNumber;
  String? name;
  String? email;
  String? password;
  String? passwordConfirmation;
  String? deviceName;
  String? token;
  String? city;
  String? state;
  String? street;
  DateTime? birthDate;
  String? cardName;
  String? cardNumber;
  String? cardNationalId;
  String? cardPassword;

  // Singleton instance
  static final User _instance = User._();

  // Private constructor for the singleton pattern
  User._();

  // Named constructor for creating a User instance with required fields
  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.deviceName,
    this.token,
    this.birthDate,
    this.cardName,
    this.cardNationalId,
    this.cardNumber,
    this.cardPassword,
    this.city,
    this.nationalId,
    this.phoneNumber,
    this.state,
    this.street,
  });

  //Named constructor for creating a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        deviceName: json['device_name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'Name': name,
      'passwordConfirmation': passwordConfirmation,
      'device_name': deviceName,
      'NationalId': nationalId,
      'Phone_number': phoneNumber,
      'City': city,
      'State': state,
      'Street': street,
      'BirthDate': birthDate?.toIso8601String(), // Corrected line
      'cardName': cardName,
      'cardNumber': cardNumber,
      'cardNationalId': cardNationalId,
      'cardPassword': cardPassword,
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
