import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:infinite_scroll/repasitory/news_repository.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  int _page = 1;
  List<News> news = [];
  final NewsRepository repository = NewsRepository();

  NewsBloc() : super(NewsInitial()) {
    on<GetNewsEvent>(
      (event, emit) async {
        emit(NewsLoadingState());
        try {
          List<News> list = await repository.getNews(page: 1);
          emit(NewsLoadedState(
            data: list,
          ));
        } catch (e) {
          emit(NewsLoadingErrorState(e.toString()));
        }
      },
    );
    on<GetNextPageEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        List<News> list = await repository.getNews(page: _page);
        ++_page;
        log('$_page');
        news.addAll(list);
        emit(NewsLoadedState( data: news));
      } catch (e) {
        emit(NewsLoadingErrorState(e.toString()));
      }
    });
  }
}
