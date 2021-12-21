import 'dart:io';
import 'package:inspeccion_seguridad/models/questao.dart';
import 'package:inspeccion_seguridad/models/resposta.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:open_file/open_file.dart';

class Excel {
  Future<void> relatorioDiarioInspecoes(
    List<Resposta> respostas,
    List<String> veiculos,
    List<Questao> questoes,
  ) async {
    final Workbook workbook = Workbook(2);

    final Worksheet dados = workbook.worksheets[0];
    dados.name = 'Dados';
    Range range = dados.getRangeByIndex(1, 1);
    range.setText('Placas/Itens');
    int y = 2;
    for (String veiculo in veiculos) {
      Range range = dados.getRangeByIndex(y, 1);
      range.setText(veiculo);
      y++;
    }
    range.autoFit();
    int x = 2;
    for (Questao questao in questoes) {
      y = 2;
      Hyperlink hyperlink = dados.hyperlinks.add(
        dados.getRangeByIndex(1, x),
        HyperlinkType.workbook,
        'Itens!A${questao.id}',
      );
      hyperlink.textToDisplay = '${questao.id}';
      for (String veiculo in veiculos) {
        Resposta resposta = respostas.firstWhere(
          (e) => e.idQuestao == questao.id && e.empresa == veiculo,
          orElse: () => Resposta(
            data: '',
            idQuestao: 0,
            localidade: '',
            questao: '',
            empresa: '',
          ),
        );
        Range range = dados.getRangeByIndex(y, x);
        ConditionalFormats conditions = range.conditionalFormats;
        ConditionalFormat condition = conditions.addCondition();
        condition.formatType = ExcelCFType.specificText;
        condition.operator = ExcelComparisonOperator.equal;
        condition.text = 'NC';
        condition.backColor = '#ff0000';
        condition.fontColor = '#ffffff';
        if (resposta.idQuestao == 0) {
          range.setText('NA');
        } else {
          range.setText(resposta.opcao! == '1' ? 'X' : 'NC');
        }
        range.autoFit();
        y++;
      }
      x++;
    }

    final Worksheet itens = workbook.worksheets[1];
    itens.name = 'Itens';
    for (Questao questao in questoes) {
      Range range = itens.getRangeByIndex(questao.id, 1);
      range.setText('${questao.id} - ${questao.nome}');
      range.autoFit();
    }

    String dataRealizacao = respostas.first.data.replaceAll('/', '-');
    String name = 'relatorio_diario_de_inspecoes_$dataRealizacao.xlsx';
    Directory? directory = await DownloadsPathProvider.downloadsDirectory;
    String path = directory!.path;
    File file = File('$path/$name');
    await file.writeAsBytes(workbook.saveAsStream());
    workbook.dispose();
    OpenFile.open('$path/$name');
  }
}
