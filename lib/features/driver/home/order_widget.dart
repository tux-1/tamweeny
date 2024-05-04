import 'package:flutter/material.dart';

import '../../../Models/order.dart';
import '../../../generated/l10n.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff345E37),
          borderRadius: BorderRadius.circular(11),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 11,
              spreadRadius: -8,
            ),
          ]),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${S.of(context).operation_number} ${order.transactionNumber}",
                  ),
                  const SizedBox(height: 7),
                  Text(
                    S.of(context).name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  _TextDecorator(
                    text: Text(
                      order.customerName,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${S.of(context).date} ${order.transactionDate}',
                  ),
                  const SizedBox(height: 7),
                  Text(S.of(context).telephone_number),
                  _TextDecorator(
                    text: Text(
                      order.customerPhone.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(S.of(context).address),
          _TextDecorator(
            shouldConstrain: false,
            text: Row(
              children: [
                Text(
                  order.customerAddress,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                ),
                onPressed: () {},
                child: Text(S.of(context).order_details),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                ),
                onPressed: () {},
                child: Text(S.of(context).success),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TextDecorator extends StatelessWidget {
  const _TextDecorator({required this.text, this.shouldConstrain = true});

  final bool shouldConstrain;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: shouldConstrain
          ? const BoxConstraints(minWidth: 60, maxWidth: 150)
          : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.white),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Flexible(
            child: text,
          ),
        ],
      ),
    );
  }
}
