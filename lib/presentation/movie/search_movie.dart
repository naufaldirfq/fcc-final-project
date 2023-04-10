import 'package:dartx/dartx.dart';
import 'package:fcc_final_project/data/provider/api_provider.dart';
import 'package:fcc_final_project/values/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mekari_pixel/mekari_pixel.dart';

import '../../bloc/movie/search/search_movie_bloc.dart';
import '../../data/model/movie_response.dart';
import 'movie_detail.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({Key? key}) : super(key: key);

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  final _searchTextController = TextEditingController();
  final _searchMovieBloc = SearchMovieBloc(ApiProvider());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _searchMovieWidget());
  }

  Widget _searchMovieWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MpSearch(
              controller: _searchTextController,
              onTextChanged: (query) {
                _searchMovieBloc.fetchMovies(query);
              },
            ),
          ),
          BlocBuilder<SearchMovieBloc, SearchMovieState>(
            bloc: _searchMovieBloc,
            builder: (context, state) {
              if (state is SearchMovieLoaded) {
                return _movieList(state.movies);
              } else if (state is SearchMovieError) {
                return Text(state.message);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }

  Widget _movieList(List<Movie> movies) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          physics: const ScrollPhysics(),
          separatorBuilder: (_, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Divider(),
              ),
          shrinkWrap: true,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            var movie = movies[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => MovieDetailPage(
                          id: movie.id.toString(),
                        )));
              },
              child: Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          movie.posterPath != null ? "https://image.tmdb.org/t/p/w500${movie.posterPath}" : placeholderPoster,
                          width: 70,
                          height: 100,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title.orEmpty(),
                            style: MpTextStyles.l.semiBold,
                            softWrap: true,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.star_fill,
                                color: Colors.yellow,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "${movie.voteAverage}/10",
                                style: MpTextStyles.xs,
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Released at ${movie.releaseDate}",
                            style: MpTextStyles.xs,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
