import 'package:flutter/material.dart';
import 'package:polladaapp/src/bloc/tarjetas_bloc.dart';
import 'package:polladaapp/src/models/pollada_model.dart';
import 'package:polladaapp/src/pages/pagados_page.dart';
import 'package:polladaapp/src/pages/pedidos_page.dart';
import 'package:polladaapp/src/pages/reporte_page.dart';

class HomePage extends StatefulWidget {

  
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  final estiloTexto = TextStyle( fontSize: 20.0);
  TabController _controladorTab;
  final tarjetaBloc = new TarjetasBloc();
  String nombre='';
  int numero = 0;

@override
  void initState() { 
    _controladorTab=new TabController(vsync: this,length: 3);
    super.initState();

  }

  @override
  void dispose() {
    _controladorTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PolliApp'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          labelPadding: EdgeInsets.only(bottom: 10.0),
          controller: _controladorTab,
          tabs: <Widget>[
            Text('Pedido',style: estiloTexto,),
            Text('Pagado',style: estiloTexto,),
            Text('Reporte',style: estiloTexto,)
          ],
        ), 
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>_formulario(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: TabBarView(
        controller: _controladorTab,
        children: <Widget>[
          PedidosPage(),
          PagadosPage(),
          ReportesPage()
        ],
      ),
    );
  }

  _formulario(BuildContext context){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Agregar Tarjeta'),
          content: Container(
            height: 300.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Numero de la tarjeta'),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: 'Numero de la Tarjeta',
                  ),
                  onChanged: (valor){
                    numero=int.parse(valor);
                  },
                ),
                SizedBox(height: 10.0,),
                Text('Nombre'),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: 'Nombre del comprador',
                  ),
                  onChanged: (valor){
                    nombre=valor;
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
              child: Text('Agregar'),
              onPressed:(){
                _mandarDato(numero,nombre);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }


  _mandarDato(int n,String nom) async
  {
    String nombre =nom;
    String estado ='Activo';
    int numero = n;
    int precio =12;
    if(nombre != null && estado != null && numero != null && precio !=null)
    {
        final pollada = PolladaModel(nombre: nombre,estado: estado,numero: numero,precio: precio);
        tarjetaBloc.agregarTarjeta(pollada);
    }
  }
}