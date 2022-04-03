class EndPoint {
  static final String server = 'https://v2.bigstartsjember.my.id/';
  // static final String server = 'https://bigstars.waserdajaya.store/';
  static final String api = server + 'api/';
  // dashboard
  static final String dashboard = api + 'dashboard-admin';
  static final String dashboardGuru = api + 'dashboard-guru';
  static final String dashboardWali = api + 'dashboard-wali';
  // auth
  static final String login = api + 'login';
  static final String logout = api + 'logout';
  static final String forgotPassword = api + 'lupa-password';
  static final String resetPassword = api + 'reset-password';
  static final String editProfilAdm = api + 'update-profil-admin';
  static final String editProfilGuru = api + 'update-profil-guru';
  static final String editProfilWali = api + 'update-profil-wali';
  static final String editFoto = api + 'update-photo';
  static final String notifikasi = api + 'notfikasi/list';
  static final String readNotif = api + 'notfikasi/read/';

  // mapel
  static final String mapel = api + 'mapel/data';
  static final String mCreate = api + 'mapel/create';
  static final String mDelete = api + 'mapel/delete/';
  static final String mDetail = api + 'mapel/detail/';
  static final String mUpdate = api + 'mapel/update/';
  // guru
  static final String guru = api + 'guru/data';
  static final String gCreate = api + 'guru/create';
  static final String gDelete = api + 'guru/delete/';
  static final String gUpdate = api + 'guru/update/';

  // wali
  static final wali = api + 'siswa/show-wali';
  static final wUpadate = api + 'siswa/update-wali/';
  static final wCreate = api + 'siswa/create-suswa-byWali';
  static final wDetail = api + 'siswa/detail-wali/';
  static final wDelete = api + 'siswa/delete-wali/';

  // siswa
  static final siswa = api + 'siswa/list';
  static final sDelete = api + 'siswa/delete/';
  static final sCreate = api + 'siswa/create-wali';
  static final sUpdate = api + 'siswa/update/';
  static final listSiswaByWali = api + 'siswa/list-by-wali/';
  static final createByWali = api + 'siswa/create-suswa-byWali';

  // finance
  static final finance = api + 'finance/index/';
  static final fee = api + 'finance/list-fee';
  static final spp = api + 'finance/list-spp';
  static final report = api + 'finance/report';
  static final generateFee = api + 'finance/generate-fee';
  static final generateSpp = api + 'finance/generate-spp';
  static final konfirmasiFee = api + 'finance/confirm-fee/';
  static final konfirmasiSPP = api + 'finance/confirm-spp/';
  static final detailSpp = api + 'finance/detail-spp/';
  static final detailFee = api + 'finance/detail-fee/';
  // kelas
  static final kelas = api + 'kelas/list-all';
  static final addKelas = api + 'kelas/create';
  static final kehadiran = api + 'kelas/kehadiran-kelas/';
  static final addKehadiran = api + 'kelas/add-absen-admin/';
  static final addSharing = api + 'kelas/sharing/';
  static final kelasDetail = api + 'kelas/detail/';
  static final addJadwal = api + 'kelas/add-jadwal/';
  static final deleteJadwal = api + 'kelas/delete-jadwal/';
  static final deleteKelas = api + 'kelas/delete/';
  static final updateStatus = api + 'kelas/updateStatus/';
  static final absensi = api + 'kelas/absensi/';
  static final filterKelas = api + 'kelas/filter-kelas/';
  static final addKehadiranGuru = api + 'kelas/add-absen-guru/';
  static final updateKehadiranGuru = api + 'kelas/updateKehadiran/';
  static final updateKelas = api + 'kelas/updateKelas/';
  static final deleteKehadiran = api + 'kelas/deleteKehadiran/';

  //rules
  static final listRules = api + 'rules/list';
  static final updateRules = api + 'rules/update/';
  static final detailRules = api + 'rules/detail';
}
