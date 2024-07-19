import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:infinite_scroll/infrastructure/local_database_repository/local_data_source.dart';
import 'package:infinite_scroll/infrastructure/repasitory/news_repository.dart';
import 'package:infinite_scroll/infrastructure/service/handling_network_exceptions.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  int _page = 1;
  List<News> news = [];
  final NewsRepository repository = NewsRepository();
  final _hiveStorageRepository = LocalDataRepository();

  NewsBloc() : super(NewsInitial()) {
    on<GetNewsEvent>(
      (event, emit) async {
        emit(NewsLoadingState());
        try {
          List<News> list = await repository.getNews(page: 1);
          //  await _hiveStorageRepository.setTopHeadlineNews(data: list);
          emit(NewsLoadedState(
            data: list,
          ));
        } on DioError catch (e) {
          log('line 32 $e');
          emit(
            NewsLoadingErrorState(
              HandlingNetworkExceptions.returnErrorMessageDependingWithError(e),
            ),
          );
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
        emit(NewsLoadedState(data: news));
      } catch (e) {
        emit(NewsLoadingErrorState(e.toString()));
      }
    });
  }
}
