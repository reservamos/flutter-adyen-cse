import 'package:flutter/services.dart';
import 'package:flutter_adyen_cse/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_adyen_cse/flutter_adyen_cse.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_adyen_cse');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('initAdyenCse', () async {
    expect(
      () async => await FlutterAdyenCse.initAdyenCse(
        AdyenCseConfig(
          publicKey: '272727',
        ),
      ),
      throwsA(isA<AssertionError>()),
    );
  });
}
