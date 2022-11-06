import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'ui/main_screen.dart';

import 'package:provider/provider.dart';
import 'data/memory_repository.dart';

import 'mock_service/mock_service.dart';

Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    log('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider<MemoryRepository>(
  //     lazy: false,
  //     create: (_) => MemoryRepository(),
  //     child: MaterialApp(
  //       title: 'Recipes',
  //       debugShowCheckedModeBanner: false,
  //       theme: ThemeData(
  //         brightness: Brightness.light,
  //         primaryColor: Colors.white,
  //         primarySwatch: Colors.blue,
  //         visualDensity: VisualDensity.adaptivePlatformDensity,
  //       ),
  //       home: const MainScreen(),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return MultiProvider(
      // MultiProvider uses the providers property to define multiple providers.
      providers: [
        // The first provider is your existing ChangeNotifierProvider.
        ChangeNotifierProvider<MemoryRepository>(
          lazy: false,
          create: (_) => MemoryRepository(),
        ),
        // You add a new provider, which will use the new mock service.
        Provider(
          // Create the MockService and call create() to load the JSON files
          // (notice the .. cascade operator).
          create: (_) => MockService()..create(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Recipes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
