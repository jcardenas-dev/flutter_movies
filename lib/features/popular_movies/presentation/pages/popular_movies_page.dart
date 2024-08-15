import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies/core/blocs/events/movie_event.dart';
import 'package:flutter_movies/core/blocs/states/movie_state.dart';
import 'package:flutter_movies/features/popular_movies/presentation/blocs/popular_movie_bloc.dart';
import 'package:get_it/get_it.dart';

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
    // Disparar el evento LoadMovies cuando el widget se construya
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PopularMovieBloc>(context).add(LoadMovies());
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Popular Movies')),
      body: BlocBuilder<PopularMovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                );
              },
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No movies found.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<PopularMovieBloc>(context).add(LoadMovies());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}