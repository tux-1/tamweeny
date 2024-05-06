import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tamweeny/features/driver/driver_landing_view.dart';
import 'package:tamweeny/providers/pending_orders.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/token_manager.dart';

class DeliverOrderButton extends ConsumerWidget {
  const DeliverOrderButton({super.key, required this.orderId});

  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
      ),
      onPressed: () async {
        final token = await TokenManager.getToken();

        await http.post(
          Uri.parse('http://10.0.2.2:8000/api/order/$orderId'),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ).then((value) {
          // ignore: unused_result
          ref.refresh(pendingOrdersProvider);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(S.of(context).success)));
          Navigator.of(context)
              .popUntil(ModalRoute.withName(DriverLandingView.routeName));
        }).onError((error, stackTrace) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).an_error_occurred)));
        });
      },
      child: Text(S.of(context).success),
    );
  }
}
