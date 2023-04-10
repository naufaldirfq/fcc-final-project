import 'package:dartx/dartx.dart';
import 'package:fcc_final_project/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:fcc_final_project/data/provider/api_provider.dart';
import 'package:fcc_final_project/values/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mekari_pixel/mekari_pixel.dart';

import '../../bloc/movie/cast/movie_cast_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  final String id;

  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final _movieDetailBloc = MovieDetailBloc(ApiProvider());
  final _movieCastBloc = MovieCastBloc(ApiProvider());

  @override
  void initState() {
    super.initState();
    _movieDetailBloc.fetchMovies(widget.id);
    _movieCastBloc.fetchMovieCast(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        bloc: _movieDetailBloc,
        builder: (context, state) {
          if (state is MovieDetailLoaded) {
            var movie = state.movieDetail;
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      movie.posterPath != null ? "https://image.tmdb.org/t/p/w500${movie.backdropPath}" : placeholderImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  pinned: true,
                  floating: false,
                  snap: false,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      movie.posterPath != null ? "https://image.tmdb.org/t/p/w500${movie.posterPath}" : placeholderImageUrl,
                                      width: 70,
                                      height: 100,
                                    )),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title.orEmpty(),
                                        style: MpTextStyles.xl.semiBold,
                                        softWrap: true,
                                      ),
                                      Text("Action - English",
                                          style: MpTextStyles.xs),
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
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Actors",
                              style: MpTextStyles.sm,
                            ),
                          ),
                          BlocBuilder<MovieCastBloc, MovieCastState>(
                            bloc: _movieCastBloc,
                            builder: (context, state) {
                              if (state is MovieCastLoaded) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        state.movieCast.length, (index) {
                                      var cast = state.movieCast[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "https://image.tmdb.org/t/p/w500${cast.profilePath}",),
                                              radius: 30,
                                            ),
                                            const SizedBox(height: 4.0),
                                            Text(cast.name.orEmpty(),
                                                style: MpTextStyles.xs)
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              } else if (state is MovieCastError) {
                                return Text(state.message);
                              } else {
                                return const Center(child: CircularProgressIndicator());
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text("Overview", style: MpTextStyles.sm),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(movie.overview.orEmpty(), style: MpTextStyles.xs),
                          )
                        ],
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ],
            );
          } else if (state is MovieDetailError) {
            return Text(state.message);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
