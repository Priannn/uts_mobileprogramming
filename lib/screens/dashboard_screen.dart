import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import halaman login untuk fungsi logout
import 'package:uts_mobileprogramming/models/user_models.dart';

// DashboardScreen adalah halaman utama setelah login berhasil
// Pakai StatelessWidget karena tidak ada state yang berubah di halaman ini
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Data dummy untuk daftar menu di dashboard
  final List<Map<String, dynamic>> _menuItems = const [
    {
      'title': 'Jadwal Latihan',
      'subtitle': 'Lihat dan atur jadwal gym kamu',
      'icon': Icons.calendar_today,
    },
    {
      'title': 'Program Diet',
      'subtitle': 'Rekomendasi makanan sehat harianmu',
      'icon': Icons.restaurant_menu,
    },
    {
      'title': 'Progres Berat Badan',
      'subtitle': 'Pantau perkembangan berat badanmu',
      'icon': Icons.monitor_weight,
    },
    {
      'title': 'Cardio Tracker',
      'subtitle': 'Catat aktivitas lari dan cardio kamu',
      'icon': Icons.directions_run,
    },
    {
      'title': 'Yoga & Stretching',
      'subtitle': 'Panduan pemanasan dan pendinginan',
      'icon': Icons.self_improvement,
    },
    {
      'title': 'Suplemen',
      'subtitle': 'Info suplemen dan jadwal konsumsi',
      'icon': Icons.medical_services,
    },
    {
      'title': 'Personal Trainer',
      'subtitle': 'Hubungi trainer profesionalmu',
      'icon': Icons.person,
    },
    {
      'title': 'Booking Kelas',
      'subtitle': 'Daftar kelas gym favoritmu',
      'icon': Icons.book_online,
    },
    {
      'title': 'Leaderboard Member',
      'subtitle': 'Lihat peringkat member teraktif',
      'icon': Icons.leaderboard,
    },
    {
      'title': 'Pengaturan Akun',
      'subtitle': 'Atur profil dan preferensi kamu',
      'icon': Icons.settings,
    },
  ];

  // Fungsi logout dengan dialog konfirmasi
  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // Judul dialog konfirmasi logout
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah kamu yakin ingin keluar dari eidipiGYM?'),
        actions: [
          // Tombol batal — tutup dialog saja
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          // Tombol logout
          ElevatedButton(
            onPressed: () {
              // pushAndRemoveUntil = pindah ke login dan hapus semua
              // history navigasi supaya user tidak bisa back ke dashboard
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false, // false = hapus semua route sebelumnya
              );
            },
            style: ElevatedButton.styleFrom(
              // Warna merah untuk tombol logout
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil data user yang dikirim dari halaman user models login melalui arguments
    final user = ModalRoute.of(context)?.settings.arguments as UserModel?;

    // Ambil nama dan email dari arguments
    final String nama = user?.name ?? 'Admin eidipiGYM';
    final String email = user?.email ?? 'admin@test.com';

    return Scaffold(
      appBar: AppBar(
        // Judul AppBar
        title: const Text('eidipiGYM'),
        // Hilangkan tombol back otomatis
        automaticallyImplyLeading: false,
        actions: [
          // Tombol logout di pojok kanan AppBar
          IconButton(
            icon: const Icon(Icons.logout),
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
            // Card sambutan user di bagian atas
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
                      // Avatar dengan icon gym
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.orange,
                        child: Icon(
                          Icons.fitness_center, // Icon barbel
                          size: 30,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 16), // Jarak horizontal
                      // Kolom teks sambutan
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selamat Datang! 💪',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          // Nama user — diambil dari state login
                          Text(
                            nama,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Email user — diambil dari state login
                          Text(
                            email,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Label menu
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '🏋️ Menu Latihan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8), // Jarak vertikal
            // ListView.builder untuk menampilkan daftar menu gym
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
                        // Icon menu dengan background oranye muda
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange.shade50,
                          child: Icon(
                            item['icon'] as IconData,
                            color: Colors.orange,
                          ),
                        ),
                        // Judul item menu
                        title: Text(item['title'] as String),
                        // Subjudul item menu
                        subtitle: Text(item['subtitle'] as String),
                        // Icon panah di sebelah kanan
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          // Tampilkan snackbar saat item menu ditekan
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
