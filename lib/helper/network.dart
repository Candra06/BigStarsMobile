class EndPoint {
  static final String server = 'http://api.buildandservice.com/';
  static final String api = server + 'api/';
  // auth
  static final String login = api + 'login';
  // mapel
  static final String mapel = api + 'mapel/data';
  static final String mCreate = api + 'mapel/create';
  static final String mDelete = api + 'mapel/delete/';
  static final String mDetail = api + 'mapel/detail/';
  static final String mUpdate = api + 'mapel/update/';
  // guru
  static final String guru = api + 'guru/data/';
  static final String gCreate = api + 'guru/create';

  // wali
  static final wali = api + 'siswa/show-wali';

  // siswa
  static final siswa = api + 'siswa/list';
  static final sDelete = api + 'siswa/delete/';
}
