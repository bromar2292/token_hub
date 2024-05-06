import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'package:token_hub/data/repositories/coin_gecko_repository.dart';

import '../../../domain/entities/crypto_coin_modal.dart';
import 'home_screen_bloc_state.dart';

class HomePageCoinListCubit extends Cubit<CoinListState> {
  final CoinListRepositoryImpl _webService;
  Timer? _debounce;

  HomePageCoinListCubit(this._webService) : super(CoinListInitial());
  var logger = Logger();

  List<CryptoCoin> _coins = [];

  void fetchCoins() async {
    emit(CoinListLoading());
    try {
      _coins = await _webService.fetchCoins();

      emit(CoinStateLoaded(coins: _coins));
    } catch (e) {
      logger.e(e);
      emit(CoinListError(e.toString()));
    }
  }

  void searchCoins(String query) {
    if (query.isEmpty) {
      emit(CoinStateLoaded(coins: _coins));
    }
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      List<CryptoCoin> filteredCoins = _coins
          .where(
              (coin) => coin.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(CoinStateLoaded(coins: filteredCoins));
    });
  }
}
