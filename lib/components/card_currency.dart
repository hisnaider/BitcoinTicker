import 'package:flutter/material.dart';

class CardCurrency extends StatelessWidget {
  final String currency;
  final String value;
  final String crypto;
  const CardCurrency(
      {required this.currency,
      required this.value,
      required this.crypto,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            "1 $crypto = $value $currency",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
