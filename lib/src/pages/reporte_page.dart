import 'package:flutter/material.dart';
import 'package:polladaapp/src/bloc/tarjetas_bloc.dart';
import 'package:polladaapp/src/models/pollada_model.dart';
//import 'package:charts_flutter/flutter.dart';
class ReportesPage extends StatefulWidget {
  @override
  _ReportesPageState createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {

  final tarjetasBloc=new TarjetasBloc();
  final estiloTitulo = TextStyle(fontSize: 20.0);
  final estiloNumero=TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    tarjetasBloc.obtenerTarjetas();
    return Column(
      children: <Widget>[
        SizedBox(height: 15.0,),
        StreamBuilder<List<PolladaModel>>(
          stream: tarjetasBloc.tarjetasStream ,
          builder: (BuildContext context, AsyncSnapshot<List<PolladaModel>> snapshot){
            if(!snapshot.hasData){
              return Container(
                child: Text('No hay Datos'),
              );
            }
            final tarjetas=snapshot.data;
            int pagadas=0;
            int saldoPagadas=0;
            int activas =0;
            int saldoActivas=0;
            for(int i =0;i<tarjetas.length;i++){
              if(tarjetas[i].estado == 'Cancelado')
              {
                pagadas++;
                saldoPagadas=saldoPagadas+tarjetas[i].precio;
              }
              else if (tarjetas[i].estado == 'Activo')
              {
                activas++;
                saldoActivas=saldoActivas+tarjetas[i].precio;
              }
            }
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _cuadro1('Tarjetas Totales', tarjetas.length, 400.0, 100.0)
                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _cuadro('Activas',activas,200.0,140.0),
                    _cuadro('Pagadas',pagadas,200.0,140.0)
                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _cuadro2('Monto Activos', saldoActivas, 400.0, 130.0),
                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _cuadro2('Monto Cancelado', saldoPagadas, 400.0, 130.0)
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _cuadro(String estado,int numero,double ancho,double alto){
    return Container(
      width: ancho,
      height: alto,
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text('Tarjetas '+estado,style: estiloTitulo,),
            Expanded(child: Container()),
            Text(numero.toString(),style:estiloNumero),
            SizedBox(height: 30.0)
          ],
        ),
      ),
    );
  }
  Widget _cuadro1(String nombre,int numero,double ancho,double alto){
    return Container(
      width: ancho,
      height: alto,
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(nombre,style: estiloTitulo,),
            Expanded(child: Container()),
            Text(numero.toString(),style:estiloNumero),
            SizedBox(height: 10.0)
          ],
        ),
      ),
    );
  }
  Widget _cuadro2(String nombre,int numero,double ancho,double alto){
    return Container(
      width: ancho,
      height: alto,
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 25.0),
            Text(nombre,style: estiloTitulo,),
            Expanded(child: Container()),
            Text('S/ '+numero.toString(),style:estiloNumero),
            SizedBox(height: 25.0)
          ],
        ),
      ),
    );
  }
}