part of 'bbc_news_bloc.dart';

@immutable
sealed class BbcNewsState {}

final class BbcNewsInitial extends BbcNewsState {}

class BBCNewsLoading extends BbcNewsState {}

class BBCNewsLoaded extends BbcNewsState {
  final List<News> data;

  BBCNewsLoaded(this.data);
}
