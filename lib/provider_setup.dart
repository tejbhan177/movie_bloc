import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc/core/repositories/search_repository/search_repository_impl.dart';
import 'package:movie_bloc/core/repositories/movie_repository/movie_repository_impl.dart';
import 'package:movie_bloc/core/services/connectivity/connectivity_service_impl.dart';

/// List of providers that provider transforms into a widget tree
/// with the main app as the child of that tree, so that the entire
/// app can use these streams anywhere there is a [BuildContext]
List<BlocProvider> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<BlocProvider> independentServices = [];

List<BlocProvider> dependentServices = [];

List<BlocProvider> uiConsumableProviders = [
  BlocProvider<ConnectivityServiceImpl>(
    create: (context) => ConnectivityServiceImpl(),
  ),
  BlocProvider<MovieRepositoryImpl>(
    create: (context) => MovieRepositoryImpl(),
  ),
  BlocProvider<SearchRepositoryImpl>(
    create: (context) => SearchRepositoryImpl(),
  ),
];
