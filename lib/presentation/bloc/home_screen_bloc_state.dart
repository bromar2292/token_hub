import '../../data/models/crypto_coin_modal.dart';
import '../../data/models/crypto_price_data_model.dart';

abstract class CoinListState {}

class CoinListInitial extends CoinListState {}

class CoinListLoading extends CoinListState {}

class CoinListError extends CoinListState {
  final String? error;

  CoinListError(this.error);
}

class CoinStateLoaded extends CoinListState {
  final List<CryptoCoin> coins;
  final Map<String, CryptoPriceData>? details;

  final String? error;

  CoinStateLoaded({this.coins = const [], this.error, this.details});

  CoinStateLoaded copyWith(
      {List<CryptoCoin>? coins, bool? isLoading, String? error}) {
    return CoinStateLoaded(
      coins: coins ?? this.coins,
      error: error,
    );
  }
}
