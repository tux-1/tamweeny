import 'package:http/http.dart' as http;

import '../../../models/exceptions.dart';
import '../../../utils/token_manager.dart';

Future<void> updateAccountInfo({
  required String name,
  required String phoneNumber,
  required String birthDate,
  required String street,
}) async {
  // Getting the token
  final token = await TokenManager.getToken();

  final response = await http
      .patch(Uri.parse('http://10.0.2.2:8000/api/updateAccInfo'), headers: {
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  }, body: {
    'name': name,
    'phoneNumber': phoneNumber,
    'birthDate': birthDate,
    'street': street,
  });

  if (!response.body.contains('successful')) {
    throw HttpException('Error occured');
  }
}
