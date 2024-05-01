import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:token_hub/data/models/crypto_coin_modal.dart';

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
    // Load coin details when the page opens
    //  context.read<CoinDetailBloc>().loadCoinDetails(widget.coin.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coin.name),
      ),
      // body: BlocBuilder<CoinDetailCubit, CoinDetailState>(
      //   builder: (context, state) {
      //     if (state is CoinDetailLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (state is CoinDetailError) {
      //       return Center(child: Text('Error: ${state.error}'));
      //     } else if (state is CoinDetailLoaded) {
      //       final coin = state.coin;
      //       return SingleChildScrollView(
      //         child: Column(
      //           children: [
      //             // Coin image and details
      //             Row(
      //               children: [
      //                 CircleAvatar(
      //                   backgroundImage: NetworkImage(coin.image),
      //                   radius: 50.0,
      //                 ),
      //                 const SizedBox(width: 16.0),
      //                 Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       coin.name,
      //                       style: const TextStyle(
      //                           fontSize: 18.0, fontWeight: FontWeight.bold),
      //                     ),
      //                     Text(coin.symbol),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //             const SizedBox(height: 16.0),
      //             // Description
      //             Text(
      //               "coin.description",
      //               style: const TextStyle(fontSize: 14.0),
      //             ),
      //             const SizedBox(height: 16.0),
      //             // Price graph
      //             // SizedBox(
      //             //   height: 200.0,
      //             //   child: _buildPriceGraph(coin.priceHistory),
      //             // ),
      //             const SizedBox(height: 16.0),
      //             // Calculator
      //             Row(
      //               children: [
      //                 Expanded(
      //                   child: TextField(
      //                     controller: _usdController,
      //                     //  keyboardType: TextInputType.numberWithDecimals,
      //                     decoration: const InputDecoration(
      //                       labelText: 'USD',
      //                     ),
      //                     onChanged: (value) {
      //                       if (value.isNotEmpty) {
      //                         final usdValue = double.parse(value);
      //                         final quantity = usdValue / coin.currentPrice;
      //                         _quantityController.text =
      //                             quantity.toStringAsFixed(4);
      //                       } else {
      //                         _quantityController.text = "";
      //                       }
      //                     },
      //                   ),
      //                 ),
      //                 const SizedBox(width: 8.0),
      //                 Expanded(
      //                   child: TextField(
      //                     controller: _quantityController,
      //                     //  keyboardType: TextInputType.numberWithDecimals,
      //                     decoration: const InputDecoration(
      //                       labelText: 'Quantity',
      //                     ),
      //                     onChanged: (value) {
      //                       if (value.isNotEmpty) {
      //                         final quantity = double.parse(value);
      //                         final usdValue = quantity * coin.currentPrice;
      //                         _usdController.text = usdValue.toStringAsFixed(2);
      //                       } else {
      //                         _usdController.text = "";
      //                       }
      //                     },
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       );
      //     } else {
      //       return const Center(child: Text("No data"));
      //     }
      //   },
      // ),
    );
  }

// charts.LineChart _buildPriceGraph(List<PriceData> priceHistory) {
//   final series = [
//     charts.Series<PriceData, DateTime>(
//       id: 'Price',
//       colorFn: (_, __) => charts.MaterialPalette.blue.shade200,
//       data: priceHistory,
//       domainFn: (data, _) => data.date,
//       measureFn: (data, _) => data.price,
//     ),
//   ];
//   return charts.LineChart(
//     series,
//     animate: false,
//     domainAxis: const charts.DateTimeAxis(),
//     primaryYAxis: charts.NumericAxis(
//       tickFormatter: (value) => '\$${value.toStringAsFixed(2)}',
//     ),
//   );
// }
}
