import 'package:movie_bloc/core/enums/connectivity_status.dart';
import 'package:movie_bloc/core/services/stoppable_service.dart';

abstract class ConnectivityService implements StoppableService {
  Stream<ConnectivityStatus> get connectivity$;

  Future<bool> get isConnected;
}
