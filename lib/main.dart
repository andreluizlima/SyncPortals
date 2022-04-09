import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    title: "SyncPortals 1.0",
  ));
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool selecionado = false;

  TextEditingController zCoord = TextEditingController();
  TextEditingController yCoord = TextEditingController();
  TextEditingController xCoord = TextEditingController();
  String _infoText = 'Preencha os dados';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _resetFields(){
    zCoord.text = "";
    yCoord.text = "";
    xCoord.text = "";

    setState(() {
      _infoText = 'Preencha os dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  calculate(){
    double x = double.parse(xCoord.text);
    double y = double.parse(yCoord.text);
    double z = double.parse(zCoord.text);

    String rX = "";
    String rY = "";
    String rZ = "";
    String whrR = "";

    if(selecionado){
      rX = (x/8).toString();
      rY = (y).toString();
      rZ = (z/8).toString();
      whrR = "Coordenadas no Nether: \n";
    }else{
      rX = (x*8).toString();
      rY = (y).toString();
      rZ = (z*8).toString();
      whrR = "Coordenadas no Overworld: \n";
    }

    setState(() {
      _infoText = whrR + 'X: '+ rX + '\nY: ' + rY + '\nZ: ' + rZ;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("SyncPortals", style: TextStyle(fontSize: 18),),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetFields();
              },
            ),
          ],
      ),
      backgroundColor: Colors.brown[800],
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(              
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                      color: selecionado ? Colors.green : Colors.blue,
                      onPressed: (){
                        setState(() {
                          if(!selecionado){
                            selecionado = !selecionado;
                          }
                        });
                      },
                      child: Text("Overworld", style: TextStyle(color: Colors.white, fontSize: 18),),
                    ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: FlatButton(                      
                      color: selecionado ? Colors.deepOrangeAccent : Colors.green,
                      onPressed: (){
                        setState(() {
                          if(selecionado){
                            selecionado = !selecionado;
                          }                          
                        });},
                      child: Text("Nether", style: TextStyle(color: Colors.white, fontSize: 18),),
                    ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Coordenada X",
                      labelStyle: TextStyle(color: Colors.white)),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.white, fontSize: 25),
                  controller: xCoord,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Preencha o X";
                    }
                  },
                ),                 
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Coordenada Y",
                      labelStyle: TextStyle(color: Colors.white)),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.white, fontSize: 25),
                  controller: yCoord,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Preencha o Y";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Coordenada Z",
                      labelStyle: TextStyle(color: Colors.white)),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.white, fontSize: 25),
                  controller: zCoord,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Preencha o Z";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 20),
                  child: Container(
                    height: 55,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          calculate();
                        }
                      },
                      child: Text(
                        "CALCULAR",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}