import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_adyen_cse/models/models.dart';

class FlutterAdyenCse {
  static const MethodChannel _channel = MethodChannel('flutter_adyen_cse');
  static const String _logName = 'FlutterAdyenCse';

  static Future<void> initAdyenCse(AdyenCseConfig config) async {
    final String? result = await _channel.invokeMethod(
      'initAdyenCse',
      config.toJson(),
    );

    if (result != null) log(result, name: _logName);
  }

  static Future<AdyenCseEncryptedCard?> encryptCard(AdyenCseCard card) async {
    final String? result = await _channel.invokeMethod(
      'encryptCard',
      card.toJson(),
    );

    if (result != null) {
      log('Card encrypted successful', name: _logName);
      return AdyenCseEncryptedCard.fromJson(jsonDecode(result));
    }

    return null;
  }
}
