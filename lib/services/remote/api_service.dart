import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:note_vault/model/photos.dart';

class ApiService{
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

   Future<List<Photos>> fetchPhotos(int limit, int offset) async {

    final response = await http.get(Uri.parse('$_baseUrl/photos?limit=$limit&offset=$offset'));

    debugPrint("my_photos url :- ${response.request!.url}");

    if(response.statusCode == 200){
      debugPrint("my_photos response ${response.body}");

        final List photosResponse = json.decode(response.body);
        return photosResponse.map((json) => Photos.fromJson(json)).toList();
      // }
    }else{
      throw Exception('Failed to load photos');
    }

  }
}