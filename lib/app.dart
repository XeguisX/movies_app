import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/features/movie/presentation/screens/movie_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      routes: {
        '/': (context) => const MovieScreen(),
      },
      initialRoute: '/',
    );
  }
}
