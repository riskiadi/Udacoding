class Mahasiswa{
  int _id;
  String _nim;
  String _nama;
  String _jnsKelamin;
  String _alamat;
  int _tahun;


  Mahasiswa(this._nim, this._nama, this._jnsKelamin, this._alamat, this._tahun);

  //SETTER deengan memasukan map yang akan di distribusikan setiap variable sesuai key
  Mahasiswa.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._nim = map['nim'];
    this._nama = map['nama'];
    this._jnsKelamin = map['jnsKelamin'];
    this._alamat = map['alamat'];
    this._tahun = map['tahun'];
  }

  // GETTER dengan cara mengembalikan objek map
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['nim'] = _nim;
    map['nama'] = _nama;
    map['jnsKelamin'] = _jnsKelamin;
    map['alamat'] = _alamat;
    map['tahun'] = _tahun;
    return map;
  }

  //GETTER dengan cara mengambil nilai pada variable=
  int get tahun => _tahun;
  String get alamat => _alamat;
  String get jnsKelamin => _jnsKelamin;
  String get nama => _nama;
  String get nim => _nim;
  int get id => _id;

}