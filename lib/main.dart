import 'package:flutter/material.dart';
import 'package:uts_mobileprogramming/screens/forgot_password.dart';
import 'package:uts_mobileprogramming/screens/login_screen.dart';
import 'package:uts_mobileprogramming/screens/dashboard_screen.dart';

// fungsi utama - titik masuk aplikasi berjalan
void main() {
  runApp(const MyApp());
}

// MyApp adalah widget utama yang membungkus seluruh aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Judul aplikasi
      title: 'UTS Mobile',
      // Menghilangkan tulisan "DEBUG" di pojok kanan atas
      debugShowCheckedModeBanner: false,
      // Warna tema utama aplikasi
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      // Halaman pertama yang muncul saat aplikasi dibuka
      initialRoute: '/',
      // Daftar semua halaman beserta alamat route-nya
      routes: {
        '/': (context) => const LoginScreen(),

        '/forgot_password': (context) => const ForgotPasswordScreen(),

        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}
