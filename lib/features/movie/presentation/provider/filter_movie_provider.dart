import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
