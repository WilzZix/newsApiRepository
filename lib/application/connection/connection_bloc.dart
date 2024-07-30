import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:infinite_scroll/application/connection/connection_state.dart';
import 'package:meta/meta.dart';

part 'connection_event.dart';

class ConnectionCheckerBloc
    extends Bloc<ConnectionCheckerEvent, ConnectionCheckerState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectionCheckerBloc() : super(ConnectionCheckerInitial()) {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      bool isConnected = result != ConnectivityResult.none;

      add(ConnectivityChanged(isConnected));
    });
    on<ConnectivityChanged>((event, emit) {
      log('line 26 ${event.isConnected}');
      if (event.isConnected) {
        emit(ConnectivitySuccess(event.isConnected));
      } else {
        emit(ConnectivityFailure());
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
