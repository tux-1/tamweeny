import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../Models/cart_item.dart';

class CheckoutItem extends StatelessWidget {
  const CheckoutItem({super.key, required this.cartItem});
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.black,
        ),
      ),
      key: Key(cartItem.id.toString()),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      cartItem.productName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          cartItem.quantity.toString(),
                          style: const TextStyle(
                            color: Color(0xffDEA568),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.white,
                          ),
                        ),
                        Text(cartItem.totalPrice.toString()),
                      ],
                    ),
                  ],
                ),
              ),

              // Image
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                height: 85,
                width: 85,
                child: Image.network(
                  'https://media.istockphoto.com/id/153737841/photo/rice.jpg?s=612x612&w=0&k=20&c=lfO7iLT0UsDDzra0uBOsN1rvr2d5OEtrG2uwbts33_c=',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(endIndent: 15, indent: 15),
        ],
      ),
    );
  }
}
