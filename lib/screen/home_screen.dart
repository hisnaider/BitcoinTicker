import 'dart:convert';

import 'package:bitcoin_ticker/classes/coin_class.dart';
import 'package:bitcoin_ticker/components/card_currency.dart';
import 'package:bitcoin_ticker/components/dropdown_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CoinClass coinClass = CoinClass(currentCurrency: "BRL");
  List<double> cryptoValues = [];
  List<String> error = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeCurrency();
  }

  void changeCurrency() async {
    try {
      List<double> newCryptoValue = await coinClass.setCryptoValues();
      setState(() {
        cryptoValues = newCryptoValue;
      });
    } catch (e) {
      setState(() {
        if (e == 400) {
          error = ["Algo deu errado", "400"];
        } else if (e == 401) {
          error = ["Chave não autorizada", "401"];
        } else if (e == 403) {
          error = ["Essa chave não tem os privilédios necessario", "403"];
        } else if (e == 429) {
          error = ["Muito request foram feitos", "429"];
        } else if (e == 550) {
          error = ["Sem dados retornados", "550"];
        } else {
          error = ["Erro ao se comunicar com a API", "500"];
        }
      });
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coin Ticker"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: Colors.red),
              children: error.isEmpty
                  ? null
                  : [
                      TextSpan(
                        text: "${error[0]}\n",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                      TextSpan(
                        text: "Código: ${error[1]}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      )
                    ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: coinClass.crypto.length,
              itemBuilder: (BuildContext context, int index) {
                return CardCurrency(
                  currency: coinClass.getCurrentCurrency(),
                  value: cryptoValues.isEmpty
                      ? "?"
                      : cryptoValues[index].toStringAsFixed(2),
                  crypto: coinClass.crypto[index],
                );
              },
            ),
          ),
          DropDownPicker(
            coinClass: coinClass,
            updateCurrentCurrency: (value) {
              setState(() {
                error = [];
                cryptoValues = [];
              });
              coinClass.setCurrentCurrency(value);
              changeCurrency();
            },
          )
        ],
      ),
    );
  }
}
