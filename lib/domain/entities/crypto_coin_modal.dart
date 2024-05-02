class CryptoCoin {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;

  final int marketCap;
  final int marketCapRank;
  // final int? fullyDilutedValuation;
  // final int totalVolume;
  // final double high24h;
  // final double low24h;
  // final double priceChange24h;
  // final double priceChangePercentage24h;
  // final double marketCapChange24h;
  // final double marketCapChangePercentage24h;
  // final double circulatingSupply;
  // final double? totalSupply;
  // final double? maxSupply;
  // final double ath;
  // final double athChangePercentage;
  // final String athDate;
  // final double atl;
  // final double atlChangePercentage;
  // final String atlDate;
  // final Map<String, dynamic>? roi;
  // final String lastUpdated;

  CryptoCoin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    // this.fullyDilutedValuation,
    // required this.totalVolume,
    // required this.high24h,
    // required this.low24h,
    // required this.priceChange24h,
    // required this.priceChangePercentage24h,
    // required this.marketCapChange24h,
    // required this.marketCapChangePercentage24h,
    // required this.circulatingSupply,
    // this.totalSupply,
    // this.maxSupply,
    // required this.ath,
    // required this.athChangePercentage,
    // required this.athDate,
    // required this.atl,
    // required this.atlChangePercentage,
    // required this.atlDate,
    // this.roi,
    // required this.lastUpdated,
  });

  factory CryptoCoin.fromJson(Map<String, dynamic> json) {
    return CryptoCoin(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: json['current_price'].toDouble(),
      marketCap: json['market_cap'],
      marketCapRank: json['market_cap_rank'],
      // fullyDilutedValuation: json['fully_diluted_valuation'],
      // totalVolume: json['total_volume'],
      // high24h: json['high_24h'].toDouble(),
      // low24h: json['low_24h'].toDouble(),
      // priceChange24h: json['price_change_24h'].toDouble(),
      // priceChangePercentage24h: json['price_change_percentage_24h'].toDouble(),
      // marketCapChange24h: json['market_cap_change_24h'].toDouble(),
      // marketCapChangePercentage24h:
      //     json['market_cap_change_percentage_24h'].toDouble(),
      // circulatingSupply: json['circulating_supply'].toDouble(),
      // totalSupply: json['total_supply']?.toDouble(),
      // maxSupply: json['max_supply']?.toDouble(),
      // ath: json['ath'].toDouble(),
      // athChangePercentage: json['ath_change_percentage'].toDouble(),
      // athDate: json['ath_date'],
      // atl: json['atl'].toDouble(),
      // atlChangePercentage: json['atl_change_percentage'].toDouble(),
      // atlDate: json['atl_date'],
      // roi: json['roi'],
      // lastUpdated: json['last_updated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'current_price': currentPrice,
      'market_cap': marketCap,
      'market_cap_rank': marketCapRank,
      // 'fully_diluted_valuation': fullyDilutedValuation,
      // 'total_volume': totalVolume,
      // 'high_24h': high24h,
      // 'low_24h': low24h,
      // 'price_change_24h': priceChange24h,
      // 'price_change_percentage_24h': priceChangePercentage24h,
      // 'market_cap_change_24h': marketCapChange24h,
      // 'market_cap_change_percentage_24h': marketCapChangePercentage24h,
      // 'circulating_supply': circulatingSupply,
      // 'total_supply': totalSupply,
      // 'max_supply': maxSupply,
      // 'ath': ath,
      // 'ath_change_percentage': athChangePercentage,
      // 'ath_date': athDate,
      // 'atl': atl,
      // 'atl_change_percentage': atlChangePercentage,
      // 'atl_date': atlDate,
      // 'roi': roi,
      // 'last_updated': lastUpdated,
    };
  }
}
