import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc/core/data_sources/movies/movies_local_data_source.dart';
import 'package:movie_bloc/core/managers/core_manager.dart';
import 'package:movie_bloc/locator.dart';
import 'package:movie_bloc/provider_setup.dart';
import 'package:movie_bloc/ui/shared/themes.dart' as themes;
import 'package:movie_bloc/ui/views/landingPage/landingPage.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final MoviesLocalDataSource? moviesLocalDataSource =
      locator<MoviesLocalDataSource>();

  @override
  void initState() {
    super.initState();
    handleStartUpLogic();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: CoreManager(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themes.darkMaterialTheme,
          home: const LandingPage(),
        ),
      ),
    );
  }

  Future handleStartUpLogic() async {
    await Future.wait([
      moviesLocalDataSource!.init(),
    ]);
  }
}
