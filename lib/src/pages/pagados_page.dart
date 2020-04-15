import 'package:flutter/material.dart';
import 'package:polladaapp/src/bloc/tarjetas_bloc.dart';
import 'package:polladaapp/src/models/pollada_model.dart';

class PagadosPage extends StatefulWidget {
  PagadosPage({Key key}) : super(key: key);

  _PagadosPageState createState() => _PagadosPageState();
}

class _PagadosPageState extends State<PagadosPage> {

  final textEstilo=TextStyle(fontSize: 25.0);
  final subEstilo=TextStyle(fontSize: 20.0);

  final tarjetasBloc=new TarjetasBloc();
  @override
  Widget build(BuildContext context) {
    tarjetasBloc.obtenerTarjetas();
    return StreamBuilder<List<PolladaModel>>(
      stream: tarjetasBloc.tarjetasStreamPagadas,
      builder: (BuildContext context, AsyncSnapshot<List<PolladaModel>> snapshot) {
        if(!snapshot.hasData)
        {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        
        final polli = snapshot.data;

        if(polli.length == 0)
        {
          return Center(
            child: Text('No se encontro tarjetas'),
          );
        }

        return ListView.builder(
          itemCount: polli.length,
          itemBuilder: (context,i)=>Dismissible(
            onDismissed: (direction){
              DismissDirection d = direction;
              
              if(d.toString() == 'DismissDirection.startToEnd'){
                tarjetasBloc.borrarTarjetas(polli[i].id);
              }
              else{
                polli[i].estado='Activo';
                
                tarjetasBloc.actualizarTarjeta(polli[i]);
              }
            },
            background: Container(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                child: Icon(Icons.cancel,size: 45.0,),
                color: Colors.redAccent,
              ),
            ),
            secondaryBackground: Container(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                color: Colors.orangeAccent,
                child: Icon(Icons.warning,size: 45.0,),
              ),
            ),
            key: UniqueKey(),
            child: Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.mode_edit),
                  onPressed: (){
                    _formulario(context, polli[i]);
                  },
                ),
                title: Text('N° '+polli[i].numero.toString(),style: textEstilo,),
                subtitle: Text(polli[i].nombre,style: subEstilo,),
                trailing: Icon(Icons.check,color: Colors.greenAccent,)
              )
            ),
          )
        );
      },
    );
    
  }

  _formulario(BuildContext context,PolladaModel polli){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Actualizar Tarjeta'),
          content: Container(
            height: 300.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Numero de la tarjeta'),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: '${polli.numero}',
                    labelText: 'Numero de la Tarjeta',
                  ),
                  onChanged: (valor){
                    polli.numero=int.parse(valor);
                  },
                ),
                SizedBox(height: 10.0,),
                Text('Nombre'),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: '${polli.nombre}',
                    labelText: 'Nombre del comprador',
                  ),
                  onChanged: (valor){
                    polli.nombre=valor;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed:()=>Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Actualizar'),
              onPressed:(){
                tarjetasBloc.actualizarTarjeta(polli);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
}

