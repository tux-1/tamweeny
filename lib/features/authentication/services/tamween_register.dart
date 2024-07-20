import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<void> registerToTamween({
  required String name,
  required String gender,
  required String email,
  required String socialStatus,
  required num salary,
  required int phoneNumber,
  required List<List<int>> nationalIdCardAndBirthCertificate,
  required List<List<int>> followersNationalIdCardsAndBirthCertificates,
  required String nationalIdNumber,
}) async {
  final registerUrl = Uri.parse(
    'http://10.0.2.2:8000/api/cardRegistration',
  );

  final request = http.MultipartRequest('POST', registerUrl)
    ..headers.addAll({
      'Accept': 'application/json',
      "Content-Type": "application/x-www-form-urlencoded",
    })
    ..fields['name'] = name
    ..fields['gender'] = gender
    ..fields['email'] = email
    ..fields['socialStatus'] = socialStatus
    ..fields['salary'] = salary.toString()
    ..fields['phoneNumber'] = phoneNumber.toString()
    ..fields['nationalId'] = nationalIdNumber
    ..files.addAll([
      for (final file in nationalIdCardAndBirthCertificate)
        http.MultipartFile.fromBytes(
          'nationalIdCardAndBirthCertificate[]',
          file,
          filename:
              'nationalIdCardAndBirthCertificate${nationalIdCardAndBirthCertificate.indexOf(file)}',
        ),
    ])
    ..files.addAll([
      for (final file in followersNationalIdCardsAndBirthCertificates)
        http.MultipartFile.fromBytes(
          'followersNationalIdCardsAndBirthCertificates[]',
          file,
          filename:
              'followersNationalIdCardsAndBirthCertificates${followersNationalIdCardsAndBirthCertificates.indexOf(file)}',
        ),
    ]);

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);
  final responseJson = jsonDecode(response.body);

  if (bool.parse(responseJson['success']) == false) {
    throw Exception(responseJson['message']);
  }

  if (kDebugMode) {
    print('Status Code: ${response.statusCode}');
    print('Response Headers: ${response.headers}');
    print('Response Body: ${response.body}');
  }

  if (response.statusCode == 302) {
    final redirectUrl = response.headers['location'];
    if (redirectUrl != null) {
      final redirectRequest =
          http.MultipartRequest('POST', Uri.parse(redirectUrl))
            ..fields['name'] = name
            ..fields['gender'] = gender
            ..fields['email'] = email
            ..fields['socialStatus'] = socialStatus
            ..fields['salary'] = salary.toString()
            ..fields['phoneNumber'] = phoneNumber.toString()
            ..fields['nationalId'] = nationalIdNumber
            ..files.addAll([
              for (final file in nationalIdCardAndBirthCertificate)
                http.MultipartFile.fromBytes(
                  'nationalIdCardAndBirthCertificate',
                  file,
                  filename:
                      'nationalIdCardAndBirthCertificate${nationalIdCardAndBirthCertificate.indexOf(file)}',
                ),
            ])
            ..files.addAll([
              for (final file in followersNationalIdCardsAndBirthCertificates)
                http.MultipartFile.fromBytes(
                  'followersNationalIdCardsAndBirthCertificates[]',
                  file,
                  filename:
                      'followersNationalIdCardsAndBirthCertificates${followersNationalIdCardsAndBirthCertificates.indexOf(file)}',
                ),
            ]);

      final redirectResponse = await redirectRequest.send();
      if (kDebugMode) {
        print('Redirect Status Code: ${redirectResponse.statusCode}');
        print('Redirect Response: ${redirectResponse.toString()}');
      }
    }
  }
}
