import 'package:inspeccion_seguridad/models/resposta.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RespostaListTile extends StatelessWidget {
  final Resposta resposta;
  final int numeracao;
  final void Function(String? a)? onChangedRadioButton;
  final void Function()? onPressedButtonNC;

  RespostaListTile({
    required this.resposta,
    required this.numeracao,
    required this.onChangedRadioButton,
    this.onPressedButtonNC,
  });

  @override
  Widget build(BuildContext context) {
    bool opcao1OuNA = resposta.opcao! == '1' || resposta.opcao! == 'NA';
    return ListTile(
      title: Text(
        resposta.questao,
        style: TextStyle(
          color: opcao1OuNA ? paracelGreen : Colors.red,
          fontSize: 12.0,
        ),
      ),
      leading: Text(
        '$numeracao',
        style: TextStyle(color: paracelGreen),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Radio<String>(
              value: '1',
              groupValue: resposta.opcao,
              onChanged: onChangedRadioButton,
              activeColor: paracelGreen,
            ),
          ),
          Expanded(child: Text('1')),
          Expanded(
            child: Radio<String>(
              value: '2',
              groupValue: resposta.opcao,
              onChanged: onChangedRadioButton,
              activeColor: paracelGreen,
            ),
          ),
          Expanded(child: Text('2')),
          Expanded(
            child: Radio<String>(
              value: '3',
              groupValue: resposta.opcao,
              onChanged: onChangedRadioButton,
              activeColor: paracelGreen,
            ),
          ),
          Expanded(child: Text('3')),
          Expanded(
            child: Radio<String>(
              value: '4',
              groupValue: resposta.opcao,
              onChanged: onChangedRadioButton,
              activeColor: paracelGreen,
            ),
          ),
          Expanded(child: Text('4')),
          Expanded(
            child: Radio<String>(
              value: 'NA',
              groupValue: resposta.opcao,
              onChanged: onChangedRadioButton,
              activeColor: paracelGreen,
            ),
          ),
          Expanded(child: Text(opcao1OuNA ? 'NA' : '5')),
        ],
      ),
      trailing: resposta.opcao! != '1' && resposta.opcao! != 'NA'
          ? TextButton(
              onPressed: onPressedButtonNC,
              child: Text('DscInc'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: paracelGreen,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 8.0,
                ),
              ),
            )
          : null,
    );
  }
}
