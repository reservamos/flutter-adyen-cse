class AdyenCseEncryptedCard {
  AdyenCseEncryptedCard({
    required this.encryptedNumber,
    required this.encryptedExpiryMonth,
    required this.encryptedExpiryYear,
    required this.encryptedSecurityCode,
  });
  late final String encryptedNumber;
  late final String encryptedExpiryMonth;
  late final String encryptedExpiryYear;
  late final String encryptedSecurityCode;

  AdyenCseEncryptedCard.fromJson(Map<String, dynamic> json) {
    encryptedNumber = json['encryptedNumber'];
    encryptedExpiryMonth = json['encryptedExpiryMonth'];
    encryptedExpiryYear = json['encryptedExpiryYear'];
    encryptedSecurityCode = json['encryptedSecurityCode'];
  }

  Map<String, String> toJson() {
    final _data = <String, String>{};
    _data['encryptedNumber'] = encryptedNumber;
    _data['encryptedExpiryMonth'] = encryptedExpiryMonth;
    _data['encryptedExpiryYear'] = encryptedExpiryYear;
    _data['encryptedSecurityCode'] = encryptedSecurityCode;
    return _data;
  }
}
