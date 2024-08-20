import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies/core/blocs/events/movie_event.dart';
import 'package:flutter_movies/core/blocs/states/movie_state.dart';
import 'package:flutter_movies/core/widgets/movie_list_item.dart';
import 'package:flutter_movies/features/movie_detail/presentation/pages/movie_detail_page.dart';
import 'package:flutter_movies/features/popular_movies/presentation/blocs/popular_movie_bloc.dart';
import 'package:flutter_movies/l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class PopularMoviesPage extends StatelessWidget {
  const PopularMoviesPage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<PopularMovieBloc>(),
      child: _PopularMoviesPageState(),
    );
  }
  
}

class _PopularMoviesPageState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // Disparar el evento LoadMovies cuando el widget se construya
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PopularMovieBloc>(context).add(LoadMovies());
    });

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('navBarPopularTitle'))),
      body: BlocBuilder<PopularMovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return ChangeNotifierProvider.value(
                  value: movie,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DetailPage(movieId: movie.id)
                      ));
                    },
                    child: MovieListItem(
                      movie: movie,
                      onFavoritePressed: () {
                        BlocProvider.of<PopularMovieBloc>(context).add(ToggleFavorite(movieId: movie.id));
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text(localizations.translate('noMoviesFoundMessage')));
        },
      )
    );
  }
}
