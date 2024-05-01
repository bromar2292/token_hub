import 'package:flutter/material.dart';

import '../../data/models/crypto_coin_modal.dart';
import '../screens/coin_detail_screen.dart';

class CoinTile extends StatelessWidget {
  const CoinTile({
    super.key,
    required this.coin,
  });

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(coin.image),
        radius: 24.0, // Adjust the size to fit your design
      ),
      title: Text(coin.name),
      subtitle: Text(coin.symbol),
      trailing: Text('\$${coin.currentPrice.toStringAsFixed(2)}'),
      onTap: () {
        Navigator.pushNamed(context, CryptoProfilePage.id, arguments: coin);
      },
    );
  }
}
