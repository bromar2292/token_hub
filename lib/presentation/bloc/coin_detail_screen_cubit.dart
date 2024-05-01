import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:token_hub/data/models/crypto_coin_modal.dart';

import '../../data/datasource/coingecko_remote_datasource.dart';
import '../../data/repositories/coin_list_repository.dart';
import 'coin_detail_screen_state.dart';

class CoinDetailCubit extends Cubit<CoinDetailState> {
  final CoinListRepositoryImpl _repository;

  CoinDetailCubit(this._repository) : super(CoinDetailInitial());

  void loadCoinDetails(String coinId) async {
    emit(CoinDetailLoading());
    try {
      // final coin = await _repository.getCoinDetails(coinId);
      //  emit(CoinDetailLoaded(coin));
    } catch (error) {
      emit(CoinDetailError(error.toString()));
    }
  }
}
