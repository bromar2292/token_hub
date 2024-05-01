import '../datasource/coingecko_remote_datasource.dart';
import '../models/crypto_coin_modal.dart';
import '../models/crypto_price_data_model.dart';

abstract class CoinListRepository {
  Future<List<CryptoCoin>> fetchCoins();

  Future<List<CryptoPriceData>> fetchPriceData(String cryptocurrency);
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
    Iterable cryptoPriceJson =
        await _remoteDataSource.fetchPriceData(cryptocurrency);
    return cryptoPriceJson
        .map((rawCoin) => CryptoPriceData.fromJson(rawCoin))
        .toList();
  }
}
