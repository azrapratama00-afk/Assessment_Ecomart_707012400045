import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pembeli_model.dart';

class FormulirPage extends StatefulWidget {
  const FormulirPage({super.key});
  @override
  State<FormulirPage> createState() => _FormulirPageState();
}

class _FormulirPageState extends State<FormulirPage> {
  final namaController = TextEditingController();
  final alamatController = TextEditingController();
  bool setujuSyarat = false;
  String? pengirimanTerpilih;
  bool sedangMengirim = false;

  bool get formLengkap =>
      namaController.text.isNotEmpty &&
      alamatController.text.isNotEmpty &&
      setujuSyarat &&
      pengirimanTerpilih != null;

  @override
  void dispose() {
    namaController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  Future<void> kirimFormulir() async {
    setState(() => sedangMengirim = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    context.read<PembeliModel>().tambah(
      Pembeli(
        nama: namaController.text,
        alamat: alamatController.text,
        pengiriman: pengirimanTerpilih!,
      ),
    );
    setState(() => sedangMengirim = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pesanan Berhasil Dibuat')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Pemesanan')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            namaController.clear();
            alamatController.clear();
            setujuSyarat = false;
            pengirimanTerpilih = null;
          });
        },
        tooltip: 'Bersihkan formulir',
        child: const Icon(Icons.refresh),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/halaman-produk'),
              onLongPress: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pesanan Berhasil Dibuat'),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.event),
                  title: const Text('Produk'),
                  subtitle: const Text(
                    'Ketuk untuk detail, tahan untuk info singkat',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: alamatController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
              ),
            ),
            CheckboxListTile(
              value: setujuSyarat,
              title: const Text(
                'Saya menyetujui pesanan ini',
              ),
              onChanged: (nilai) {
                setState(() {
                  setujuSyarat = nilai ?? false;
                });
              },
            ),
            Column(
              children: ['Diantar', 'Ambil di Tempat'].map((pengiriman) {
                return RadioListTile<String>(
                  title: Text('Metode Pengiriman $pengiriman'),
                  value: pengiriman,
                  groupValue: pengirimanTerpilih,
                  onChanged: (nilai) {
                    setState(() {
                      pengirimanTerpilih = nilai;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: (formLengkap && !sedangMengirim)
                  ? kirimFormulir
                  : null,
              child: sedangMengirim
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Kirim Pesanan'),
            ),
          ],
        ),
      ),
    );
  }
}
