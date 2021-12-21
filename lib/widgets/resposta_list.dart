import 'package:inspeccion_seguridad/models/tsl_data.dart';
import 'package:inspeccion_seguridad/models/resposta.dart';
import 'package:inspeccion_seguridad/screens/checklists/inserir_dsc_nc.dart';
import 'package:inspeccion_seguridad/widgets/resposta_list_tile.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RespostaList extends StatefulWidget {
  final List<Resposta>? respostas;
  final GlobalKey<FormState>? formKey;

  RespostaList({this.respostas, this.formKey});

  @override
  State<RespostaList> createState() => _RespostaListState();
}

class _RespostaListState extends State<RespostaList> {
  @override
  Widget build(BuildContext context) {
    final TSLData checklistData = TSLData();
    return ListView.builder(
      itemBuilder: (context, index) {
        Resposta resposta = widget.respostas![index];
        return RespostaListTile(
          resposta: resposta,
          numeracao: resposta.idQuestao,
          onChangedRadioButton: (value) {
            resposta.changeOpcao(value!);
            checklistData.updateResposta(resposta);
          },
          onPressedButtonNC: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: InserirDscNC(resposta),
                ),
              ),
            );
          },
        );
      },
      itemCount: widget.respostas!.length,
    );
  }
}
