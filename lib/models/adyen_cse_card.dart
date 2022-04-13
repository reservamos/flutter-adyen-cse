class AdyenCseCard {
  AdyenCseCard({
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.securityCode,
  });
  late final String cardNumber;
  late final String expiryMonth;
  late final String expiryYear;
  late final String securityCode;

  AdyenCseCard.fromJson(Map<String, dynamic> json) {
    cardNumber = json['cardNumber'];
    expiryMonth = json['expiryMonth'];
    expiryYear = json['expiryYear'];
    securityCode = json['securityCode'];
  }

  Map<String, String> toJson() {
    final _data = <String, String>{};
    _data['cardNumber'] = cardNumber;
    _data['expiryMonth'] = expiryMonth;
    _data['expiryYear'] = expiryYear;
    _data['securityCode'] = securityCode;
    return _data;
  }
}
