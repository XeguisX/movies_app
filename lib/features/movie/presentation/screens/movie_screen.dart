import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movies_app/features/movie/presentation/view_model/movie_provider.dart';

class MovieScreen extends ConsumerWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsyncValue = ref.watch(movieProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: movieAsyncValue.when(
        data: (movie) {
          return Container();
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
