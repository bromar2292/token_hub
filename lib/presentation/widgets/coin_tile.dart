import 'package:flutter/material.dart';

import '../../domain/entities/crypto_coin_modal.dart';
import '../screens/coin_details_screen.dart';

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
        radius: 24.0,
      ),
      title: Text(coin.name),
      subtitle: Text(coin.symbol),
      trailing: Text('\$${formatPrice(coin.currentPrice)}'),
      onTap: () {
        Navigator.pushNamed(context, CryptoProfilePage.id, arguments: coin);
      },
    );
  }
}

String formatPrice(double price) {
  if (price >= 0.01) {
    return price.toStringAsFixed(2);
  } else {
    int leadingZeroCount = 0;
    String priceString = price.toString();
    for (int i = 2; i < priceString.length; i++) {
      if (priceString[i] != '0') {
        break;
      }
      leadingZeroCount++;
    }
    int decimalPlaces = 2 + leadingZeroCount;
    return price.toStringAsFixed(decimalPlaces);
  }
}
