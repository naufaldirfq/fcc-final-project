import 'package:dartx/dartx.dart';
import 'package:fcc_final_project/bloc/genre/genre_bloc.dart';
import 'package:fcc_final_project/bloc/movie/recommended/recommended_movie_bloc.dart';
import 'package:fcc_final_project/data/provider/api_provider.dart';
import 'package:fcc_final_project/presentation/movie/movie_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mekari_pixel/mekari_pixel.dart';

import '../../bloc/movie/movie_bloc.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _genreBloc = GenreBloc(ApiProvider());
  final _movieBloc = MovieBloc(ApiProvider());
  final _recommendedMovieBloc = RecommendedMovieBloc(ApiProvider());

  @override
  void initState() {
    super.initState();
    _genreBloc.fetchGenres();
    _movieBloc.fetchMovies();
    _recommendedMovieBloc.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _homeBody(),
    );
  }

  Widget _homeBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _userInfo(),
          _movieCategories(),
          const SizedBox(height: 16.0),
          _nowPlayingMovies(),
          const SizedBox(height: 16.0),
          _recommendedForYou(),
        ],
      ),
    );
  }

  Widget _userInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Jackie Mock", style: MpTextStyles.l.semiBold.inter),
              const Text("Balance IDR 3.000.000")
            ],
          ),
          CircleAvatar()
        ],
      ),
    );
  }

  Widget _movieCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Text("Categories", style: MpTextStyles.md.semiBold.inter),
        ),
        const SizedBox(height: 6.0),
        BlocBuilder<GenreBloc, GenreState>(
          bloc: _genreBloc,
          builder: (context, state) {
            if (state is GenresLoaded) {
              return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(state.genres.length, (index) {
                      var genre = state.genres[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: MpColors.mekari,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0),
                            child: Text(
                              genre,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
                  ));
            } else if (state is GenresError) {
              return Text(state.message);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }

  Widget _nowPlayingMovies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/ic_now_playing.svg'),
              const SizedBox(width: 5.0),
              Text("Now Playing", style: MpTextStyles.md.semiBold.inter),
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        BlocBuilder<MovieBloc, MovieState>(
          bloc: _movieBloc,
          builder: (context, state) {
            if (state is MovieLoaded) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(state.movies.length, (index) {
                    var movie = state.movies[index];
                    return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => MovieDetailPage(id: movie.id.toString(),)));
                          },
                          child: Card(
                            child: SizedBox(
                              width: 150,
                              height: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4.0),
                                    child: Image.network(
                                        "https://image.tmdb.org/t/p/w500${movie
                                            .posterPath}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      movie.title.orEmpty(),
                                      style: MpTextStyles.md.inter.semiBold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        const Icon(CupertinoIcons.star_fill,
                                          color: Colors.yellow,),
                                        const SizedBox(width: 8.0,),
                                        Text("${movie.voteAverage}/10")
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
                  }),
                ),
              );
            } else if (state is MovieError) {
              return Text(state.message);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )
      ],
    );
  }

  Widget _recommendedForYou() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Text(
              "Recommended for you", style: MpTextStyles.md.semiBold.inter),
        ),
        const SizedBox(height: 6.0),
        BlocBuilder<RecommendedMovieBloc, RecommendedMovieState>(
          bloc: _recommendedMovieBloc,
          builder: (context, state) {
            if (state is RecommendedMovieLoaded) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(state.movies.length, (index) {
                    var movie = state.movies[index];
                    return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => MovieDetailPage(id: movie.id.toString(),)));
                          },
                          child: Card(
                            child: Container(
                              width: 250,
                              height: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 100,
                                      width: 250,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4.0),
                                        child: Image.network(
                                          "https://image.tmdb.org/t/p/w500${movie
                                              .backdropPath}",
                                          fit: BoxFit.cover,),
                                      )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 16.0, 8.0, 0.0),
                                    child: Text(
                                      movie.title.orEmpty(),
                                      style: MpTextStyles.md.inter.semiBold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        const Icon(CupertinoIcons.star_fill,
                                          color: Colors.yellow,),
                                        const SizedBox(width: 8.0,),
                                        Text("${movie.voteAverage}/10")
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
                  }),
                ),
              );
            } else if (state is RecommendedMovieError) {
              return Text(state.message);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )
      ],
    );
  }
}
