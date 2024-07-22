import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_scroll/application/bbc_news/bbc_news_bloc.dart';
import 'package:infinite_scroll/application/home_page_news_bloc/news_bloc.dart';
import 'package:infinite_scroll/application/sport/sport_bloc.dart';
import 'package:infinite_scroll/data/storage/hive/hive_storage.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:infinite_scroll/infrastructure/service/network_provider.dart';
import 'package:infinite_scroll/presentation/pages/detail_page.dart';
import 'package:infinite_scroll/presentation/pages/home_page/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  NetworkProvider.init();
  await Hive.initFlutter();
  Hive.registerAdapter(NewsAdapter());
  Hive.registerAdapter(SourceAdapter());
  await Hive.openBox(HiveBoxNameUtils.mainStorage);
  runApp(MyApp());
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) {}
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(),
      ),
      GoRoute(
        path: '/detail',
        builder: (context, state) => DetailPage(
          data: state.extra as News,
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsBloc(),
        ),
        BlocProvider(
          create: (create) => SportBloc()..add(GetSportNewsEvent()),
        ),
        BlocProvider(
          create: (create) => BbcNewsBloc()..add(GetBBCNewsEvent()),
        )
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
