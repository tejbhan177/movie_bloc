import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc/core/services/connectivity/connectivity_service_impl.dart';
import 'package:movie_bloc/core/utils/custom_snackbar.dart';
import 'package:movie_bloc/ui/views/home/home.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityServiceImpl, ConnectivityState>(
        listener: (context, state) {
          if (state is Disconnected) {
            CustomSnackBar().showSnackBar(
                context: context,
                text: 'Disconnected',
                function: () => null,
                buttonText: 'OK');
          } else if (state is Connected) {
            CustomSnackBar().showSnackBar(
                context: context, text: 'Connected',
                function: () => null,
                buttonText: 'OK');
          }
        },
        child: const Home());
  }
}
