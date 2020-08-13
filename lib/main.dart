import 'package:flutter/material.dart';
import 'package:movie_store/src/pages/detail_page.dart';
import 'package:movie_store/src/pages/home_page.dart';
import 'package:movie_store/src/pages/start_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = ThemeData(
      primaryColorDark: Color(0xFFF46A2ED),
      primaryColorLight: Color(0xFFF46A2ED),
      primaryColor: Color(0xFFF46A2ED),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => Startpage(),
        'detalle': (BuildContext context) => DetailPage(),
      },
    );
  }
}
