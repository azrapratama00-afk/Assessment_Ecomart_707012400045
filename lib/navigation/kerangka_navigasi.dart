import 'package:flutter/material.dart';

import '../pages/halaman_form_pemesanan.dart';
import '../pages/halaman_lokasi_komunitas.dart';
import '../pages/halaman_produk.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _index = 0;

  final List<Widget> _halaman = const [
    HalamanProduk(),
    FormulirPage(),
    HalamanLokasiKomunitas(),
  ];

  void _ubahHalaman(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double lebarLayar = MediaQuery.of(context).size.width;

    // Breakpoint tugas: 600 logical pixels
    final bool layarLebar = lebarLayar >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nusantara Cerdas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 60, 255, 0),
        foregroundColor: Colors.white,
      ),

      // =========================
      // NAVIGATION DRAWER
      // =========================
      drawer: NavigationDrawer(
        onDestinationSelected: (index) {
          // Tutup drawer terlebih dahulu
          Navigator.pop(context);

          if (index == 0) {
            _ubahHalaman(0);
          } else if (index == 1) {
            _ubahHalaman(1);
          } else if (index == 2) {
            _ubahHalaman(2);
          } else if (index == 3) {
            Navigator.pushNamed(context, AppRoutes.produk);
          } else if (index == 4) {
            Navigator.pushNamed(context, AppRoutes.form);
          } else if (index == 5) {
            Navigator.pushNamed(context, AppRoutes.lokasi);
          } else if (index == 6) {
            _tampilkanDialogKeluar(context);
          }
        },
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 20, 16, 12),
            child: Text(
              'EcoMart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          const NavigationDrawerDestination(
            icon: Icon(Icons.production_quantity_limits_outlined),
            selectedIcon: Icon(Icons.production_quantity_limits),
            label: Text('Produk'),
          ),

          const NavigationDrawerDestination(
            icon: Icon(Icons.forum_outlined),
            selectedIcon: Icon(Icons.forum),
            label: Text('Formulir Pemesanan'),
          ),

          const NavigationDrawerDestination(
            icon: Icon(Icons.location_on_outlined),
            selectedIcon: Icon(Icons.location_on),
            label: Text('Lokasi Bank Sampah'),
          ),


          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Divider(),
          ),

          const NavigationDrawerDestination(
            icon: Icon(Icons.logout),
            selectedIcon: Icon(Icons.logout),
            label: Text('Keluar'),
          ),
        ],
      ),

      body: Row(
        children: [
          // Layar >= 600px
          if (layarLebar)
            NavigationRail(
              selectedIndex: _index,
              onDestinationSelected: _ubahHalaman,
              labelType: NavigationRailLabelType.all,
              destinations: [
                const NavigationRailDestination(
                  icon: Icon(Icons.production_quantity_limits_outlined),
                  selectedIcon: Icon(Icons.production_quantity_limits),
                  label: Text('Produk'),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.forum_outlined),
                  selectedIcon: Icon(Icons.forum),
                  label: Text('Formulir'),
                ),
              ],
            ),

          // Konten halaman
          Expanded(child: _halaman[_index]),
        ],
      ),
      bottomNavigationBar: layarLebar
          ? null
          : NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: _ubahHalaman,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.production_quantity_limits_outlined),
                  selectedIcon: Icon(Icons.production_quantity_limits),
                  label: 'Produk',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.forum_outlined),
                  selectedIcon: Icon(Icons.forum),
                  label: 'Formulir',
                ),
              ],
            ),
    );
  }

  void _tampilkanDialogKeluar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}
