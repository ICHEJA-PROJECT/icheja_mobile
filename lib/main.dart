import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/core/router/app_router.dart';
import 'package:icheja_mobile/common/presentation/theme/theme.dart';
import 'package:icheja_mobile/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Icheja Mobile',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.themeData,
      routerConfig: router,
    );
  }
}
