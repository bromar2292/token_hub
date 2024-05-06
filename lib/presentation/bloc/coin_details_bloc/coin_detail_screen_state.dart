import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/crypto_coin_description_modal.dart';
import '../../../domain/entities/crypto_price_data_model.dart';

@immutable
abstract class CoinDetailState extends Equatable {
  const CoinDetailState();

  @override
  List<Object> get props => [];
}

class CoinDetailInitial extends CoinDetailState {}

class CoinDetailLoading extends CoinDetailState {}

class CoinDetailLoaded extends CoinDetailState {
  final List<CryptoPriceData> coinPriceData;
  final CryptoCoinDescription cryptoCoinDescription;

  const CoinDetailLoaded(
    this.coinPriceData,
    this.cryptoCoinDescription,
  );

  @override
  List<Object> get props => [coinPriceData, cryptoCoinDescription];
}

class CoinDetailError extends CoinDetailState {
  final String error;

  const CoinDetailError(this.error);

  @override
  List<Object> get props => [error];
}
