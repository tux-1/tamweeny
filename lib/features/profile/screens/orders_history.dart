import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/generated/l10n.dart';

import '../../../widgets/custom_scaffold.dart';
import '../providers/history.dart';

class OrdersHistoryScreen extends ConsumerWidget {
  const OrdersHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyData = ref.watch(ordersHistoryProvider.future);

    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).order_history,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.history,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: historyData,
        builder: (context, snapshot) {
          final ordersList = snapshot.data ?? [];

          return ListView.builder(
            itemCount: ordersList.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xff609966).withOpacity(0.88),
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    Text(
                      '${S.of(context).operation_number} ${ordersList[index].id}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ordersList[index].orderDate,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      S.of(context).success,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
