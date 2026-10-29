import 'package:flutter/foundation.dart';

class Pembeli {
  final String nama;
  final String alamat;
  final String pengiriman;
  Pembeli({required this.nama, required this.alamat, required this.pengiriman});
}

class PembeliModel extends ChangeNotifier {
  final List<Pembeli> _daftar = [];
  List<Pembeli> get daftar => List.unmodifiable(_daftar);
  void tambah(Pembeli pembeli) {
    _daftar.add(pembeli);
    notifyListeners();
  }
  int jumlahSesi(String pengiriman) => _daftar.where((p) => p.pengiriman == pengiriman).length;
}
