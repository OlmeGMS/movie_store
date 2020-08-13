import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_store/src/models/actores_model.dart';
import 'package:movie_store/src/models/pelicula_model.dart';

class MovieProvider {
  String _apikey = '4193e6f9df379f4e2501c171e7ea4db4';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  int _carteleraPage = 0;
  bool _cargando = false;

  List<Pelicula> _cartelera = new List();
  List<Pelicula> _populares = new List();

  /* Crear stream */
  final _carteleraStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get carteleraSink =>
      _carteleraStreamController.sink.add;

  Stream<List<Pelicula>> get carteleraStream =>
      _carteleraStreamController.stream;

  /* Stream populares */
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _carteleraStreamController?.close();
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});

    return _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getCartelera() async {
    if (_cargando) return [];

    _cargando = true;
    _carteleraPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _carteleraPage.toString()
    });

    final resp = await _procesarRespuesta(url);
    _cartelera.addAll(resp);
    carteleraSink(_cartelera);

    _cargando = false;
    return resp;
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits',
        {'api_key': _apikey, 'language': _language});

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodeData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': query});

    return _procesarRespuesta(url);
  }
}
