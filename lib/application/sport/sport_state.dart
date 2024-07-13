part of 'sport_bloc.dart';

@immutable
sealed class SportState {}

final class SportInitial extends SportState {}

class SportNewsLoading extends SportState {}

class SportNewsLoaded extends SportState {
  final List<News> data;

  SportNewsLoaded(this.data);
}
