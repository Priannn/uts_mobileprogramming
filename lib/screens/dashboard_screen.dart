import 'package:flutter/material.dart';
import 'package:uts_mobileprogramming/screens/login_screen.dart';

// DashboardScreen adalah halaman utama setelah login berhasil
// Pakai StatelessWidget karena tidak ada state yang berubah di halaman ini
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Data dummy untuk ditampilkan di ListView
  // Berupa list of map, setiap map berisi title, subtitle, dan icon
  final List<Map<String, dynamic>> _menuItems = const [
    {
      'title': 'Profil Saya',
      'subtitle': 'Lihat dan edit profil',
      'icon': Icons.person,
    },
    {
      'title': 'Pengaturan',
      'subtitle': 'Atur preferensi aplikasi',
      'icon': Icons.settings,
    },
    {
      'title': 'Notifikasi',
      'subtitle': 'Lihat notifikasi masuk',
      'icon': Icons.notifications,
    },
    {
      'title': 'Riwayat',
      'subtitle': 'Lihat riwayat aktivitas',
      'icon': Icons.history,
    },
    {'title': 'Bantuan', 'subtitle': 'Pusat bantuan & FAQ', 'icon': Icons.help},
    {
      'title': 'Keamanan',
      'subtitle': 'Atur keamanan akun',
      'icon': Icons.security,
    },
    {
      'title': 'Pembayaran',
      'subtitle': 'Kelola metode pembayaran',
      'icon': Icons.payment,
    },
    {'title': 'Pesan', 'subtitle': 'Kotak masuk pesan', 'icon': Icons.message},
    {
      'title': 'Laporan',
      'subtitle': 'Lihat laporan aktivitas',
      'icon': Icons.bar_chart,
    },
    {'title': 'Tentang', 'subtitle': 'Informasi aplikasi', 'icon': Icons.info},
  ];

  // Fungsi logout — kembali ke halaman login dan hapus semua history navigasi
  void _handleLogout(BuildContext context) {
    // Tampilkan dialog konfirmasi sebelum logout
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // Judul dialog
        title: const Text('Konfirmasi Logout'),
        // Isi dialog
        content: const Text('Apakah kamu yakin ingin keluar?'),
        actions: [
          // Tombol Batal
          TextButton(
            onPressed: () {
              // Tutup dialog saja, tidak logout
              Navigator.pop(context);
            },
            child: const Text('Batal'),
          ),
          // Tombol Logout
          ElevatedButton(
            onPressed: () {
              // pushAndRemoveUntil = pindah ke halaman login dan hapus semua
              // history navigasi supaya user tidak bisa back ke dashboard
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false, // false = hapus semua route sebelumnya
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan judul dan tombol logout
      appBar: AppBar(
        // Judul AppBar
        title: const Text('Dashboard'),
        // Menghilangkan tombol back otomatis
        automaticallyImplyLeading: false,
        actions: [
          // Tombol logout di pojok kanan AppBar
          IconButton(
            icon: const Icon(Icons.logout),
            // Tooltip muncul saat tombol ditekan lama
            tooltip: 'Logout',
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          // Column menyusun widget secara vertikal
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card selamat datang di bagian atas
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                // Styling card dengan shadow dan rounded corner
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    // Row menyusun widget secara horizontal
                    children: [
                      // Avatar user
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16), // Jarak horizontal
                      // Teks sambutan
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang!',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          // Nama user yang sedang login
                          Text(
                            'Admin', // nanti bisa diganti dengan data user
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'admin@test.com',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Label "Menu"
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8), // Jarak vertikal
            // ListView.builder untuk menampilkan daftar menu
            // Expanded supaya ListView mengisi sisa ruang yang ada
            Expanded(
              child: ListView.builder(
                // Jumlah item yang ditampilkan
                itemCount: _menuItems.length,
                // Builder dipanggil untuk setiap item
                itemBuilder: (context, index) {
                  // Ambil data item berdasarkan index
                  final item = _menuItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    // Card untuk setiap item menu
                    child: Card(
                      // Styling card dengan shadow dan rounded corner
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        // Icon di sebelah kiri
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade50,
                          child: Icon(
                            item['icon'] as IconData,
                            color: Colors.blue,
                          ),
                        ),
                        // Judul item
                        title: Text(item['title'] as String),
                        // Subjudul item
                        subtitle: Text(item['subtitle'] as String),
                        // Icon panah di sebelah kanan
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          // Tampilkan snackbar saat item ditekan
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${item['title']} ditekan'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
