import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../providers/locale.dart';

class LocaleSwitchTile extends ConsumerWidget {
  const LocaleSwitchTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeFuture = ref.watch(localeProvider);
    return localeFuture.when(
      data: (locale) => SwitchListTile(
        title: Row(
          children: [
            const Icon(Icons.language),
            const SizedBox(width: 16),
            locale == 'ar' ? const Text('عربي') : const Text('English'),
          ],
        ),
        value: locale == 'ar',
        onChanged: (_) async {
          final prefs = await SharedPreferences.getInstance();
          if (locale == 'ar') {
            prefs.setString('locale', 'en');
          } else if (locale == 'en') {
            prefs.setString('locale', 'ar');
          }
          ref.invalidate(localeProvider);
        },
      ),
      error: (error, stackTrace) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }
}
