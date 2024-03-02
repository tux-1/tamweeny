import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';
import '../../../providers/cart.dart';

class CheckoutData extends ConsumerWidget {
  final double totalAmount;
  const CheckoutData({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                S.of(context).total_payments,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: const Color(0xffDEA568)),
              ),
              Text(
                totalAmount.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: const Color(0xffDEA568)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(width: 15),
              Flexible(
                fit: FlexFit.tight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).add_more),
                ),
              ),
              const SizedBox(width: 15),
              Flexible(
                fit: FlexFit.tight,
                child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(asyncCartProvider.notifier)
                        .createOrder()
                        .then((value) {
                      return ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(S.of(context).order_success),
                        ),
                      );
                    });
                  },
                  child: Text(S.of(context).checkout),
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
