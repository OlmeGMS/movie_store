import 'package:flutter/material.dart';
import 'package:movie_store/src/blocs/theme.dart';
import 'package:movie_store/src/pages/config_page.dart';
import 'package:movie_store/src/pages/detail_page.dart';
import 'package:movie_store/src/pages/start_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeChanger(ThemeData.dark()),
      child: MaterialAPPWithTheme(),
    );
  }
}

class MaterialAPPWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      title: 'Movie App',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => Startpage(),
        'detalle': (BuildContext context) => DetailPage(),
        'config': (BuildContext context) => ConfigPage()
      },
    );
  }
}
