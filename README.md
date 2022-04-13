# flutter_adyen_cse

Adyen Payment client side encryption library for flutter projects.

It is for project when you don't need use Adyen Drop-in integration and just need tokenize card info or use your custom interface for card data.

# Requirements

Check if your app is compatible:

- Android mininal sdk version: 21 - Android Lollipop
- iOS minimal build target: iOS 12.2

Get your Client Encryption Public Key.

You need to set this as your `publicKey` when using the `flutter_adyen_cse` plugin. To get your public key:

- Sign in to your [Customer Area](https://ca-test.adyen.com/) using your company-level account.
- Navigate to **Developers** > **API credentials**.
- Click on your web service user (**ws@Company.[YourCompanyAccount]**) in the users list.

  This opens the **Edit Web Service** User page.

- In the **Client-Side Encryption** panel, copy the **Client Encryption Public Key**.

# Usage

Step 1 - Initialize `flutter_adyen_cse` plugin with your **Client Encryption Public Key**

```dart
import 'package:flutter_adyen_cse/flutter_adyen_cse.dart';
import 'package:flutter_adyen_cse/models/models.dart';

try {
  await FlutterAdyenCse.initAdyenCse(AdyenCseConfig(
    publicKey: '<Your-Client-Encryption-Public-Key>'
  ));
} on PlatformException {
  rethrow;
}
```

Step 2 - Encrypt card data

```dart
import 'dart:developer';

import 'package:flutter_adyen_cse/flutter_adyen_cse.dart';
import 'package:flutter_adyen_cse/models/models.dart';

try {
  final AdyenCseEncryptedCard? encryptedCard =
      await FlutterAdyenCse.encryptCard(AdyenCseCard(
    cardNumber: '4242424242424242',
    expiryMonth: '12',
    expiryYear: '2026',
    securityCode: '737',
  ));

  if (encryptedCard != null) log(encryptedCard.toJson().toString());
} on PlatformException {
  rethrow;
}
```

Step 3 - Use encrypted card data within `AdyenCseEncryptedCard` object.

# Demo app

you can see an example to use `flutter_adyen_cse` plugin in our [demo app](https://github.com/reservamos/flutter-adyen-cse/tree/main/example).

<img src="https://user-images.githubusercontent.com/11278416/163242303-1e1e7d16-a003-40c1-9a67-35a91e7d6dbb.png" width=320 />

# References

- [Custom Card Integration](https://docs.adyen.com/payment-methods/cards/custom-card-integration)
- [Adyen iOS Drop-in](https://docs.adyen.com/online-payments/ios/drop-in)
- [Adyen Android Drop-in](https://docs.adyen.com/online-payments/android/drop-in)
