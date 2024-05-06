import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../data/repositories/coin_gecko_repository.dart';
import 'coin_detail_screen_state.dart';

class CoinDetailCubit extends Cubit<CoinDetailState> {
  final CoinListRepositoryImpl _repository;
  String? coinId;

  CoinDetailCubit(this._repository) : super(CoinDetailInitial());
  var logger = Logger();

  void loadCoinDetails(String coinId) async {
    emit(CoinDetailLoading());
    try {
      final coinChartData = await _repository.fetchPriceData(coinId);
      final coinData = await _repository.fetchCoinData(coinId);

      emit(CoinDetailLoaded(
        coinChartData,
        coinData,
      ));
    } catch (error) {
      logger.e(error);
      emit(CoinDetailError(error.toString()));
    }
  }
}
