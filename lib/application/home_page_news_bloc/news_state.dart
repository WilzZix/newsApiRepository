part of 'news_bloc.dart';

@immutable
abstract class NewsState extends Equatable {}

class NewsInitial extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoadingState extends NewsState {
  NewsLoadingState();

  @override
  List<Object?> get props => [];
}

class NewsLoadedState extends NewsState {
  final List<News> data;

  NewsLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class NewsLoadingErrorState extends NewsState {
  final String message;

  NewsLoadingErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailNewsInfo extends NewsState {
  final News data;

  DetailNewsInfo(this.data);

  @override
  List<Object?> get props => [data];
}

///
class CountryNewsLoading extends NewsState {
  @override
  List<Object?> get props => [];
}

class CountryNewsLoadedState extends NewsState {
  final List<News> data;

  CountryNewsLoadedState(this.data);

  @override
  List<Object?> get props => [];
}

class CountryNewsLoadingErrorState extends NewsState {
  final String msg;

  CountryNewsLoadingErrorState(this.msg);

  @override
  List<Object?> get props => [];
}
