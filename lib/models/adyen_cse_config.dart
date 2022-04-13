class AdyenCseConfig {
  AdyenCseConfig({
    required this.publicKey,
  });
  late final String publicKey;

  AdyenCseConfig.fromJson(Map<String, dynamic> json) {
    publicKey = json['publicKey'];
  }

  Map<String, String> toJson() {
    final _data = <String, String>{};
    _data['publicKey'] = publicKey;
    return _data;
  }
}
