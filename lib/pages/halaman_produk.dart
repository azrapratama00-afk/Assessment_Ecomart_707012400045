import 'package:ecomart_707012400045/models/favorit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/keranjang_cubit.dart';
import '../models/produk.dart';
import '../navigation/app_routes.dart';

class HalamanProduk extends StatelessWidget {
  const HalamanProduk({super.key});
  static const daftarProduk = [
    Produk(nama: 'Pupuk Kompos Organik', harga: 15000),
    Produk(nama: 'Pot Tanaman Daur Ulang', harga: 25000),
    Produk(nama: 'Tas Kemasan Daur Ulang', harga: 35000),
  ];
  String rupiah(int nilai) => 'Rp${nilai.toString()}';
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: daftarProduk.length,
      separatorBuilder: (context, indeks) => const SizedBox(height: 8),
      itemBuilder: (context, indeks) {
        final produk = daftarProduk[indeks];
        return Card(
          child: ListTile(
            leading: Text(produk.nama, style: const TextStyle(fontSize: 32)),
            title: Text(produk.nama),
            subtitle: Text(rupiah(produk.harga)),
            trailing: FilledButton(
              onPressed: () {
                context.read<KeranjangCubit>().tambahKeranjang(produk);
              },
              child: const Text('Tambah'),
            ),
          ),
        );
      },
    );
  }

  Widget DaftarProduk(BuildContext context, List<Map<String, String>> produk) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: produk.length,
      itemBuilder: (context, index) {
        final item = produk[index];
        final namaproduk = item['nama']!;

        // Memantau perubahan status favorit
        final favoritProvider = context.watch<FavoritProvider>();
        final isFavorit = favoritProvider.isFavorit(namaproduk);

        return Card(
          margin: const EdgeInsets.only(bottom: 14),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),

            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.miscellaneous_services,
                color: Color.fromARGB(255, 51, 255, 0),
              ),
            ),

            title: Text(
              namaproduk,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            // Tombol favorit dan detail
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: isFavorit
                      ? 'Hapus dari favorit'
                      : 'Tambah ke favorit',
                  icon: Icon(
                    isFavorit ? Icons.star : Icons.star_border,
                    color: isFavorit ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () {
                    if (isFavorit) {
                      context.read<FavoritProvider>();
                    } else {
                      context.read<FavoritProvider>().tambahFavorit(namaproduk);
                    }
                  },
                ),

                const Icon(Icons.arrow_forward_ios, size: 18),
              ],
            ),

            onTap: () async {
              final hasil = await Navigator.pushNamed(
                context,
                AppRoutes.produk,
                arguments: item,
              );

              if (hasil != null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(hasil.toString()),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
