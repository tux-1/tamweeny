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

  await request.send().then((response) {
    // if (response.statusCode == 200) print("Uploaded!");
    if (kDebugMode) {
      print(response.toString());
    }
  }).onError(
    (error, stackTrace) {
      if (kDebugMode) {
        print('An error occured');
      }
    },
  );
}
