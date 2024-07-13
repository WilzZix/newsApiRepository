part of 'bbc_news_bloc.dart';

@immutable
sealed class BbcNewsEvent {}

class GetBBCNewsEvent extends BbcNewsEvent {}
