import 'dart:async';

import 'package:polladaapp/src/models/pollada_model.dart';

class Validacion{
  final validarDeuda = StreamTransformer<List<PolladaModel>,List<PolladaModel>>.fromHandlers(
    handleData: (polladas,sink){
      final tarjetasDeuda = polladas.where((s)=>s.estado == 'Activo').toList();
      sink.add(tarjetasDeuda);
    }
  );
  final validarPagada = StreamTransformer<List<PolladaModel>,List<PolladaModel>>.fromHandlers(
    handleData: (polladas,sink){
      final tarjetasPagada = polladas.where((s)=>s.estado == 'Cancelado').toList();
      sink.add(tarjetasPagada);
    }
  );
  final validarTarjetas = StreamTransformer<List<PolladaModel>,List<PolladaModel>>.fromHandlers(
    handleData: (polladas,sink){
      final tarjetasPagada = polladas.toList();
      sink.add(tarjetasPagada);
    }
  );
}