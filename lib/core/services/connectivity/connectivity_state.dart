part of 'connectivity_service_impl.dart';

@immutable
abstract class ConnectivityState {}

class CheckingConnection extends ConnectivityState {}

class Connected extends ConnectivityState {}

class Disconnected extends ConnectivityState {}
