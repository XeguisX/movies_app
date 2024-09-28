import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final searchNavigateProvider =
    FutureProvider.family<void, String>((ref, title) async {
  final query = Uri.encodeComponent(title);
  final url = Uri.parse('https://www.themoviedb.org/search?query=$query');

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
});
