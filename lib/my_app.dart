import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:token_hub/presentation/bloc/coin_details_bloc/coin_detail_screen_cubit.dart';
import 'package:token_hub/presentation/bloc/home_screen_bloc/home_screen_bloc_cubit.dart';
import 'package:token_hub/presentation/screens/coin_details_screen.dart';
import 'package:token_hub/presentation/screens/home_coins_list_screen.dart';
import 'package:token_hub/data/repositories/coin_gecko_repository.dart';

import 'data/datasource/coingecko_remote_datasource.dart';
import 'domain/entities/crypto_coin_modal.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => HomePageCoinListCubit(
            CoinListRepositoryImpl(CoinGeckoRemoteDataSourceImpl())),
        child: const HomeCoinsLIstScreen(),
      ),
      routes: {
        HomeCoinsLIstScreen.id: (context) => const HomeCoinsLIstScreen(),
        CryptoProfilePage.id: (context) => BlocProvider<CoinDetailCubit>(
              create: (context) => CoinDetailCubit(
                  CoinListRepositoryImpl(CoinGeckoRemoteDataSourceImpl())),
              child: CryptoProfilePage(
                coin: ModalRoute.of(context)!.settings.arguments as CryptoCoin,
              ),
            ),
      },
      initialRoute: '/',
    );
  }
}
