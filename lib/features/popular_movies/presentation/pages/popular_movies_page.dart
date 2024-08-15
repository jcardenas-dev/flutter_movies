import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies/core/blocs/events/movie_event.dart';
import 'package:flutter_movies/core/blocs/states/movie_state.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
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
                return MovieListItem(movie: movie);
              },
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No movies found.'));
        },
      )
    );
  }
}

class MovieListItem extends StatelessWidget {
  final Movie movie;

  const MovieListItem({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                movie.posterPath,
                height: 100,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie.overview,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Release Date: ${movie.releaseDate}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                // Handle favorite tap
              },
            ),
          ],
        ),
      ),
    );
  }

}