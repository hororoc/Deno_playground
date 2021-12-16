import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_search_app/model/photo.dart';

class PixabayApi {
  final baseUrl = 'https://pixabay.com/api/';
  final key = '24829672-e86462931ca2f2cf80fb27137';

  Future<List<Photo>> fetch(String query) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl?key=$key&q=$query&image_type=photo&pretty=true',
      ),
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];

    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}
