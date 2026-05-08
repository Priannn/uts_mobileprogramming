// Kumpulan fungsi validasi yang dipakai di seluruh aplikasi

// Validasi email
String? validateEmail(String? value) {
  // Cek apakah field kosong
  if (value == null || value.isEmpty) {
    return 'Email tidak boleh kosong';
  }
  // Cek format email menggunakan regex
  if (!RegExp(r'^[\w]+@[\w]+\.+[\w]+').hasMatch(value)) {
    return 'Format email tidak valid';
  }
  return null; // null berarti validasi lolos
}

// Validasi password
String? validatePassword(String? value) {
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
}
