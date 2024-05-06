import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:token_hub/domain/entities/crypto_coin_modal.dart';
import 'package:token_hub/presentation/widgets/price_chart.dart';

import '../bloc/coin_details_bloc/coin_detail_screen_cubit.dart';
import '../bloc/coin_details_bloc/coin_detail_screen_state.dart';
import '../widgets/calculator.dart';
import '../widgets/error_loading_retry_widget.dart';

class CryptoProfilePage extends StatefulWidget {
  static const String id = 'Coin profile screen';

  final CryptoCoin coin;

  const CryptoProfilePage({Key? key, required this.coin}) : super(key: key);

  @override
  State<CryptoProfilePage> createState() => _CryptoProfilePageState();
}

class _CryptoProfilePageState extends State<CryptoProfilePage> {
  final TextEditingController _usdController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<CoinDetailCubit>().loadCoinDetails(widget.coin.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coin.name),
      ),
      body: BlocBuilder<CoinDetailCubit, CoinDetailState>(
        builder: (context, state) {
          if (state is CoinDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CoinDetailError) {
            return ErrorLoadingRetry(
                retryMethod: () => context
                    .read<CoinDetailCubit>()
                    .loadCoinDetails(widget.coin.name));
          } else if (state is CoinDetailLoaded) {
            final coin = state.cryptoCoinDescription;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.coin.image),
                        radius: 30.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 46.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: PriceChart(cryptoDataList: state.coinPriceData),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      _reduceText(coin.description),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Calculator(
                        quantityController: _quantityController,
                        coin: coin,
                        usdController: _usdController),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }

  String _reduceText(String description) {
    final sentencePattern = RegExp(r'(?<=[.!?])\s+');
    List<String> sentences = description.split(sentencePattern);
    if (sentences.length > 4) {
      return '${sentences[0]} ${sentences[1]} ${sentences[2]}...';
    }
    return description;
  }
}
