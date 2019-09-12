import 'dart:convert';

class DataUser {
  String fcmToken;
  String jenisLogin;
  String idSekolah;
  String uid;
  String idJenis;
  String nama;
  String foto;
  String pathFoto;
  String pathFotoCompress;
  String jenisKelamin;
  String idKelas;
  String namaKelas;
  String namaWaliKelas;
  String guruBk;
  String bayar;
  String tglLahir;
  String umur;

  DataUser({
    this.fcmToken,
    this.jenisLogin,
    this.idSekolah,
    this.uid,
    this.idJenis,
    this.nama,
    this.foto,
    this.pathFoto,
    this.pathFotoCompress,
    this.jenisKelamin,
    this.idKelas,
    this.namaKelas,
    this.namaWaliKelas,
    this.guruBk,
    this.bayar,
    this.tglLahir,
    this.umur
  });

  factory DataUser.fromJson(Map<String, dynamic> map) {
    return DataUser(
      fcmToken: map == null ? "" : map["fcmtoken"],
      jenisLogin: map == null ? "" : map["jenis_login"],
      idSekolah: map == null ? "" : map["id_sekolah"],
      uid: map == null ? "" : map["uid"],
      idJenis: map == null ? "" : map["id_jenis"],
      nama: map == null ? "" : map["nama"],
      foto: map == null ? "" : map["foto"],
      pathFoto: map == null ? "" : map["path_foto"],
      pathFotoCompress: map == null ? "" : map["path_foto_compress"],
      jenisKelamin: map == null ? "" : map["jenis_kelamin"],
      idKelas: map == null ? "" : map["id_kelas"],
      namaKelas: map == null ? "" : map["nama_kelas"],
      namaWaliKelas: map == null ? "" : map["nama_walikelas"],
      guruBk: map == null ? "" : map["guru_bk"],
      bayar: map == null ? "" : map["bayar"],
      tglLahir: map == null ? "" : map["tanggal_lahir"],
      umur: map == null ? "" : map["umur"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fcmtoken": fcmToken,
      "jenis_login": jenisLogin,
      "id_sekolah": idSekolah,
      "uid": uid,
      "id_jenis": idJenis,
      "nama": nama,
      "foto": foto,
      "path_foto": pathFoto,
      "path_foto_compress": pathFotoCompress,
      "jenis_kelamin": jenisKelamin,
      "id_kelas": idKelas,
      "nama_kelas": namaKelas,
      "nama_walikelas": namaWaliKelas,
      "guru_bk": guruBk,
      "bayar": bayar,
      "tanggal_lahir": tglLahir,
      "umur": umur
    };
  }
  @override
  String toString() {
    return 'DataUser{fcmtoken:$fcmToken, jenis_login:$jenisLogin, id_sekola:$idSekolah, uid:$uid, id_jenis:$idJenis, nama:$nama, foto:$foto, path_foto:$pathFoto, path_foto_compress:$pathFotoCompress, jenis_kelamin:$jenisKelamin, id_kelas:$idKelas, nama_kelas:$namaKelas, nama_walikelas:$namaWaliKelas, guru_bk:$guruBk, bayar:$bayar, tanggal_lahir:$tglLahir, umur:$umur}';
  }
}


List<DataUser> dataUserFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<DataUser>.from(data.map((item) => DataUser.fromJson(item)));
}

setAsObject(String jsonData) {
  final data = json.decode(jsonData);
  return DataUser.fromJson(data);
}

String dataUserToJson(DataUser data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}