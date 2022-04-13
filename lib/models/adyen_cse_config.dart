class AdyenCseConfig {
  AdyenCseConfig({
    required this.publicKey,
    required this.env,
  });
  late final String publicKey;
  late final String env;

  AdyenCseConfig.fromJson(Map<String, dynamic> json) {
    publicKey = json['publicKey'];
    env = json['env'];
  }

  Map<String, String> toJson() {
    final _data = <String, String>{};
    _data['publicKey'] = publicKey;
    _data['env'] = env;
    return _data;
  }
}
