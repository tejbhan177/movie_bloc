import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:movie_bloc/core/enums/connectivity_status.dart';
import 'connectivity_service.dart';
import 'package:meta/meta.dart';

part 'connectivity_state.dart';

class ConnectivityServiceImpl extends Cubit<ConnectivityState>
    implements ConnectivityService {
  final _log = Logger('ConnectivityServiceImpl');

  final _connectivityResultController = StreamController<ConnectivityStatus>();
  final _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _subscription;
  ConnectivityResult? _lastResult;
  bool _serviceStopped = false;

  @override
  Stream<ConnectivityStatus> get connectivity$ =>
      _connectivityResultController.stream;

  @override
  bool get serviceStopped => _serviceStopped;

  ConnectivityServiceImpl() : super(Disconnected()) {
    _subscription =
        _connectivity.onConnectivityChanged.listen(_emitConnectivity);
  }

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();

    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.none:
      default:
        return false;
    }
  }

  @override
  void start() async {
    _log.finer('ConnectivityService resumed');
    _serviceStopped = false;
    await _resumeSignal();
    _subscription.resume();
  }

  @override
  void stop() {
    _log.finer('ConnectivityService paused');
    _serviceStopped = true;

    _subscription.pause(_resumeSignal());
  }

  void _emitConnectivity(ConnectivityResult event) {
    if (event == _lastResult) return;

    _log.finer('Connectivity status changed to $event');
    _connectivityResultController.add(_convertResult(event));
    _lastResult = event;
  }

  ConnectivityStatus _convertResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        emit(Connected());
        return ConnectivityStatus.cellular;
      case ConnectivityResult.wifi:
        emit(Connected());
        return ConnectivityStatus.wiFi;
      case ConnectivityResult.none:
        emit(Disconnected());
        return ConnectivityStatus.offline;
      default:
        return ConnectivityStatus.offline;
    }
  }

  Future<void> _resumeSignal() async => true;
}
