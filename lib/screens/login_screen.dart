import 'package:flutter/material.dart';

// LoginScreen adalah halaman login
// Pakai StatefulWidget karena ada state yang berubah (loading, error, show/hide password)
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

  // State: pesan error jika login gagal
  String _errorMessage = '';

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
      // Kalau lolos, jalankan proses login
      _doLogin();
    }
  }

  // Fungsi proses login (async karena ada simulasi delay jaringan)
  Future<void> _doLogin() async {
    // Mulai loading, hapus pesan error lama
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // Simulasi delay jaringan 2 detik
    await Future.delayed(const Duration(seconds: 2));

    // Ambil email dan password yang diketik user
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Cek apakah email dan password sesuai credential yang di-hardcode
    if (email == 'admin@test.com' && password == 'Admin123') {
      // Login sukses — pindah ke halaman Dashboard
      // mounted: pastikan widget masih ada sebelum navigasi
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } else {
      // Login gagal — tampilkan pesan error
      setState(() {
        _errorMessage = 'Email atau password salah!';
      });
    }

    // Selesai loading
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold adalah kerangka dasar setiap halaman Flutter
    return Scaffold(
      body: SafeArea(
        // SafeArea supaya konten tidak tertutup notch atau status bar
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

                  // Judul halaman
                  const Text(
                    'Selamat Datang!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8), // Jarak vertikal

                  const Text(
                    'Silakan login untuk melanjutkan',
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
                    // Validator dijalankan saat form.validate() dipanggil
                    validator: (value) {
                      // Cek apakah field kosong
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      // Cek apakah format email valid menggunakan regex
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Format email tidak valid';
                      }
                      return null; // null berarti validasi lolos
                    },
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
                    validator: (value) {
                      // Cek apakah field kosong
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      // Cek panjang minimal 8 karakter
                      if (value.length < 8) {
                        return 'Password minimal 8 karakter';
                      }
                      // Cek apakah mengandung huruf
                      if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                        return 'Password harus mengandung huruf';
                      }
                      // Cek apakah mengandung angka
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'Password harus mengandung angka';
                      }
                      return null; // null berarti validasi lolos
                    },
                  ),

                  const SizedBox(height: 8),

                  // Tampilkan pesan error jika login gagal
                  // Hanya muncul jika _errorMessage tidak kosong
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Tombol Login
                  ElevatedButton(
                    // Jika sedang loading, tombol dinonaktifkan (onPressed: null)
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        // Tampilkan loading indicator jika sedang loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        // Tampilkan teks jika tidak sedang loading
                        : const Text('Login'),
                  ),

                  const SizedBox(height: 16),

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
    );
  }
}