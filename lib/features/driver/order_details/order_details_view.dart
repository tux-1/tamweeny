import 'package:flutter/material.dart';
import 'package:tamweeny/Models/order.dart';
import 'package:tamweeny/features/driver/home/widgets/deliver_order_button.dart';
import 'package:tamweeny/generated/l10n.dart';
import 'package:tamweeny/widgets/custom_textformfield.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${S.of(context).operation_number} ${order.id}",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                Text(S.of(context).name),
                CustomTextField(
                  readOnly: true,
                  initialValue: order.customerName,
                ),
                const SizedBox(height: 5),
                Text(S.of(context).telephone_number),
                CustomTextField(
                  readOnly: true,
                  initialValue: order.customerPhone,
                ),
                const SizedBox(height: 5),
                Text(S.of(context).address),
                CustomTextField(
                  readOnly: true,
                  initialValue: order.customerAddress,
                ),
                const SizedBox(height: 5),
                DataTable(
                  border: const TableBorder(
                    bottom: BorderSide(color: Colors.white70),
                  ),
                  columns: [
                    DataColumn(
                      label: Text(
                        S.of(context).product_name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        S.of(context).quantity,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        S.of(context).price,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    order.ordersMade.length,
                    (index) {
                      return DataRow(
                        cells: List<DataCell>.generate(
                          3,
                          (rowIndex) {
                            switch (rowIndex) {
                              case 0:
                                return DataCell(
                                  Text(order.ordersMade[index].productName),
                                );
                              case 1:
                                return DataCell(
                                  Text(order.ordersMade[index].quantity
                                      .toString()),
                                );
                              case 2:
                                return DataCell(
                                  Text(order.ordersMade[index].totalPrice
                                      .toString()),
                                );
                            }
                            return const DataCell(SizedBox.shrink());
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.of(context).total_payments),
                          Text(order.orderPrice),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(S.of(context).operation_number),
                          Text(order.transactionNumber.toString()),
                          const Spacer(),
                          Text(order.transactionDate),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (order.deliveryStatus == "Pending")
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DeliverOrderButton(orderId: order.id),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
