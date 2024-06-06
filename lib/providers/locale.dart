import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localeProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();

  final locale = prefs.get('locale');

  if (locale == null) {
    prefs.setString('locale', 'ar');
    return 'ar';
  } else {
    return locale.toString();
  }
});
