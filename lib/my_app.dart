import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:token_hub/presentation/bloc/coin_detail_screen_cubit.dart';
import 'package:token_hub/presentation/bloc/home_screen_bloc_cubit.dart';
import 'package:token_hub/presentation/screens/coin_detail_screen.dart';
import 'package:token_hub/presentation/screens/home_screen.dart';
import 'package:token_hub/data/repositories/coin_list_repository.dart';

import 'data/datasource/coingecko_remote_datasource.dart';
import 'data/models/crypto_coin_modal.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) =>
            CoinCubit(CoinListRepositoryImpl(CoinGeckoRemoteDataSourceImpl())),
        child: HomeScreen(),
      ),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
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
