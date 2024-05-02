import '../../domain/entities/crypto_coin_description_modal.dart';
import '../../domain/entities/crypto_coin_modal.dart';
import '../../domain/entities/crypto_price_data_model.dart';
import '../datasource/coingecko_remote_datasource.dart';

abstract class CoinListRepository {
  Future<List<CryptoCoin>> fetchCoins();

  Future<List<CryptoPriceData>> fetchPriceData(String cryptocurrency);

  Future<CryptoCoinDescription> fetchCoinData(String cryptocurrency);
}

class CoinListRepositoryImpl implements CoinListRepository {
  final CoinGeckoRemoteDataSourceImpl _remoteDataSource;

  ///pulls a list of all the coins
  ///omar need to put sensitive data somewhere safe
  CoinListRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<CryptoCoin>> fetchCoins() async {
    Iterable coinListJson = await _remoteDataSource.fetchCoins();
    return coinListJson.map((rawCoin) => CryptoCoin.fromJson(rawCoin)).toList();
  }

  @override
  Future<List<CryptoPriceData>> fetchPriceData(String cryptocurrency) async {
    try {
      Map<String, dynamic> cryptoPriceJson =
          await _remoteDataSource.fetchPriceData(cryptocurrency);
      List<dynamic> pricesList = cryptoPriceJson['prices'];
      return pricesList
          .map((priceEntry) => CryptoPriceData.fromJson(priceEntry))
          .toList();
    } catch (error, stack) {
      print(error);
      print(stack);
      throw Exception('Failed to parse and fetch price data: $error');
    }
  }

  @override
  Future<CryptoCoinDescription> fetchCoinData(String cryptocurrency) async {
    try {
      Map<String, dynamic> cryptoCoinJson =
          await _remoteDataSource.fetchCoinData(cryptocurrency);
      return CryptoCoinDescription.fromJson(cryptoCoinJson);
    } catch (error, stack) {
      print(error);
      print(stack);
      throw Exception('Failed to parse and fetch coin data: $error');
    }
  }
}
