import 'package:inspeccion_seguridad/models/empresa.dart';
import 'package:inspeccion_seguridad/models/localidade.dart';
import 'package:inspeccion_seguridad/models/questao.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inspeccion_seguridad/screens/tsl_tab_bar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:inspeccion_seguridad/models/tsl_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TSLData checklistData = TSLData();
    return MultiProvider(
      providers: [
        StreamProvider.value(
          value: checklistData.getEmpresas(),
          initialData: List<Empresa>.empty(growable: true),
        ),
        StreamProvider.value(
          value: checklistData.getLocalidades(),
          initialData: List<Localidade>.empty(growable: true),
        ),
        StreamProvider.value(
          value: checklistData.getQuestoes(),
          initialData: List<Questao>.empty(growable: true),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [const Locale('pt', 'BR'), const Locale('es')],
        home: TSLTabBar(),
      ),
    );
  }
}
