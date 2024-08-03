import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_scroll/application/bbc_news/bbc_news_bloc.dart';
import 'package:infinite_scroll/application/connection/connection_bloc.dart';
import 'package:infinite_scroll/application/connection/connection_state.dart';
import 'package:infinite_scroll/application/home_page_news_bloc/news_bloc.dart';
import 'package:infinite_scroll/application/sport/sport_bloc.dart';
import 'package:infinite_scroll/application/theme/theme_cubit.dart';
import 'package:infinite_scroll/data/storage/hive/hive_storage.dart';
import 'package:infinite_scroll/data/storage/shared_preference/shared_preference_storage.dart';
import 'package:infinite_scroll/firebase_options.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:infinite_scroll/infrastructure/service/network_provider.dart';
import 'package:infinite_scroll/presentation/pages/detail_page.dart';
import 'package:infinite_scroll/presentation/pages/home_page/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  NetworkProvider.init();
  await Hive.initFlutter();
  await Hive.openBox<News>('newsBox');
  Hive.registerAdapter(NewsAdapter());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
  // final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//  log('line 35 ${await FirebaseMessaging.instance.getToken()}');
  // if (apnsToken != null) {}
  Hive.registerAdapter(SourceAdapter());
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await SharedPreferenceStorage().initPrefs();
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool appThemeDark = false;

  final _router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(),
      ),
      GoRoute(
        path: '/detail',
        name: '/detail',
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
        BlocProvider(create: (create) => SportBloc()),
        BlocProvider(
          create: (create) => BbcNewsBloc(),
        ),
        BlocProvider(create: (context) => ConnectionCheckerBloc()),
        BlocProvider(create: (context) => ThemeCubit())
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {
          if (state is AppThemeState) {
            appThemeDark = state.isDark;
          }
        },
        builder: (BuildContext context, ThemeState state) {
          return MaterialApp.router(
            routerConfig: _router,
           // routerDelegate: _router.routerDelegate,
            // routeInformationParser: _router.routeInformationParser,
            // routeInformationProvider: _router.routeInformationProvider,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: appThemeDark ? ThemeData.dark() : ThemeData.light(),
            builder: (_, child) {
              return BlocListener<ConnectionCheckerBloc,
                  ConnectionCheckerState>(
                listener: (context, state) {
                  if (state is ConnectivitySuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('connected'),
                      ),
                    );
                  }
                  if (state is ConnectivityFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('is not connected'),
                      ),
                    );
                  }
                },
                child: child,
              );
            },
          );
        },
      ),
    );
  }
}
