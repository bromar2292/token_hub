import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:token_hub/data/datasource/coingecko_remote_datasource.dart';
import 'datasource.test.mocks.dart';

@GenerateMocks([http.Client]) // For generating mocks
main() async {
  await dotenv.load(fileName: ".env");

  group('CoinGeckoRemoteDataSourceImpl', () {
    late CoinGeckoRemoteDataSourceImpl dataSource;

    late MockClient client;

    setUp(() {
      client = MockClient();
      dataSource = CoinGeckoRemoteDataSourceImpl();
    });

    test('fetchCoins returns a list of coins on a successful call', () async {
      final testData = jsonEncode([
        {'id': 'bitcoin', 'name': 'Bitcoin', 'current_price': 24000},
      ]);

      when(client.get(Uri.parse(
              "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd")))
          .thenAnswer((_) async => http.Response(testData, 200));

      final result = await dataSource.fetchCoins();

      expect(result, isA<List<dynamic>>());
      expect(result.length, 100);
      expect(result.first['id'], 'bitcoin');
    });

    test('fetchPriceData returns map data on successful call', () async {
      final testPriceData = jsonEncode({
        'prices': [
          [1625097600000, 34660.02],
          [1625097600000, 34660.02]
        ]
      });

      when(client.get(Uri.parse(
              "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=120")))
          .thenAnswer((_) async => http.Response(testPriceData, 200));

      final result = await dataSource.fetchPriceData("bitcoin");

      expect(result, isA<Map<String, dynamic>>());
      expect(result['prices'], isA<List<dynamic>>());
    });

    test('fetchCoinData returns detailed coin data on successful call',
        () async {
      final testCoinData = jsonEncode({
        'id': 'bitcoin',
        'symbol': 'btc',
        'name': 'Bitcoin',
        'hashing_algorithm': 'SHA-256',
        'description': {'en': 'Bitcoin is a cryptocurrency.'}
      });

      when(client
              .get(Uri.parse("https://api.coingecko.com/api/v3/coins/bitcoin")))
          .thenAnswer((_) async => http.Response(testCoinData, 200));

      final result = await dataSource.fetchCoinData("bitcoin");

      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], 'bitcoin');
      expect(result['description']['en'], contains('cryptocurrency'));
    });
  });
}
