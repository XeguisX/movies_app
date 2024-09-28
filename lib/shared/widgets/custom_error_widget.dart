import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movies_app/features/movie/presentation/provider/providers.dart';

class CustomErrorWidget extends ConsumerWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(movieProvider).isLoading;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 100, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Failed to load movies.',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: isLoading
                ? null
                : () async {
                    ref.invalidate(movieProvider);
                  },
            icon: isLoading
                ? SpinPerfect(
                    infinite: true,
                    duration: const Duration(milliseconds: 500),
                    child: const Icon(Icons.rotate_right),
                  )
                : const Icon(Icons.rotate_right),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
