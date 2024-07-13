part of 'news_bloc.dart';

@immutable
abstract class NewsEvent extends Equatable {}

class GetNewsEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}

class GetNextPageEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}

class GetDetailInfoEvent extends NewsEvent {
  GetDetailInfoEvent();

  @override
  List<Object?> get props => [];
}

class GetCountryNewsEvent extends NewsEvent {
  final String country;

  GetCountryNewsEvent(this.country);

  @override
  List<Object?> get props => [];
}

class GetEverythingNewsEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}
