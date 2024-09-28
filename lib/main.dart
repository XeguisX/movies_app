import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:movies_app/features/movie/presentation/screens/movie_screen.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://06a01abe7bc69714bcc748881bcc1d62@o4508030646616064.ingest.us.sentry.io/4508030655070208';
      },
    );

    runApp(const ProviderScope(child: MyApp()));
  }, (exception, stackTrace) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      routes: {
        '/': (context) => const MovieScreen(),
      },
      initialRoute: '/',
    );
  }
}
