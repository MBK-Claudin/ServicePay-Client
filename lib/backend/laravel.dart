import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:flutter/cupertino.dart';

class ConnexionLaravel {
  final String _url = "http://10.0.2.2:8000/api/";

  inscription(info, laravelUrl) async {
    var urlcomplet = _url + laravelUrl;
    return await http.post(
      Uri.parse(urlcomplet),
      body: jsonEncode(info),
      headers: _headers(),
    );
  }

  allService(urlLaravel) async {
    var url = _url + urlLaravel;
    return await http.get(
      Uri.parse(url),
    );
  }

  demandeService(data, urlLaravel) async {
    var urlcomplet = _url + urlLaravel;
    return await http.post(
      Uri.parse(urlcomplet),
      body: jsonEncode(data),
      headers: _headers(),
    );
  }

  modifierNOM(data, urlLaravel) async {
    var urlcomplet = _url + urlLaravel;
    return await http.post(
      Uri.parse(urlcomplet),
      body: jsonEncode(data),
      headers: _headers(),
    );
  }

  connexion(info, laravelUrl) async {
    var urlcomplet = _url + laravelUrl;
    return await http.post(
      Uri.parse(urlcomplet),
      body: jsonEncode(info),
      headers: _headers(),
    );
  }

  envoiSuggestion(info, laravelUrl) async {
    var urlcomplet = _url + laravelUrl;
    return await http.post(
      Uri.parse(urlcomplet),
      body: jsonEncode(info),
      headers: _headers(),
    );
  }

  recupeClient(laravelUrl) async {
    var urlcomplet = _url + laravelUrl;
    return await http.get(Uri.parse(urlcomplet));
  }

  afficheDemande(laravelUrl) async {
    var urlcomplet = _url + laravelUrl;
    return await http.get(Uri.parse(urlcomplet));
  }

  _headers() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
