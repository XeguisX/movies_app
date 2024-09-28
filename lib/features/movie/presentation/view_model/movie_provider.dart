import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/di/di_container.dart';
import 'package:movies_app/features/movie/domain/entities/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final movieProvider = FutureProvider<List<Movie>>((ref) async {
  final movieRepository = ref.read(movieRepositoryProvider);

  final List<Movie> movies = await movieRepository.getMovies();

  return movies;
});

final nameFilterProvider = StateProvider<String>((ref) => '');
final categoryFilterProvider = StateProvider<String>((ref) => 'All');

Future<void> loadFilterSettings(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final nameFilter = prefs.getString('nameFilter') ?? '';
  final categoryFilter = prefs.getString('categoryFilter') ?? 'All';

  ref.read(nameFilterProvider.notifier).state = nameFilter;
  ref.read(categoryFilterProvider.notifier).state = categoryFilter;
}

Future<void> saveFilterSettings(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(
      'nameFilter', ref.read(nameFilterProvider.notifier).state);
  await prefs.setString(
      'categoryFilter', ref.read(categoryFilterProvider.notifier).state);
}

final searchProvider = FutureProvider.family<void, String>((ref, title) async {
  final query = Uri.encodeComponent(title);
  final url = Uri.parse('https://www.themoviedb.org/search?query=$query');

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
});
