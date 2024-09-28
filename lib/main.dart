import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://06a01abe7bc69714bcc748881bcc1d62@o4508030646616064.ingest.us.sentry.io/4508030655070208';
    },
  );

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      path: 'lang',
      fallbackLocale: const Locale('en', 'US'),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}
