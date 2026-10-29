
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HalamanLokasiKomunitas extends StatefulWidget {
  const HalamanLokasiKomunitas({super.key});

  @override
  State<HalamanLokasiKomunitas> createState() => _HalamanLokasiKomunitasState();
}

class _HalamanLokasiKomunitasState extends State<HalamanLokasiKomunitas> {
  // Contoh koordinat untuk demonstrasi di wilayah Bandung.
  // Sesuaikan dengan lokasi kantor yang benar jika data tersedia.
  static const LatLng _pusatPeta = LatLng(-6.914744, 107.609810);

  final Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId('Bank Sampah'),
      position: const LatLng(-6.914744, 107.609810),
      infoWindow: const InfoWindow(
        title: 'Bank Sampah Hijau',
        snippet: 'Bank Sampah Hijau',
      ),
    ),
  };

  GoogleMapController? _mapController;

  Future<void> _fokusBankSampah(LatLng posisi) async {
    await _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(posisi, 15),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lokasi Bank Sampah',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 255, 17),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: _pusatPeta,
                zoom: 15,
              ),
              markers: _markers,
              onMapCreated: (controller) {
                _mapController = controller;
              },
              mapToolbarEnabled: true,
              zoomControlsEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: const Text(
              'Daftar Kantor Pelayanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ..._markers.map((marker) {
            return ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 0, 255, 0),
                child: Icon(Icons.location_on, color: Colors.white),
              ),
              title: Text(marker.infoWindow.title ?? 'Kantor Bank Sampah'),
              subtitle: Text(marker.infoWindow.snippet ?? ''),
              trailing: const Icon(Icons.map_outlined),
              onTap: () => _fokusBankSampah(marker.position),
            );
          }),
        ],
      ),
    );
  }
}
