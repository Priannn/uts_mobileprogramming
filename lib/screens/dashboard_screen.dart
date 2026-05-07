import 'package:flutter/material.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Data dummy menu gym — 10 item
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
        // Judul dialog logout
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah kamu yakin ingin keluar dari eidipiGYM?'),
        actions: [
          // Tombol batal
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          // Tombol logout
          ElevatedButton(
            onPressed: () {
              // pushAndRemoveUntil = hapus semua history navigasi
              // supaya user tidak bisa back ke dashboard setelah logout
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              // Warna tombol logout merah
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
    return Scaffold(
      appBar: AppBar(
        // Judul AppBar dengan nama aplikasi
        title: const Text('eidipiGYM'),
        // Hilangkan tombol back otomatis
        automaticallyImplyLeading: false,
        actions: [
          // Tombol logout di pojok kanan
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card sambutan user
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
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang! 💪',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          // Nama user
                          Text(
                            'Admin eidipiGYM',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Email user
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

            // Label menu
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '🏋️ Menu Latihan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),

            // ListView 10 item menu gym
            Expanded(
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
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
                        title: Text(item['title'] as String),
                        subtitle: Text(item['subtitle'] as String),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          // Snackbar saat item ditekan
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
