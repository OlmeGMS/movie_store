import 'package:flutter/material.dart';
import 'package:movie_store/src/blocs/theme.dart';
import 'package:provider/provider.dart';

class ConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Config'),
      ),
      body: ListOption(),
    );
  }
}

class ListOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Column(
      children: <Widget>[
        FlatButton(
            onPressed: () =>
                theme.setTheme(ThemeData(primaryColor: Colors.white)),
            child: Text('Ligth')),
        FlatButton(
            onPressed: () => theme.setTheme(ThemeData.dark()),
            child: Text('Dark')),
      ],
    );
  }
}
