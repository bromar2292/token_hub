class CryptoCoinDescription {
  final String id;
  final String name;
  final String description;
  final double priceUsd;

  CryptoCoinDescription({
    required this.id,
    required this.name,
    required this.description,
    required this.priceUsd,
  });

  factory CryptoCoinDescription.fromJson(Map<String, dynamic> json) {
    return CryptoCoinDescription(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description']['en'] as String,
      priceUsd: (json['market_data']['current_price']['usd'] as num).toDouble(),
    );
  }
}
