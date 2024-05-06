import 'package:flutter/material.dart';

import '../../domain/entities/crypto_coin_description_modal.dart';

class Calculator extends StatelessWidget {
  const Calculator({
    super.key,
    required TextEditingController quantityController,
    required this.coin,
    required TextEditingController usdController,
  })  : _quantityController = quantityController,
        _usdController = usdController;

  final TextEditingController _quantityController;
  final CryptoCoinDescription coin;
  final TextEditingController _usdController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Calculator', // Add your title here
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        ),
        Row(
          children: [
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
                    _quantityController.text = quantity.toStringAsFixed(4);
                  } else {
                    _quantityController.text = "";
                  }
                },
              ),
            ),
            const SizedBox(width: 8.0),
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
                    _usdController.text = usdValue.toStringAsFixed(2);
                  } else {
                    _usdController.text = "";
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
