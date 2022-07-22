import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:movie_bloc/core/data_sources/movies/movies_local_data_source.dart';
import 'package:movie_bloc/core/data_sources/movies/movies_remote_data_source.dart';
import 'package:movie_bloc/core/repositories/search_repository/search_repository.dart';
import 'package:movie_bloc/core/repositories/search_repository/search_repository_impl.dart';
import 'package:movie_bloc/core/repositories/movie_repository/movie_repository.dart';
import 'package:movie_bloc/core/repositories/movie_repository/movie_repository_impl.dart';
import 'package:movie_bloc/core/services/http/http_service.dart';
import 'package:movie_bloc/core/services/http/http_service_impl.dart';
import 'package:movie_bloc/core/utils/file_helper.dart';
import 'core/services/connectivity/connectivity_service.dart';
import 'core/services/connectivity/connectivity_service_impl.dart';
import 'core/services/snackbar/snack_bar_service.dart';
import 'core/services/snackbar/snack_bar_service_impl.dart';

GetIt locator = GetIt.instance;

/// Setup function that is run before the App is run.
///   - Sets up singletons that can be called from anywhere
/// in the app by using locator<Service>() call.
///   - Also sets up factor methods for view models.
Future<void> setupLocator() async {
  // Services
  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );
  locator.registerLazySingleton<SnackBarService>(() => SnackBarServiceImpl());
  locator.registerLazySingleton<HttpService>(() => HttpServiceImpl());

  // Data sources
  locator.registerLazySingleton<MoviesLocalDataSource>(
    () => MoviesLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSourceImpl(),
  );

  // Repositories
  locator.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl());

  locator.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl());

  // Utils
  locator.registerLazySingleton<FileHelper>(() => FileHelperImpl());

  // External
  locator.registerLazySingleton<HiveInterface>(() => Hive);
}
