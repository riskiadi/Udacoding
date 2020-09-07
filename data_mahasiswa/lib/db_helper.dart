import 'package:data_mahasiswa/models/mahasiswa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final DatabaseHelper _instanse = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instanse;

  final String tableName = 'mahasiswa';
  final String columnID = 'id';
  final String columnNim = 'nim';
  final String columnNama = 'nama';
  final String columnJnsKlmn = 'jnsKelamin';
  final String columnAlamat = 'alamat';
  final String columnTahun = 'tahun';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'mahasiswa.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    db.execute('CREATE TABLE $tableName($columnID INTEGER PRIMARY KEY, $columnNim TEXT, $columnNama TEXT, $columnJnsKlmn TEXT, $columnAlamat TEXT, $columnTahun INTEGER)');
  }

  //Create data mahasiswa
  Future<int> createMahasiswa(Mahasiswa mahasiswa) async{
    var dbClient = await db;
    var result = await dbClient.insert(tableName, mahasiswa.toMap());
    return result;
  }

  //Get all data mahasiswa
  Future<List> getAllMahasiswa() async{
    var dbClient = await db;
    var result = await dbClient.query(tableName, columns: [columnID, columnNim, columnNama, columnJnsKlmn, columnAlamat, columnTahun]);
    return result;
  }

  //Update data mahasiswa
  Future<int> updateMahasiswa(Mahasiswa mahasiswa) async{
    var dbClient = await db;
    return await dbClient.update(tableName, mahasiswa.toMap(), where: "$columnID=?", whereArgs: [mahasiswa.id]);
  }

  //Delete data mahasiswa
  Future<int> deleteMahasiswa(int id) async{
    var dbClient = await db;
    return await dbClient.delete(tableName, where: "$columnID=?", whereArgs: [id]);
  }

}
