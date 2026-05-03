import 'package:flutter/material.dart';

// ForgotPassword adalah halaman lupa password
// Pakai StatefulWidget karena ada state yang berubah (loading)
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // Kunci unik untuk Form — dipakai saat validasi ditekan
  final _formKey = GlobalKey<FormState>();

  // Controller untuk mengambil teks yang diketik user di field email
  final _emailController = TextEditingController();

  // State: apakah sedang loading?
  bool _isLoading = false;

  // Wajib dibersihkan saat halaman ditutup supaya tidak bocor memori
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Fungsi yang dijalankan saat tombol "Kirim Link Reset" ditekan
  void _handleSendReset() {
    // Cek apakah semua validasi form sudah lolos
    if (_formKey.currentState!.validate()) {
      _doSendReset();
    }
  }

  // Fungsi proses kirim link reset
  void _doSendReset()  {
    // Mulai loading
    setState(() {
      _isLoading = true;
    });

   

    // Selesai loading
    setState(() {
      _isLoading = false;
    });

    // Tampilkan Snackbar sebagai feedback ke user
    // mounted: pastikan widget masih ada sebelum tampilkan snackbar
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link reset telah dikirim ke email kamu!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan tombol back otomatis
      appBar: AppBar(title: const Text('Lupa Password')),
      body: SafeArea(
        // SafeArea supaya konten tidak tertutup notch atau status bar
        child: Center(
          child: SingleChildScrollView(
            // SingleChildScrollView supaya bisa scroll jika keyboard muncul
            padding: const EdgeInsets.all(24),
            child: Form(
              // Form membungkus semua field input
              key: _formKey,
              child: Column(
                // Column menyusun widget secara vertikal
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Icon di atas
                  const Icon(Icons.lock_reset, size: 80, color: Colors.blue),

                  const SizedBox(height: 24), // Jarak vertikal
                  // Judul halaman
                  const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8), // Jarak vertikal
                  // Deskripsi singkat
                  const Text(
                    'Masukkan email kamu, kami akan kirimkan link untuk reset password',
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
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Format email tidak valid';
                      }
                      return null; // null berarti validasi lolos
                    },
                  ),

                  const SizedBox(height: 24), // Jarak vertikal
                  // Tombol Kirim Link Reset
                  ElevatedButton(
                    // Jika sedang loading, tombol dinonaktifkan (onPressed: null)
                    onPressed: _isLoading ? null : _handleSendReset,
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
                        : const Text('Kirim Link Reset'),
                  ),

                  const SizedBox(height: 16), // Jarak vertikal
                  // Tombol Kembali ke Login
                  OutlinedButton(
                    onPressed: () {
                      // Navigator.pop = kembali ke halaman sebelumnya (Login)
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Kembali ke Login'),
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
