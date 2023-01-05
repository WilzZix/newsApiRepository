part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class GetNewsEvent extends NewsEvent {}

class GetDetailInfoEvent extends NewsEvent {


  GetDetailInfoEvent();
}
