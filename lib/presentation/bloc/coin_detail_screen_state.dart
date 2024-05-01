import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/crypto_coin_modal.dart';

@immutable
abstract class CoinDetailState extends Equatable {
  const CoinDetailState();

  @override
  List<Object> get props => [];
}

class CoinDetailInitial extends CoinDetailState {}

class CoinDetailLoading extends CoinDetailState {}

class CoinDetailLoaded extends CoinDetailState {
  final CryptoCoin coin;

  const CoinDetailLoaded(this.coin);

  @override
  List<Object> get props => [coin];
}

class CoinDetailError extends CoinDetailState {
  final String error;

  const CoinDetailError(this.error);

  @override
  List<Object> get props => [error];
}
