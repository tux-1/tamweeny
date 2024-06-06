import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/features/driver/home/widgets/order_widget.dart';
import 'package:tamweeny/generated/l10n.dart';
import 'package:tamweeny/providers/pending_orders.dart';

class DriverHomePage extends ConsumerWidget {
  const DriverHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(pendingOrdersProvider);
    return Column(
      children: [
        Center(
          child: Text(
            S.of(context).today_orders_list,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        Expanded(
          child: orders.when(
            data: (orderData) {
              return ListView.builder(
                itemCount: orderData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: OrderWidget(order: orderData[index]),
                  );
                },
              );
            },
            error: (error, stackTrace) {
              return Center(
                child: Text(S.of(context).an_error_occurred),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
          ),
        )
      ],
    );
  }
}
