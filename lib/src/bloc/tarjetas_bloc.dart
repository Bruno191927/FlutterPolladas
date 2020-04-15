import 'dart:async';

import 'package:polladaapp/src/bloc/validaciones.dart';
import 'package:polladaapp/src/providers/db_provider.dart';

class TarjetasBloc with Validacion{

    static final TarjetasBloc _singleton = new TarjetasBloc._internal();

    //el factory retorna algo asi q retorna el singleton q esta arriba y eso activa el internal
    factory TarjetasBloc(){
      return _singleton;
    }
    TarjetasBloc._internal(){
      //traere los datos de la bd
      obtenerTarjetas();
    }
    
    //para decirle q se escuchara en multiples canales
    final _tarjetasController = StreamController<List<PolladaModel>>.broadcast();

    //hago el stream
    Stream<List<PolladaModel>> get tarjetasStream => _tarjetasController.stream.transform(validarTarjetas);
    Stream<List<PolladaModel>> get tarjetasStreamActivas => _tarjetasController.stream.transform(validarDeuda);
    Stream<List<PolladaModel>> get tarjetasStreamPagadas => _tarjetasController.stream.transform(validarPagada);
    
    dispose(){
      _tarjetasController?.close();
    }

    obtenerTarjetas() async{
      _tarjetasController.sink.add(await DBProvider.db.obtenerTodasTarjetas());
    }

    borrarTarjetas(int id) async{
      await DBProvider.db.borrarTarjetas(id);//borra
      obtenerTarjetas();//vuelve a mostrar los datos que quedaron
    }

    borrarTodos() async{
      await DBProvider.db.borrarTodasTarjetas();
      obtenerTarjetas();
    }

    agregarTarjeta(PolladaModel polli) async{
      await DBProvider.db.registrarTarjeta(polli);
      obtenerTarjetas();
    }

    actualizarTarjeta(PolladaModel polli) async{
      await DBProvider.db.actualizarTarjeta(polli);
      obtenerTarjetas();
    }
}