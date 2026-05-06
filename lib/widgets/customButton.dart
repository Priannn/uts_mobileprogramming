import 'package:flutter/material.dart';

// Widget tombol custom yang bisa dipakai di semua halaman
// Sudah include loading indicator otomatis
class CustomButton extends StatelessWidget {
  // Text yang ditampilkan di tombol
  final String label;

  // Fungsi yang dijalankan saat tombol ditekan
  final VoidCallback? onPressed;

  // Apakah sedang loading? (true = tampilkan loading indicator)
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // Jika sedang loading, tombol dinonaktifkan
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        // Tombol memenuhi lebar parent
        minimumSize: const Size(double.infinity, 0),
      ),
      child: isLoading
          // Tampilkan loading indicator jika sedang loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          // Tampilkan teks jika tidak sedang loading
          : Text(label),
    );
  }
}