import 'package:flutter/material.dart';

import '../pages/halaman_form_pemesanan.dart';
import '../pages/halaman_lokasi_komunitas.dart';
import '../pages/halaman_produk.dart';
import 'kerangka_navigasi.dart';
import '../pages/route_tidak_dikenal_page.dart';

class AppRoutes {
  // Nama-nama route
  static const String produk = '/';
  static const String form = '/halaman-form-pemesanan';
  static const String lokasi = '/halaman-lokasi-komunitas';

  // Daftar route
  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      produk: (context) => const KerangkaNavigasi(),
      form: (context) => const FormulirPage(),
      lokasi: (context) => const HalamanLokasiKomunitas(),
    };
  }

  // Route yang membutuhkan arguments
  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    switch (settings.name) {
      case :
        final HalamanProduk = settings.arguments as Map<String, String>;

        return MaterialPageRoute(
          builder: (context) {
            return HalamanProduk(produk: produk);
          },
        );

      default:
        return null;
    }
  }

  // Route jika nama route tidak ditemukan
  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return const RouteTidakDikenalPage();
      },
    );
  }
}
