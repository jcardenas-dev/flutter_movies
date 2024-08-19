import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies/core/blocs/events/movie_event.dart';
import 'package:flutter_movies/core/blocs/states/movie_state.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:flutter_movies/features/home/presentation/blocs/events/favorite_events.dart';
import 'package:flutter_movies/features/home/presentation/blocs/home_movies_bloc.dart';
import 'package:flutter_movies/l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<HomeMoviesBloc>(),
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
      BlocProvider.of<HomeMoviesBloc>(context).add(LoadMovies());
    });

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('navBarHomeTitle'))),
      body: BlocBuilder<HomeMoviesBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return Dismissible(
                  key: Key('${movie.id}'), // La clave única para identificar cada item
                  direction: DismissDirection.endToStart, // Dirección del swipe (de derecha a izquierda)
                  onDismissed: (direction) {
                    // Eliminar el item de la lista
                    BlocProvider.of<HomeMoviesBloc>(context).add(DeleteFavoriteMovie(movieId: movie.id));

                    // Mostrar un mensaje de confirmación
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${movie.title} ${localizations.translate('deleteFavoriteMessage')}')),
                    );
                  },
                  background: Container(
                    color: Colors.red, // Color de fondo cuando se desliza
                    alignment: Alignment.centerRight, // Alineación del icono
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white), // Icono de eliminar
                  ),
                  child: FavoriteMovieListItem(
                    movie: movie,
                  ),
                );
              },
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite_border,
                  size: 50,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  localizations.translate('emptyFavoritesMessage'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}

class FavoriteMovieListItem extends StatelessWidget {
  final Movie movie;

  const FavoriteMovieListItem({
    super.key,
    required this.movie,
  });

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
                errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      width: 80,
                      color: Colors.grey[300], // Color de fondo para el ícono
                      child: const Icon(
                        Icons.broken_image, // Ícono de imagen rota
                        color: Colors.grey,
                        size: 48,
                      ),
                    );
                  },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        movie.releaseDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${movie.voteAverage.toStringAsFixed(1)}/10',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
