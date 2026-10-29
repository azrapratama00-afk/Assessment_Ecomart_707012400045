import 'package:flutter/foundation.dart';

@immutable
class Produk {
  const Produk({required this.nama, required this.harga});
  final String nama;
  final int harga; 
}

class ItemKeranjang {
  const ItemKeranjang({required this.produk, this.jumlah = 1});
  final Produk produk;
  final int jumlah;
}
