import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:search/presentation/bloc/search_movie_bloc.dart';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchMoviePage extends StatelessWidget {
  static const ROUTE_NAME = '/search-movie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchMovieBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchMovieBloc, SearchMovieState>(
              builder: (context, state) {
                if (state is SearchMovieLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchMovieHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return MovieCard(movie, "normal");
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchMovieError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: Text("No such movie exist"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
