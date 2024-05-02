import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:token_hub/domain/entities/crypto_coin_modal.dart';
import 'package:token_hub/presentation/widgets/price_chart.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

import '../bloc/coin_detail_screen_cubit.dart';
import '../bloc/coin_detail_screen_state.dart';

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
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is CoinDetailLoaded) {
            final coin = state.cryptoCoinDescription;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                    const SizedBox(height: 16.0),
                    PriceChart(cryptoDataList: state.coinPriceData),
                    const SizedBox(height: 16.0),
                    const SizedBox(height: 20.0),
                    Text(
                      _reduceText(coin.description),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Quantity',
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                final quantity = double.parse(value);
                                final usdValue = quantity * coin.priceUsd;
                                _usdController.text =
                                    usdValue.toStringAsFixed(2);
                              } else {
                                _usdController.text = "";
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            controller: _usdController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'USD',
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                final usdValue = double.parse(value);
                                final quantity = usdValue / coin.priceUsd;
                                _quantityController.text =
                                    quantity.toStringAsFixed(4);
                              } else {
                                _quantityController.text = "";
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
