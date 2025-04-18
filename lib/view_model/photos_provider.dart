import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:note_vault/model/photos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/remote/api_service.dart';

class PhotosProvider extends ChangeNotifier {


  List<Photos> _myPhotosList = [];
  bool _isLoading = false;
  bool _isSearching = false;
  List<Photos> _searchResults = [];
  int offset = 0;
  final int limit = 10;
  bool _hasMore = true;
  late List<Photos> _favourites = [];

  List<Photos> get myPhotosList => _myPhotosList;
  List<Photos> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  bool get hasMore => _hasMore;
  List<Photos> get favourites => _favourites;

  PhotosProvider() {
    fetchPhotos();
    debugPrint("photo provider");
  }

  Future<void> fetchPhotos() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      _myPhotosList = await ApiService().fetchPhotos(limit, offset);


      if (_myPhotosList.isNotEmpty) {
        offset += limit;
      }else{
        _hasMore = false;
      }
      debugPrint("unfiltered photos  ${_myPhotosList.length}");
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchTasks(String query) {
    if (query.isNotEmpty) {
      _searchResults =
          _myPhotosList.where((photos) {
            return photos.title.toString().contains(query);
          }).toList();
    } else {
      _searchResults = _myPhotosList;
    }
    notifyListeners();
  }

  void setSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  Future<void> refreshData() async {
    fetchPhotos();
  }

  // void toggleFavourite(Works photo) {
  //   if (_favourites.contains(photo)) {
  //     _favourites.remove(photo);
  //   } else {
  //     _favourites.add(photo);
  //   }
  //   notifyListeners();
  // }
  //
  // bool isFavourite(Works photo) => _favourites.contains(photo);

  void toggleFavourite(Photos photo) {
    final isFav = _favourites.any((b) => b.id == photo.id);
    if (isFav) {
      _favourites.removeWhere((b) => b.id == photo.id);
    } else {
      _favourites.add(photo);
    }
    saveFavorites();
    notifyListeners();
  }

  bool isFavourite(Photos photo) => _favourites.any((b) => b.id == photo.id);

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favJson = _favourites.map((b) => json.encode(b.toJson())).toList();
    await prefs.setStringList('favorites', favJson);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favJson = prefs.getStringList('favorites') ?? [];
    _favourites = favJson.map((favt) => Photos.fromJson(json.decode(favt))).toList();
    notifyListeners();
  }
}
