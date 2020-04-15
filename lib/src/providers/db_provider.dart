import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polladaapp/src/models/pollada_model.dart';
export 'package:polladaapp/src/models/pollada_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
  static Database _database;
  static final DBProvider db=DBProvider._();

  DBProvider._();

  Future<Database> get database async{

    if(_database != null)
    {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async
  {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path,'PolliDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async
      {
          await db.execute(
            'CREATE TABLE Tarjeta ('
            'id INTEGER PRIMARY KEY,'
            'numero INTEGER,'
            'nombre TEXT,'
            'estado TEXT,'
            'precio INTEGER'
            ')'
          );
      }
    );
  }

  registrarTarjeta(PolladaModel polli) async{

    final db = await database;

    final res = await db.insert('Tarjeta', polli.toJson());

    return res;
  }


  Future<int> actualizarTarjeta(PolladaModel polli) async{

    final db = await database;
    final res = await db.update('Tarjeta', polli.toJson(),where: 'id = ?',whereArgs: [polli.id]);
    return res;
  }


  Future<List<PolladaModel>> obtenerTodasTarjetas() async{

    final db = await database;

    final res = await db.query('Tarjeta');

    List<PolladaModel> list = res.isNotEmpty ? res.map(
      (c)=>PolladaModel.fromJson(c)
    ).toList() : [];

    return list;
  }

  Future<List<PolladaModel>> obtenerTarjetasId(int numero) async{
    final db = await database;

    final res = await db.query('Tarjeta',where: 'numero = ?',whereArgs: [numero]);

    List<PolladaModel> list = res.isNotEmpty ? res.map(
      (c)=>PolladaModel.fromJson(c)
    ).toList() : [];

    return list;
  }

  Future<List<PolladaModel>> obtenerTarjetasTipo(String tipo) async{

    final db = await database;

    final res = await db.query('Tarjeta',where: 'estado = ?',whereArgs: [tipo]);

    List<PolladaModel> list = res.isNotEmpty ? res.map(
      (c)=>PolladaModel.fromJson(c)
    ).toList() : [];

    return list;
  }


  Future<int> borrarTarjetas(int id) async{
    final db = await database;
    final res = await db.delete('Tarjeta',where: 'id = ?',whereArgs: [id]);
    return res;
  }

  Future<int> borrarTodasTarjetas() async{
    final db = await database;
    final res = await db.delete('Tarjeta');
    return res;
  }
}