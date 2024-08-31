import 'package:go_router/go_router.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:infinite_scroll/presentation/pages/detail_page.dart';
import 'package:infinite_scroll/presentation/pages/home_page/home_page.dart';

class AppRouter {
  static GoRouter router = GoRouter(
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
}
