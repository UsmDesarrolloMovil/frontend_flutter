import 'package:esports_app/config/config.dart';
import 'package:esports_app/config/router/main_router.dart';
import 'package:flutter/material.dart';

void main() async {
  await Environment.initEnvironment();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Campeonatos ESports',
      routerConfig: mainRouter,
      theme: MainTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
