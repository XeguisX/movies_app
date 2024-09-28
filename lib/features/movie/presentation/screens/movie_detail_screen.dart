import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/movie/domain/entities/movie.dart';
import 'package:movies_app/features/movie/presentation/provider/providers.dart';
import 'package:movies_app/shared/widgets/widgets.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {
  const MovieDetailScreen({super.key, required this.movie});

  final Movie movie;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(movie: widget.movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(movie: widget.movie),
                _Overview(movie: widget.movie),
                const SizedBox(height: 10),
                SearchMoreInfoButton(
                  movieTitle: widget.movie.title,
                  onPressed: () {
                    ref
                        .read(searchNavigateProvider(widget.movie.title).future)
                        .then((_) {})
                        .catchError(
                      (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $error')),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no_image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textTheme.headlineMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(movie.originalTitle,
                    style: textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Row(
                  children: [
                    const Icon(Icons.star_outline,
                        size: 15, color: Colors.grey),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(movie.voteAverage.toString(),
                        style: textTheme.labelSmall)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      child: Column(
        children: [
          Text(
            movie.overview,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}

class SearchMoreInfoButton extends StatelessWidget {
  final String movieTitle;
  final Function() onPressed;

  const SearchMoreInfoButton({
    super.key,
    required this.movieTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Colors.blueAccent),
          ),
        ),
        onPressed: onPressed,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search),
            SizedBox(width: 8),
            Text(
              'Find More Info',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
