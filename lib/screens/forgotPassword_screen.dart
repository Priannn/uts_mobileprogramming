import 'package:flutter/material.dart';
import '../utils/validator.dart'; // Import fungsi validasi eksternal (Clean Code)
import '../widgets/customButton.dart'; // Import widget tombol custom buatan sendiri

// Menggunakan StatefulWidget karena layar ini punya state yang bisa berubah 
// (contoh: status loading saat tombol diklik)
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // 'Remot kontrol' untuk form, wajib ada untuk trigger validasi massal
  final _formKey = GlobalKey<FormState>();
  
  // Controller untuk menangkap teks yang diketik user di kolom email
  final _emailController = TextEditingController();
  
  // State untuk melacak apakah aplikasi sedang memproses data (loading)
  bool _isLoading = false;

  // Method dispose() WAJIB ada kalau kita pakai Controller.
  // Fungsinya untuk menghapus controller dari memori saat halaman ditutup,
  // supaya aplikasi tidak ngelag atau kena "Memory Leak".
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Fungsi yang dipanggil saat tombol "Kirim Link Reset" ditekan
  void _handleSendReset() {
    // Cek apakah email sudah terisi dan formatnya benar 
    // (menjalankan validator di dalam TextFormField)
    if (_formKey.currentState!.validate()) {
      _doSendReset(); // Kalau valid (true), jalankan proses reset
    }
  }

  // Fungsi asynchronous (async) karena ada proses menunggu (simulasi loading)
  Future<void> _doSendReset() async {
    // 1. Ubah state jadi loading agar tombol memutar animasi spinner
    setState(() {
      _isLoading = true;
    });

    // 2. Simulasi proses nembak ke server/database (delay 2 detik)
    // Pas ujian, kamu bisa bilang: "Ini pura-puranya nunggu respon API, Pak."
    await Future.delayed(const Duration(seconds: 2));

    // 3. Matikan status loading setelah proses selesai
    setState(() {
      _isLoading = false;
    });

    // PENTING: Pengecekan 'mounted' wajib dilakukan setelah proses async (await).
    // Ini buat mastiin halamannya masih buka pas kita mau nampilin notifikasi.
    // Kalau user keburu mencet tombol 'back' pas lagi loading, aplikasi nggak akan crash.
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link reset telah dikirim ke email kamu!'),
          backgroundColor: Colors.green, // Hijau menandakan sukses
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar bawaan Flutter untuk bagian atas (header)
      appBar: AppBar(title: const Text('Lupa Password')),
      body: SafeArea(
        child: Center(
          // SingleChildScrollView agar layar bisa di-scroll saat keyboard HP muncul,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            // Form membungkus inputan untuk dikendalikan oleh _formKey
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.lock_reset, size: 80, color: Colors.deepOrange),
                  const SizedBox(height: 24),
                  const Text(
                    'Lupa Password?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tenang! Masukkan email kamu di bawah, dan kami akan bantu reset password akun eidipiGYM kamu.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Field Input Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress, // Munculkan keyboard tipe email (ada tombol @)
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Masukkan email kamu',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    // Memanggil fungsi validasi eksternal dari folder utils
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 24),

                  // Memanggil widget tombol buatan sendiri dari folder widgets
                  CustomButton(
                    label: 'Kirim Link Reset',
                    onPressed: _handleSendReset,
                    isLoading: _isLoading, // Mengirim state loading ke tombol
                  ),
                  const SizedBox(height: 16),

                  // Tombol untuk kembali ke halaman login
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context); // Fungsi pop() membuang layar saat ini dan kembali ke layar sebelumnya
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