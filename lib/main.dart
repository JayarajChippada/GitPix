import 'package:flutter/material.dart';
import 'package:gitpix/models/bookmark_model.dart';
import 'package:gitpix/routes.dart';
import 'package:gitpix/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async{
  await dotenv.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookmarkModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitPix', 
      debugShowCheckedModeBanner: false, 

      onGenerateRoute: (settings) => generateRoute(settings),

      home: const SplashScreen(),
    );
  }
}


