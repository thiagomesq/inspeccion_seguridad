import 'package:inspeccion_seguridad/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspeccion_seguridad/screens/checklists/checklist.dart';
import 'package:inspeccion_seguridad/constants.dart';

class TSLTabBar extends StatefulWidget {
  @override
  _TSLTabBarState createState() => _TSLTabBarState();
}

class _TSLTabBarState extends State<TSLTabBar> {
  late int _telaAtual;
  late String titulo;

  void _mudarTelaAtual(int tela) {
    setState(() {
      _telaAtual = tela;
      switch (tela) {
        case 0:
          titulo = 'Paracel';
          break;
        case 1:
          titulo = 'Inspección de Seguridad';
          break;
      }
    });
    Navigator.of(context).pop();
  }

  Widget _pegarTela(int tela) {
    switch (tela) {
      case 0:
        return HomeScreen();
      case 1:
        return ChecklistScreen();
    }
    return Container();
  }

  @override
  void initState() {
    super.initState();
    _telaAtual = 0;
    titulo = 'Paracel';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: paracelGreen,
        centerTitle: true,
        title: Text(
          titulo,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: paracelGreen,
              ),
              child: Center(
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            TextButton(
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Pantalla Inicial'),
                selected: _telaAtual == 0,
                onTap: () {
                  _mudarTelaAtual(0);
                },
              ),
              onPressed: () {},
            ),
            Divider(
              color: paracelSilver,
            ),
            ListTile(
              leading: Text(
                'Listas de Verificación',
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
            TextButton(
              child: ListTile(
                leading: Icon(Icons.assignment),
                title: Text('Inspección de Seguridad'),
                selected: _telaAtual == 1,
                onTap: () {
                  _mudarTelaAtual(1);
                },
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: _pegarTela(_telaAtual),
    );
  }
}
