import 'package:app_metricas/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Metrics.db');
    print(path);

    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Metrics(
          id INTEGER PRIMARY KEY,
          n1 INTEGER, 
          n2 INTEGER, 
          nn1 INTEGER, 
          nn2 INTEGER, 
          n INTEGER, 
          nn INTEGER,
          V REAL,
          D REAL, 
          L REAL, 
          E REAL, 
          T REAL, 
          B REAL,
          name TEXT)
      ''');
    });
  }

  Future<int?> newMetricRow(Arguments args) async {
    final n1 = args.n1, n2 = args.n2, N1 = args.nn1, N2 = args.nn2, n = args.n, N = args.nn;
    final V = args.V, D = args.D, L = args.L, E = args.E, T = args.T, B = args.B;
    final name = args.name;
    final db = await database;
    final res = await db?.rawInsert('''
      INSERT INTO Metrics(n1,n2,nn1,nn2,n,nn,V,D,L,E,T,B,name)
      VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)''', [n1, n2, N1, N2, n, N, V, D, L, E, T, B, name]);
    return res;
  }

  Future<List<Arguments>> getAllMetrics() async {
    final db = await database;
    final res = await db?.query('Metrics');
    return res!.map((a) => Arguments.fromJson(a)).toList();
  }

  Future<int> newMetric(Arguments args) async {
    final db = await database;
    final res = await db!.insert('Metrics', args.toJson());
    return res;
  }
}
