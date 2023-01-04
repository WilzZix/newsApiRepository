part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<News> data;

  NewsLoadedState(this.data);
}

class NewsLoadingErrorState extends NewsState {}
