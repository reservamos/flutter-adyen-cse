# flutter_adyen_cse demo app

Demonstrates how to use the flutter_adyen_cse plugin.

# Requirements

This demo app was developed using next environment:

```bash
[✓] Flutter (Channel stable, 2.10.4, on macOS 12.3.1 21E258 darwin-x64, locale en-MX)
[✓] Android toolchain - develop for Android devices (Android SDK version 30.0.3)
[✓] Xcode - develop for iOS and macOS (Xcode 13.3.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2021.1)
[✓] VS Code (version 1.66.2)
[✓] Connected device (3 available)
[✓] HTTP Host Availability

• No issues found!
```

## Before running demo app

`flutter_adyen_cse` demo app require add an **Client Encyption Public Key**

> _please review requirements in [flutter_adyen_cse plugin documentation](https://github.com/reservamos/flutter-adyen-cse/blob/main/README.md#requirements)._

if you have an **Client Encyption Public Key** just add into `lib/main.dart` replacing [publicKey param](https://github.com/reservamos/flutter-adyen-cse/blob/main/example/lib/main.dart#L39)

```dart
// lib/main.dart

Future<void> initAdyenCsePlugin() async {
  try {
      await FlutterAdyenCse.initAdyenCse(AdyenCseConfig(
        publicKey: '<Your-Client-Encryption-Public-Key>',
      ));
    } on PlatformException {
      rethrow;
    }
  }
```

or run next command in a terminal app for use `ADYEN_PK` environment variable:

```bash
  flutter run --dart-define ADYEN_PK="<Your-Client-Encryption-Public-Key>"
```

# When demo app is running

By default all card information inputs are prefilled, but you can modify this inputs to test different values.

**Notes:**

- expiry year must be 4 digits.
- expiry month must be 2 digits.
- card number must be numeric and lenght between 14 and 16 digits depends on card brand.
- security code must be numeric and lenght between 3 or 4 digits depends on card brand.

when all card information input are filled then tap `Encrypt card` button for see encrypted card result data.
