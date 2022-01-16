class EndPoint {
  static final String server = 'http://api.buildandservice.com/';
  static final String api = server + 'api/';
  // dashboard
  static final String dashboard = api + 'dashboard-admin';
  // auth
  static final String login = api + 'login';
  static final String logout = api + 'logout';

  // mapel
  static final String mapel = api + 'mapel/data';
  static final String mCreate = api + 'mapel/create';
  static final String mDelete = api + 'mapel/delete/';
  static final String mDetail = api + 'mapel/detail/';
  static final String mUpdate = api + 'mapel/update/';
  // guru
  static final String guru = api + 'guru/data/';
  static final String gCreate = api + 'guru/create';
  static final String gDelete = api + 'guru/delete/';
  static final String gUpdate = api + 'guru/update/';

  // wali
  static final wali = api + 'siswa/show-wali';

  // siswa
  static final siswa = api + 'siswa/list';
  static final sDelete = api + 'siswa/delete/';
  static final sCreate = api + 'siswa/create-wali';
  static final sUpdate = api + 'siswa/update/';
  static final wCreate = api + 'siswa/create-siswa';

  // finance
  static final finance = api + 'finance/index/';
  static final fee = api + 'finance/list-fee';
  static final spp = api + 'finance/list-spp';
  static final generateFee = api + 'finance/generate-fee';
  static final generateSpp = api + 'finance/generate-spp';

  // kelas
  static final kelas = api + 'kelas/list-all';
  static final addKelas = api + 'kelas/create';
  static final kehadiran = api + 'kelas/kehadiran-kelas/';
  static final addKehadiran = api + 'kelas/add-absen-admin/';
  static final kelasDetail = api + 'kelas/detail/';
  static final deleteJadwal = api + 'kelas/delete-jadwal/';
}
