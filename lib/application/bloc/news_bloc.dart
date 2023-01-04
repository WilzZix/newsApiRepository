
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:infinite_scroll/repasitory/news_repository.dart';
import 'package:meta/meta.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  int _page = 1;
  final NewsRepository repository = NewsRepository();

  NewsBloc() : super(NewsInitial()) {
    on<GetNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        _page = 1;
        final List<News> news = await repository.getNews(page: _page);
        log('News $news');
        emit(NewsLoadedState(news));
      } catch (e) {
        emit(NewsLoadingErrorState());
      }
    });
  }
}
