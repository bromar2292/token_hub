import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:token_hub/constants.dart';
import 'package:logger/logger.dart'; // Import logger

/// data source pulls the remote data
abstract class CoinGeckoRemoteDataSource {
  Future<List<dynamic>> fetchCoins();

  Future<Map<String, dynamic>> fetchPriceData(String cryptocurrency);

  Future<Map<String, dynamic>> fetchCoinData(String coin);
}

class CoinGeckoRemoteDataSourceImpl implements CoinGeckoRemoteDataSource {
  var logger = Logger();
  String apiKey = API_KEY;

  Future<dynamic> _get(String url) async {
    final response =
        await http.get(Uri.parse(url), headers: {'x_cg_demo_api_key': apiKey});

    if (response.statusCode == 200) {
      logger.i(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<List<dynamic>> fetchCoins() async {
    return await _get(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd");
  }

  @override
  Future<Map<String, dynamic>> fetchPriceData(String coin) async {
    return await _get(
        "https://api.coingecko.com/api/v3/coins/${coin.toLowerCase()}/market_chart?vs_currency=usd&days=120");
  }

  @override
  Future<Map<String, dynamic>> fetchCoinData(String coin) async {
    return await _get(
        "https://api.coingecko.com/api/v3/coins/${coin.toLowerCase()}/");
  }
}
