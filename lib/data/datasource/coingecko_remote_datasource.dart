import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// data source pulls the remote data
abstract class CoinGeckoRemoteDataSource {
  Future<List<dynamic>> fetchCoins();

  Future<List<dynamic>> fetchPriceData(String cryptocurrency);
}

class CoinGeckoRemoteDataSourceImpl implements CoinGeckoRemoteDataSource {
  String apiKey = "CG-3ptYSFzGtseqpiT99r1iMUQp";

  @override
  Future<List<dynamic>> fetchCoins() async {
    try {
      final response = await http.get(
          Uri.parse(
              "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd"),
          headers: {'x_cg_demo_api_key': apiKey});

      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to fetch coins. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Network error occurred: $error');
    }
  }

  @override
  Future<List> fetchPriceData(String coin) async {
    try {
      final response = await http.get(
          Uri.parse(
              "https://api.coingecko.com/api/v3/coins/$coin/market_chart?vs_currency=usd&days=120"),
          headers: {'x_cg_demo_api_key': apiKey});

      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to fetch coins. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Network error occurred: $error');
    }
  }
}
// final response = await http.get(Uri.parse(
// //"https://api.coingecko.com/api/v3/coins/list"),
// "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd"),
// headers: {'x_cg_demo_api_key': "CG-3ptYSFzGtseqpiT99r1iMUQp"});
//
// if (response.statusCode == 200) {
// Iterable list = jsonDecode(response.body);
//
// return list.map((json) => CryptoCoin.fromJson(json)).toList();
// } else {
// throw Exception('failed to get matches');
// }
// }
