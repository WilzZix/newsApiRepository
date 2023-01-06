import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:infinite_scroll/presentation/pages/detail_page.dart';
import 'package:infinite_scroll/presentation/pages/home_page/home_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
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
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

//https://newsapi.org/v2/top-headlines?country=us&apiKey=2a389994e9314644b675d0567ed43de4&pageSize=10&page=1

// {
// "source": {
// "id": "cnn",
// "name": "CNN"
// },
// "author": "By <a href=\"/profiles/jessie-yeung\">Jessie Yeung</a>, CNN",
// "title": "Russia's war in Ukraine: Live updates - CNN",
// "description": "Three Russian servicemen were killed after a Ukrainian drone crashed near an air base inside Russian territory, according to Russian state news. Over the weekend, Russia struck Kherson more than 70 times, killing 16 people. Follow for the latest updates.",
// "url": "https://www.cnn.com/europe/live-news/russia-ukraine-war-news-12-27-22/index.html",
// "urlToImage": "https://cdn.cnn.com/cnnnext/dam/assets/220513102106-01-ukraine-flag-destruction-borodianka-0417-super-tease.jpg",
// "publishedAt": "2022-12-27T07:41:00Z",
// "content": "The Security Service of Ukraine (SBU) has neutralized more than 4,500 cyberattacks on the country this year, an official said Monday.\r\nIlya Vitiuk, head of the SBU cybersecurity department said in a … [+1127 chars]"
// }
