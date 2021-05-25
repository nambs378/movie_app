import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/screen/home_page.dart';
import 'package:movie_app/screen/login_page.dart';
import 'package:movie_app/screen/movie_detail_page.dart';

import 'model/movie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.routeName,
      // routes: {
      //   HomePage.routeName : (context) => HomePage(),
      //   MovieDetailPage.routeName : (context) => MovieDetailPage(),
      // },
      onGenerateRoute: (settings) {
        if (settings.name == MovieDetailPage.routeName) {
          final movie = settings.arguments as List<dynamic>; // Retrieve the value.
          return MaterialPageRoute(builder: (_) => MovieDetailPage(movie: movie[0], liked: movie[1],)); // Pass it to BarPage.
        }
        return null; // Let `onUnknownRoute` handle this behavior.
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        // textTheme: GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
      ),
      home: HomePage(),
    );
  }
}