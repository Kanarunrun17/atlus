import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';

void main() {
  runApp(const ProviderScope(child: AtlusApp()));
}

class AtlusApp extends StatelessWidget {
  const AtlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '@lus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
