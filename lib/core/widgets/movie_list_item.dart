import 'package:flutter/material.dart';
import 'package:flutter_movies/core/domain/entities/movie.dart';
import 'package:provider/provider.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final VoidCallback onFavoritePressed; // Define el callback

  const MovieListItem({
    super.key,
    required this.movie,
    required this.onFavoritePressed
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: movie,
      child: Card(
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
              ),
              Consumer<Movie>(
                builder: (context, movie, child) {
                  return IconButton(
                    icon: Icon(movie.isFavorite ? Icons.favorite : Icons.favorite_border),
                    onPressed: onFavoritePressed,
                  );
                },
              )
            ],
          ),
        ),
      )
    );
  }

}