import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/keranjang_cubit.dart';
import 'pages/halaman_produk.dart';
import 'pages/halaman_form_pemesanan.dart';
import 'pages/halaman_lokasi_komunitas.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => KeranjangCubit(),
      child: const AplikasiKantin(),
    ),
  );
}

class AplikasiKantin extends StatelessWidget {
  const AplikasiKantin({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoMart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const KerangkaUtama(),
    );
  }
}

class KerangkaUtama extends StatefulWidget {
  const KerangkaUtama({super.key});
  @override
  State<KerangkaUtama> createState() => _KerangkaUtamaState();
}

class _KerangkaUtamaState extends State<KerangkaUtama> {
  int _indeks = 0;
  static const _halaman = [
    HalamanProduk(),
    FormulirPage(),
    HalamanLokasiKomunitas(),
  ];
  @override
  Widget build(BuildContext context) {
    final totalItem = context.select<KeranjangCubit, int>(
      (cubit) => cubit.state.fold(0, (total, item) => total + item.jumlah),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(_indeks == 0 ? 'Item Produk' : 'Keranjang($totalItem)'),
      ),
      body: IndexedStack(index: _indeks, children: _halaman),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indeks,
        onDestinationSelected: (nilaiBaru) {
          setState(() {
            _indeks = nilaiBaru;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.production_quantity_limits),
            label: 'Produk',
          ),
          NavigationDestination(
            icon: Icon(Icons.forum_outlined),
            selectedIcon: Icon(Icons.forum),
            label: 'Formulir',
          ),
          NavigationDestination(
            icon: Icon(Icons.location_city_outlined),
            selectedIcon: Icon(Icons.location_city),
            label: 'Lokasi',
          ),
        ],
      ),
    );
  }
}
