import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_adyen_cse/flutter_adyen_cse.dart';
import 'package:flutter_adyen_cse/models/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _expMonthController = TextEditingController();
  final TextEditingController _expYearController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  Map<String, String>? result;

  @override
  void initState() {
    super.initState();
    initAdyenCsePlugin();
    _numberController.text = '4242424242424242';
    _expMonthController.text = '12';
    _expYearController.text = '2026';
    _cvvController.text = '737';
  }

  Future<void> initAdyenCsePlugin() async {
    try {
      await FlutterAdyenCse.initAdyenCse(AdyenCseConfig(
        publicKey: const String.fromEnvironment('ADYEN_PK'),
        env: 'test',
      ));
    } on PlatformException {
      rethrow;
    }
  }

  Future<void> encryptCard() async {
    try {
      final AdyenCseEncryptedCard? encryptedCard =
          await FlutterAdyenCse.encryptCard(AdyenCseCard(
        cardNumber: _numberController.value.text,
        expiryMonth: _expMonthController.value.text,
        expiryYear: _expYearController.value.text,
        securityCode: _cvvController.value.text,
      ));

      if (encryptedCard != null) {
        setState(() {
          result = encryptedCard.toJson();
        });
      }
    } on PlatformException {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Adyen CSE demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(label: Text('card number')),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expMonthController,
                      decoration:
                          const InputDecoration(label: Text('exp month')),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextFormField(
                      controller: _expYearController,
                      decoration:
                          const InputDecoration(label: Text('exp year')),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(label: Text('cvv')),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: MaterialButton(
                  onPressed: () => encryptCard(),
                  child: const Text(
                    'Encrypt card',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                ),
              ),
              const Divider(
                color: Colors.black54,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: const [
                    Text('Result:'),
                  ],
                ),
              ),
              Expanded(
                child: Material(
                  type: MaterialType.card,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                  child: result != null
                      ? ListView.separated(
                          itemCount: result!.keys.length,
                          itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  result!.keys.elementAt(index),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(result!.values.elementAt(index)),
                            ],
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
