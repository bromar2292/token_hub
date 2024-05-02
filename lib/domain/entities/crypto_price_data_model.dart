class CryptoPriceData {
  final int date;
  final double price;

  CryptoPriceData(this.date, this.price);

  factory CryptoPriceData.fromJson(List<dynamic> json) {
    return CryptoPriceData(
      (json[0] as int),
      (json[1] as num).toDouble(),
    );
  }
}
