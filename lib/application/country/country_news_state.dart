part of 'country_news_cubit.dart';

@immutable
abstract class CountryNewsState {}

class CountryNewsInitial extends CountryNewsState {}

class CountryNewsLoading extends CountryNewsState {}

class CountryNewsLoadedState extends CountryNewsState {
  final List<News> data;

  CountryNewsLoadedState(this.data);
}

class CountryNewsLoadingErrorState extends CountryNewsState {
  final String msg;

  CountryNewsLoadingErrorState(this.msg);
}
