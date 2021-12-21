import 'package:inspeccion_seguridad/models/empresa.dart';
import 'package:inspeccion_seguridad/models/localidade.dart';
import 'package:inspeccion_seguridad/models/questao.dart';
import 'package:inspeccion_seguridad/models/resposta.dart';
import 'package:inspeccion_seguridad/models/veiculo.dart';
import 'package:inspeccion_seguridad/widgets/carregador.dart';
import 'package:inspeccion_seguridad/widgets/resposta_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspeccion_seguridad/models/tsl_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/services.Dart';

import '../../constants.dart';

class ChecklistScreen extends StatefulWidget {
  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _empresaTextFieldController = TextEditingController();
  final _localidadeTextFieldController = TextEditingController();
  late FocusNode _empresaFocusNode;
  late FocusNode _localidadeFocusNode;

  @override
  void initState() {
    super.initState();
    _empresaFocusNode = FocusNode();
    _localidadeFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final TSLData checklistData = TSLData();
    return Consumer<List<Questao>>(
      builder: (
        context,
        questaoList,
        child,
      ) {
        DateTime agora = DateTime.now();
        int dia = agora.day;
        int mes = agora.month;
        int ano = agora.year;
        String diaString;
        String mesString;
        dia >= 10
            ? diaString = dia.toString()
            : diaString = '0' + dia.toString();
        mes >= 10
            ? mesString = mes.toString()
            : mesString = '0' + mes.toString();
        String data = '$diaString/$mesString/$ano';
        return Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(
              right: 15.0,
              left: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      _localidadeTextFieldController.clear();
                      _empresaTextFieldController.clear();
                      _localidadeFocusNode.unfocus();
                      _empresaFocusNode.unfocus();
                      agora = DateTime.now();
                      dia = agora.day;
                      mes = agora.month;
                      ano = agora.year;
                      dia >= 10
                          ? diaString = dia.toString()
                          : diaString = '0' + dia.toString();
                      mes >= 10
                          ? mesString = mes.toString()
                          : mesString = '0' + mes.toString();
                      data = '$diaString/$mesString/$ano';
                    });
                  },
                  child: Text(
                    'Nuevo registro',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: paracelGreen,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 18.0, left: 10.0),
                  child: Text(
                    'Inspección del día: $data',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: paracelGreen,
                    ),
                  ),
                ),
                TypeAheadFormField<Localidade>(
                  autoFlipDirection: true,
                  hideSuggestionsOnKeyboardHide: true,
                  textFieldConfiguration: TextFieldConfiguration(
                    focusNode: _localidadeFocusNode,
                    controller: _localidadeTextFieldController,
                    enabled: _localidadeTextFieldController.text == '' ||
                        _empresaTextFieldController.text == '',
                    decoration: InputDecoration(
                      labelText: 'Ubicación',
                      focusColor: eiConsultoriaBlue,
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                  validator: (value) {
                    return value!.isEmpty ? '¡Rellena la ubicación!' : null;
                  },
                  suggestionsCallback: (pattern) {
                    return checklistData.getLocalidadesFiltrada(pattern);
                  },
                  itemBuilder: (context, item) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item.nome),
                    );
                  },
                  noItemsFoundBuilder: (context) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          '¡No hay artículos!',
                          style: TextStyle(
                            color: eiConsultoriaLightGreen,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (item) {
                    setState(() {
                      _localidadeTextFieldController.text = item.nome;
                    });
                  },
                ),
                TypeAheadFormField<Empresa>(
                  autoFlipDirection: true,
                  hideSuggestionsOnKeyboardHide: true,
                  textFieldConfiguration: TextFieldConfiguration(
                    focusNode: _empresaFocusNode,
                    enabled: _localidadeTextFieldController.text == '' ||
                        _empresaTextFieldController.text == '',
                    controller: _empresaTextFieldController,
                    decoration: InputDecoration(
                      labelText: 'Empresa',
                    ),
                    textCapitalization: TextCapitalization.characters,
                  ),
                  suggestionsCallback: (pattern) {
                    return checklistData.getEmpresasFiltradas(pattern);
                  },
                  itemBuilder: (context, item) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item.nome),
                    );
                  },
                  noItemsFoundBuilder: (context) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          '¡No hay artículos!',
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (item) {
                    if (_localidadeTextFieldController.text != '') {
                      showDialog(
                        context: context,
                        builder: (BuildContext bContext) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text('Selección de ubicación y empresa'),
                            content: Text(
                              '¿Está seguro de que quiere seleccionar el ubicación - ${_localidadeTextFieldController.text} - y la empresa ${item.nome}?',
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    color: paracelGreen,
                                  ),
                                ),
                                onPressed: () {
                                  _empresaTextFieldController.clear();
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Si',
                                  style: TextStyle(
                                    color: paracelGreen,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {
                                      _empresaTextFieldController.text =
                                          item.nome;
                                      checklistData.gerarRespostas(
                                        questaoList,
                                        data,
                                        _localidadeTextFieldController.text,
                                        item.nome,
                                      );
                                    }
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      _empresaFocusNode.unfocus();
                      _localidadeFocusNode.requestFocus();
                    }
                  },
                ),
                if (_localidadeTextFieldController.text != '' &&
                    _empresaTextFieldController.text != '')
                  Expanded(
                    child: StreamBuilder<List<Resposta>>(
                      stream: checklistData.getRespostas(
                          data: data,
                          empresa: _empresaTextFieldController.text,
                          localidade: _localidadeTextFieldController.text),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Carregador();
                        }
                        return RespostaList(
                          respostas: snapshot.data!,
                          formKey: _formKey,
                        );
                      },
                    ),
                  )
                else
                  Expanded(
                    child: Center(
                      child: Text(
                        'Seleccione una ubicación y una empresa',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
