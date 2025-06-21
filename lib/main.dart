import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/theme.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/core/router/app_router.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ICHEJA Mobile',
      theme: CustomTheme.themeData,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
