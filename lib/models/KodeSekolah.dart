import 'dart:convert';

class KodeSekolah {
  String id;
  String kode;
  String namaInstitusi;
  String modelBisnis;
  String singleAppsAndroid;
  String tanggalBergabung;
  String modelBisnisBackup;
  String server;
  String logoFIle;
  String jenjang;
  String kota;
  String urlWs;
  String urlWs2;
  String urlFile;
  String urlBase;
  String deskripsi;
  String extraFitur;
  String tanpaFitur;
  String polaMenu;
  String misc;
  String updatedAt;

  KodeSekolah(
      {this.id,
      this.kode,
      this.namaInstitusi,
      this.modelBisnis,
      this.singleAppsAndroid,
      this.tanggalBergabung,
      this.modelBisnisBackup,
      this.server,
      this.logoFIle,
      this.jenjang,
      this.kota,
      this.urlWs,
      this.urlWs2,
      this.urlFile,
      this.urlBase,
      this.deskripsi,
      this.extraFitur,
      this.tanpaFitur,
      this.polaMenu,
      this.misc,
      this.updatedAt});

  factory KodeSekolah.fromJson(Map<String, dynamic> map) {
    return KodeSekolah(
        id: map == null ? "" : map["id"],
        kode: map == null ? "" : map["kode"],
        namaInstitusi: map == null ? "" : map["nama_institusi"],
        modelBisnis: map == null ? "" : map["model_bisnis"],
        singleAppsAndroid: map == null ? "" : map == null ? "" : map["single_apps_android"],
        tanggalBergabung: map == null ? "" : map["tanggal_bergabung"],
        modelBisnisBackup: map == null ? "" : map["modelbisnis_backup"],
        server: map == null ? "" : map["server"],
        logoFIle: map == null ? "" : map["logo_file"],
        jenjang: map == null ? "" : map["jenjang"],
        kota: map == null ? "" : map["kota"],
        urlWs: map == null ? "" : map["url_ws"],
        urlWs2: map == null ? "" : map["url_ws2"],
        urlFile: map == null ? "" : map["url_file"],
        urlBase: map == null ? "" : map["url_base"],
        deskripsi: map == null ? "" : map["deskripsi"],
        extraFitur: map == null ? "" : map["extra_fitur"],
        tanpaFitur: map == null ? "" : map["tanpa_fitur"],
        polaMenu: map == null ? "" : map["pola_menu"],
        misc: map == null ? "" : map["misc"],
        updatedAt: map == null ? "" : map["updated_at"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "kode": kode,
      "nama_institusi": namaInstitusi,
      "single_apps_android": singleAppsAndroid,
      "tanggal_bergabung": tanggalBergabung,
      "model_bisnis_backup": modelBisnisBackup,
      "server": server,
      "logo_file": logoFIle,
      "jenjang": jenjang,
      "kota": kota,
      "url_ws": urlWs,
      "url_ws2": urlWs2,
      "url_file": urlFile,
      "url_base": urlBase,
      "deskripsi": deskripsi,
      "extra_fitur": extraFitur,
      "tanpa_fitur": tanpaFitur,
      "pola_menu": polaMenu,
      "misc": misc,
      "updated_at": updatedAt
    };
  }

  @override
  String toString() {
    return 'KodeSekolah{id:$id, kode:$kode, nama_institusi:$namaInstitusi, model_bisnis:$modelBisnis, single_apps_android:$singleAppsAndroid, tanggal_bergabung:$tanggalBergabung, model_bisnis_backup:$modelBisnisBackup, server:$server, logo_file:$logoFIle, jenjang:$jenjang, kota:$kota, url_ws:$urlWs, url_ws2:$urlWs2, url_file:$urlFile, url_base:$urlBase, deskripsi:$deskripsi, extra_fitur:$extraFitur, tanpa_fitur:$tanpaFitur, pola_menu:$polaMenu, misc:$misc, updated_at:$updatedAt}';
  }
}

List<KodeSekolah> kodeSekolahFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<KodeSekolah>.from(data.map((item) => KodeSekolah.fromJson(item)));
}

setAsObject(String jsonData) {
  final data = json.decode(jsonData);
  return KodeSekolah.fromJson(data);
}

String kodeSekolahToJson(KodeSekolah data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
