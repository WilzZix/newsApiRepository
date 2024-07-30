part of 'connection_bloc.dart';

@immutable
sealed class ConnectionCheckerEvent extends Equatable {
  const ConnectionCheckerEvent();

  @override
  List<Object> get props => [];
}

class ConnectivityChanged extends ConnectionCheckerEvent {
  final bool isConnected;

  const ConnectivityChanged(this.isConnected);

  @override
  List<Object> get props => [isConnected];
}
