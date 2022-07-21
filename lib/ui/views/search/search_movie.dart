import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc/core/constant/colors.dart';
import 'package:movie_bloc/core/repositories/movie_detail/search_repository_impl.dart';
import 'package:movie_bloc/core/utils/debounce.dart';
import 'package:movie_bloc/ui/widgets/search_text_field.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchRepositoryImpl searchCubit =
        BlocProvider.of<SearchRepositoryImpl>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Platform.isAndroid
                        ? Icons.arrow_back
                        : CupertinoIcons.back)),
                Expanded(
                  child: SearchTextField(
                      fillColor: Colors.grey[900]!,
                      hintText: 'Search for a movie.',
                      searchCallback: (String value) => EasyDebounce.debounce(
                          'search',
                          const Duration(milliseconds: 300),
                          () => searchCubit.searchMovie(query: value)),
                      controller: _controller),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<SearchRepositoryImpl, SearchMovieState>(
                  builder: (context, state) {
                print("${state is SearchLoading}\n"
                    "${state is SearchSuccess}\n"
                    "${state is SearchError}\n"
                    "${state is SearchInitial}");

                if (state is SearchLoading) {
                  return Container(child: CircularProgressIndicator(),);
                } else if (state is SearchSuccess) {
                  return Text(
                    'Success ${state.searchList.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  );
                } else if (state is SearchError) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: Text(
                      'Error in loading data!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
