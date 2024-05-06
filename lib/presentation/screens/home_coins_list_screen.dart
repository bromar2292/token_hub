import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_screen_bloc/home_screen_bloc_cubit.dart';
import '../bloc/home_screen_bloc/home_screen_bloc_state.dart';
import '../widgets/app_bar_sliver.dart';
import '../widgets/coin_tile.dart';
import '../widgets/error_loading_retry_widget.dart';

class HomeCoinsLIstScreen extends StatefulWidget {
  static const String id = 'Home screen';

  const HomeCoinsLIstScreen({Key? key}) : super(key: key);

  @override
  State<HomeCoinsLIstScreen> createState() => _HomeCoinsLIstScreenState();
}

class _HomeCoinsLIstScreenState extends State<HomeCoinsLIstScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomePageCoinListCubit>().fetchCoins();
  }

  @override
  Widget build(BuildContext context) {
    _searchController.addListener(() {
      final cubit = context.read<HomePageCoinListCubit>();
      cubit.searchCoins(_searchController.text);
    });

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            AppBarSliver(searchController: _searchController),
            const CoinListBuilder()
          ],
        ),
      ),
    );
  }
}

class CoinListBuilder extends StatelessWidget {
  const CoinListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCoinListCubit, CoinListState>(
      builder: (context, state) {
        if (state is CoinListLoading) {
          return const SliverToBoxAdapter(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        } else if (state is CoinListError) {
          return SliverToBoxAdapter(
            child: ErrorLoadingRetry(
              retryMethod: () =>
                  context.read<HomePageCoinListCubit>().fetchCoins(),
            ),
          );
        } else if (state is CoinStateLoaded) {
          if (state.coins.isEmpty) {
            return const SliverToBoxAdapter(
                child: Center(child: Text("No coins found")));
          }
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final coin = state.coins[index];
                return CoinTile(coin: coin);
              },
              childCount: state.coins.length,
            ),
          );
        } else {
          return const Center(child: Text("No data"));
        }
      },
    );
  }
}
