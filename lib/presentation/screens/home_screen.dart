import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:token_hub/domain/entities/crypto_coin_modal.dart';
import '../bloc/home_screen_bloc_cubit.dart';
import '../bloc/home_screen_bloc_state.dart';
import '../widgets/coin_tile.dart';

/// omar maybe impliment debouncing
class HomeScreen extends StatelessWidget {
  static const String id = 'Home screen';

  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _searchController.addListener(() {
      final cubit = context.read<CoinCubit>();
      cubit.searchCoins(_searchController.text);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Coins'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter coin name',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<CoinCubit, CoinListState>(
        builder: (context, state) {
          if (state is CoinListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CoinListError) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is CoinStateLoaded) {
            if (state.coins.isEmpty) {
              return const Center(child: Text("No coins found"));
            }
            return ListView.builder(
              itemCount: state.coins.length,
              itemBuilder: (context, index) {
                final coin = state.coins[index];
                return CoinTile(coin: coin);
              },
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}
