import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/features/driver/home/widgets/order_widget.dart';
import 'package:tamweeny/generated/l10n.dart';
import 'package:tamweeny/providers/delivered_orders.dart';

class DeliveredOrdersScreen extends ConsumerWidget {
  const DeliveredOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveredOrders = ref.watch(deliveredOrdersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).order_history,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: deliveredOrders.when(
        data: (deliveredOrdersData) {
          return ListView.builder(
            itemCount: deliveredOrdersData.length,
            itemBuilder: (context, index) {
              return OrderWidget(order: deliveredOrdersData[index]);
            },
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(S.of(context).an_error_occurred),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
