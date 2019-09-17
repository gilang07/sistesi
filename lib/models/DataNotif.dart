import 'dart:convert';

class DataNotif {
  String idNotif;
  String idPenerima;
  String jenisPenerima;
  String jenisPengirim;

  DataNotif({
    this.idNotif,
    this.idPenerima,
    this.jenisPenerima,
    this.jenisPengirim
  });

  DataNotif.fromMap(Map map) :
    this.idNotif= map['idnotif'],
    this.idPenerima= map['id_penerima'],
    this.jenisPenerima= map['jenis_penerima'],
    this.jenisPengirim= map['jenis'];

  Map toMap() {
    return {
      'idnotif': this.idNotif,
      'id_penerima': this.idPenerima,
      'jenis_penerima': this.jenisPenerima,
      'jenis': this.jenisPengirim
    };
  }
}

// List<DataNotif> dataNotifFromJson(String jsonData) {
//   final data = json.decode(jsonData);
//   return List<DataNotif>.from(data.map((item) => DataNotif.fromJson(item)));
// }

// String dataNotifToJson(DataNotif data) {
//   final jsonData = data.toJson();
//   return json.encode(jsonData);
// }