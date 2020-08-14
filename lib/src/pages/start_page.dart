import 'package:flutter/material.dart';
import 'package:movie_store/src/blocs/theme.dart';
import 'package:movie_store/src/providers/movie_provider.dart';
import 'package:movie_store/src/search/search_delegate.dart';
import 'package:movie_store/src/widgets/movie_horizontal_widget.dart';
import 'package:provider/provider.dart';

class Startpage extends StatefulWidget {
  Startpage({Key key}) : super(key: key);

  @override
  _StartpageState createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  final peliculasProvider = new MovieProvider();
  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return Scaffold(
      //backgroundColor: Color.fromRGBO(2, 24, 41, 0.9),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[_headPage(), _bodyMovies(context)],
      ),
    );
  }

  Widget _headPage() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.5,
      decoration: BoxDecoration(color: Color.fromRGBO(70, 162, 237, 0.9)),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Text(
              'Hello, what do you\nwant to watch?',
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.white,
                //backgroundColor: Color.fromRGBO(70, 162, 237, 0)
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Material(
                elevation: 1.0,
                color: Color.fromRGBO(70, 162, 237, 0.7),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: TextField(
                  controller: TextEditingController(text: 'search you movie'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    //backgroundColor: Color.fromRGBO(70, 162, 237, 0)
                  ),
                  cursorColor: Color(0xFFF46A2ED),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 14.0),
                      suffixIcon: Material(
                          elevation: 1.0,
                          color: Color.fromRGBO(70, 162, 237, 0.7),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          child: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              showSearch(
                                  context: context, delegate: DataSearch());
                            },
                          ))),
                  onTap: () {
                    showSearch(context: context, delegate: DataSearch());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodyMovies(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.40),
      width: double.infinity,
      decoration: BoxDecoration(
          //color: Color.fromRGBO(2, 24, 41, 0.9),
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Text(
                  'RECOMMENDED FOR YOU',
                  style: Theme.of(context).textTheme.bodyText1,
                  /*style: TextStyle(
                      fontSize: 14.0, height: 1.5, color: Colors.white),*/
                ),
                SizedBox(
                  width: 100,
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  color: Theme.of(context).backgroundColor,
                  onPressed: () {
                    Navigator.pushNamed(context, 'config');
                  },
                ),
              ],
            ),
            _firstMovie(),
            Text(
              'TOP RATED',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 10,
            ),
            _secondMovies(context)
          ],
        ),
      ),
    );
  }

  Widget _firstMovie() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return MovieHorizontal(
            peliculas: snapshot.data,
            siguientePagina: peliculasProvider.getCartelera,
          );
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _secondMovies(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
