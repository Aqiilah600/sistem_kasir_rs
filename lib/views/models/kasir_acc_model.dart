class KasirAccount {
  final String id;
  final String namaKasir;
  final String username;
  final String email;
  final String password;
  final String? photoUrl; // Optional: URL foto kasir

  KasirAccount({
    required this.id,
    required this.namaKasir,
    required this.username,
    required this.email,
    required this.password,
    this.photoUrl,
  });

  // Copy with untuk edit
  KasirAccount copyWith({
    String? id,
    String? namaKasir,
    String? username,
    String? email,
    String? password,
    String? photoUrl,
  }) {
    return KasirAccount(
      id: id ?? this.id,
      namaKasir: namaKasir ?? this.namaKasir,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}

// Dummy data - nanti dari API
List<KasirAccount> getDummyKasirAccounts() {
  return [
    KasirAccount(
      id: '1',
      namaKasir: 'Mutia Amalia',
      username: 'Kasir Mutia Amalia',
      email: 'mutiaamelia@kasir.com',
      password: 'MutiaCantikmup',
      photoUrl: 'assets/pfp_kasir_1.png',
    ),
    KasirAccount(
      id: '2',
      namaKasir: 'Melinda Ayu Ningsih',
      username: 'Kasir Ayu Ningsih',
      email: 'ayuningsih@kasir.com',
      password: 'MelindaAyu123',
      photoUrl: 'assets/pfp_kasir_2.png',
    ),
    KasirAccount(
      id: '3',
      namaKasir: 'Ni Wayan Anjani Drisana',
      username: 'Kasir Anjani Drisana',
      email: 'Anjani.Drisana@kasir.com',
      password: 'DrisanaAnjani456',
      photoUrl: 'assets/pfp_kasir_3.png',
    ),
  ];
}
