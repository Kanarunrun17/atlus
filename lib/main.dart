import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: AtlusApp()));
}

class AtlusApp extends StatelessWidget {
  const AtlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '@lus',
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
