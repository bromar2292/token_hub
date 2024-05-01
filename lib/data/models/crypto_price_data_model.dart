class CryptoPriceData {
  final int timestamp;
  final double price;

  CryptoPriceData(this.timestamp, this.price);

  factory CryptoPriceData.fromJson(Map<String, dynamic> json) {
    return CryptoPriceData(json[0] as int, json[1] as double);
  }
}
