import 'package:flutter/foundation.dart';

class FavoritProvider extends ChangeNotifier {
  final Set<String> _produkFavorit = {};

  Set<String> get produkFavorit => _produkFavorit;

  bool isFavorit(String namaProduk) {
    return _produkFavorit.contains(namaProduk);
  }

  void tambahFavorit(String namaProduk) {
    _produkFavorit.add(namaProduk);
    notifyListeners();
  }
}