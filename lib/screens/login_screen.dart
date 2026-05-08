import 'package:flutter/material.dart';
import 'package:uts_mobileprogramming/models/user_models.dart';
import '../utils/validator.dart'; // Import fungsi validasi
import '../widgets/customButton.dart'; // Import widget tombol custom

// LoginScreen adalah halaman login
// Pakai StatefulWidget karena ada state yang berubah (loading, show/hide password)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Kunci unik untuk Form — dipakai saat validasi ditekan
  final _formKey = GlobalKey<FormState>();

  // Controller untuk mengambil teks yang diketik user di field email
  final _emailController = TextEditingController();

  // Controller untuk mengambil teks yang diketik user di field password
  final _passwordController = TextEditingController();

  // State: apakah sedang loading? (true = tampilkan loading indicator)
  bool _isLoading = false;

  // State: apakah password ditampilkan atau disembunyikan?
  bool _isPasswordVisible = false;

  // Wajib dibersihkan saat halaman ditutup supaya tidak bocor memori
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi yang dijalankan saat tombol Login ditekan
  void _handleLogin() {
    // Cek apakah semua validasi form sudah lolos
    if (_formKey.currentState!.validate()) {
      _doLogin();
    }
  }

  // Fungsi proses login
  void _doLogin() {
    // Mulai loading
    setState(() {
      _isLoading = true;
    });

    // Ambil email dan password yang diketik user
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Cek apakah credential sesuai yang di-hardcode
    if (email == 'adprian@test.com' && password == 'Admin123') {
      // Login sukses — pindah ke halaman Dashboard
      // mounted: pastikan widget masih ada sebelum navigasi
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          '/dashboard',
          arguments: UserModel(name: 'Admin eidipiGYM', email: email),
        );
      }
    } else {
      // Login gagal — tampilkan Snackbar merah
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email atau password salah!'),
            // Warna merah menandakan error
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }

    // Selesai loading
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // Stack menumpuk widget, yang pertama di bawah, yang terakhir di atas
        children: [
          // Layer 1 (paling bawah) — dekorasi lingkaran oranye di pojok atas kanan
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                // Lingkaran dekoratif dengan warna oranye transparan
                color: Colors.orange.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Layer 2 — dekorasi lingkaran oranye di pojok bawah kiri
          Positioned(
            bottom: -60,
            left: -60,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                // Lingkaran dekoratif lebih besar di bawah
                color: Colors.orange.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Layer 3 (paling atas) — konten form login
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                // SingleChildScrollView supaya bisa scroll jika keyboard muncul
                padding: const EdgeInsets.all(24),
                child: Form(
                  // Form membungkus semua field input
                  // key dipakai untuk trigger validasi
                  key: _formKey,
                  child: Column(
                    // Column menyusun widget secara vertikal
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Icon gym di atas form
                      const Icon(
                        Icons.fitness_center, // Icon barbel
                        size: 80,
                        color: Colors.orange,
                      ),

                      const SizedBox(height: 16), // Jarak vertikal
                      // Judul halaman
                      const Text(
                        '💪 Selamat Datang di eidipiGYM!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8), // Jarak vertikal
                      // Subjudul halaman
                      const Text(
                        'Login untuk mulai latihan kamu hari ini',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 32), // Jarak vertikal
                      // Field Email
                      TextFormField(
                        controller: _emailController,
                        // Tipe keyboard — munculkan keyboard email (ada tombol @)
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Masukkan email kamu',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                        // Pakai fungsi validasi dari validators.dart
                        validator: validateEmail,
                      ),

                      const SizedBox(height: 16), // Jarak vertikal
                      // Field Password
                      TextFormField(
                        controller: _passwordController,
                        // obscureText menyembunyikan teks password
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Masukkan password kamu',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: const OutlineInputBorder(),
                          // Tombol show/hide password di sebelah kanan field
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              // Toggle state show/hide password
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        // Pakai fungsi validasi dari validators.dart
                        validator: validatePassword,
                      ),

                      const SizedBox(height: 24), // Jarak vertikal
                      // Tombol Login — pakai CustomButton dari widgets/
                      CustomButton(
                        label: 'Login',
                        onPressed: _handleLogin,
                        isLoading: _isLoading,
                      ),

                      const SizedBox(height: 16), // Jarak vertikal
                      // Tombol Lupa Password
                      TextButton(
                        onPressed: () {
                          // Navigasi ke halaman Lupa Password
                          Navigator.pushNamed(context, '/forgot_password');
                        },
                        child: const Text('Lupa Password?'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
