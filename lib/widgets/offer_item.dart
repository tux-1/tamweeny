import 'package:flutter/material.dart';

class OfferItem extends StatelessWidget {
  const OfferItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: const Color(0xff335145),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {},
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * 0.45,
            maxWidth: MediaQuery.of(context).size.width * 0.45,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  'Offer name',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              Text(
                '20%',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffDEA568)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
