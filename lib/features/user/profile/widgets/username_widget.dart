import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tamweeny/features/user/profile/providers/account_info.dart';

class UsernameWidget extends ConsumerWidget {
  const UsernameWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(accountInfoProvider);

    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: CircleAvatar(
            minRadius: 40,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(
              Icons.person,
              color: Colors.black,
              size: 50,
            ),
          ),
        ),
        const SizedBox(width: 5),
        userData.when(
          data: (data) => Text(data['name'].toString()),
          error: (error, stackTrace) => const SizedBox(),
          loading: () => const SizedBox(),
        ),
        const Spacer(),
      ],
    );
  }
}
