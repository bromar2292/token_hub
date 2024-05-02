import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:token_hub/data/repositories/coin_gecko_repository.dart';

import '../../domain/entities/crypto_coin_modal.dart';
import '../../domain/entities/crypto_price_data_model.dart';
import 'home_screen_bloc_state.dart';

class CoinCubit extends Cubit<CoinListState> {
  final CoinListRepositoryImpl _webService;
  Timer? _debounce;

  CoinCubit(this._webService) : super(CoinListInitial()) {
    fetchCoins();
  }

  /// omar should these be up here
  List<CryptoCoin> _coins = [];

  void fetchCoins() async {
    emit(CoinListLoading());
    try {
      _coins = await _webService.fetchCoins();

      emit(CoinStateLoaded(coins: _coins));
    } catch (e) {
      print(e);
      emit(CoinListError(e.toString()));
    }
  }

  void searchCoins(String query) {
    if (query.isEmpty) {
      emit(CoinStateLoaded(coins: _coins));
    }
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      //   _cryptoPriceData = await _webService.fetchPriceData(query);
      List<CryptoCoin> filteredCoins = _coins
          .where(
              (coin) => coin.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(CoinStateLoaded(coins: filteredCoins));
    });
  }
}
