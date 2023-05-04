import 'package:bitcoin_ticker/classes/coin_class.dart';
import 'package:flutter/material.dart';

class DropDownPicker extends StatelessWidget {
  final CoinClass coinClass;
  final Function updateCurrentCurrency;
  const DropDownPicker(
      {required this.coinClass,
      required this.updateCurrentCurrency,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.inverseSurface,
      width: 500,
      padding: const EdgeInsets.all(15),
      child: DropdownButton(
        onChanged: (String? value) {
          updateCurrentCurrency(value);
        },
        iconEnabledColor: Theme.of(context).colorScheme.surface,
        underline: const SizedBox.shrink(),
        isExpanded: true,
        dropdownColor: Theme.of(context).colorScheme.inverseSurface,
        alignment: AlignmentDirectional.center,
        value: coinClass.getCurrentCurrency(),
        icon: const Icon(Icons.arrow_upward),
        iconSize: 24,
        elevation: 5,
        menuMaxHeight: 500,
        isDense: true,
        borderRadius: BorderRadius.circular(10),
        style: const TextStyle(color: Colors.white, fontSize: 20),
        items: coinClass.getList().map((String e) {
          return DropdownMenuItem(
              alignment: AlignmentDirectional.center,
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${coinClass.getFlag(e)}'),
                  Text(
                    e,
                    style: TextStyle(
                      color: e == coinClass.getCurrentCurrency()
                          ? Theme.of(context).colorScheme.surface
                          : null,
                    ),
                  )
                ],
              ));
        }).toList(),
      ),
    );
  }
}
