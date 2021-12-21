import 'dart:io';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:inspeccion_seguridad/models/questao.dart';
import 'package:inspeccion_seguridad/models/resposta.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Pdf {
  Future<PDFDocument> relatorioDiarioInspecoes(
    List<Resposta> respostas,
    List<String> veiculos,
    List<Questao> questoes,
  ) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          List<pw.Widget> cabecalho = List<pw.Widget>.empty(growable: true);
          cabecalho.add(
            pw.Center(
              child: pw.Text(
                'Item',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          );
          for (String veiculo in veiculos) {
            cabecalho.add(
              pw.Center(
                child: pw.Text(
                  veiculo,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
            );
          }
          List<pw.TableRow> linhas = [
            pw.TableRow(
              children: cabecalho,
            ),
          ];
          for (Questao questao in questoes) {
            bool checaNaoOk = respostas.any((e) =>
                e.idQuestao == questao.id &&
                e.opcao! != '1' &&
                e.opcao! != 'NA');
            List<pw.Widget> linha = List<pw.Widget>.empty(growable: true);
            linha.add(
              pw.Text(
                '${questao.id} - ${questao.nome}',
                style: pw.TextStyle(
                  fontSize: 8,
                  color: checaNaoOk
                      ? PdfColor.fromHex('f00')
                      : PdfColor.fromHex('000'),
                ),
              ),
            );
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
              if (resposta.idQuestao == 0) {
                linha.add(
                  pw.Center(
                    child: pw.Text(
                      'NA',
                      style: pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ),
                );
              } else {
                linha.add(
                  pw.Center(
                    child: pw.Text(
                      resposta.opcao!,
                      style: pw.TextStyle(
                        fontSize: 8,
                        color: resposta.opcao! != '1' && resposta.opcao! != 'NA'
                            ? PdfColor.fromHex('f00')
                            : PdfColor.fromHex('000'),
                      ),
                    ),
                  ),
                );
              }
            }
            linhas.add(
              pw.TableRow(
                children: linha,
              ),
            );
          }
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Center(
                child: pw.Text(
                  'Relatório Diário de Inspeções',
                  style: pw.TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              pw.SizedBox(height: 15.0),
              pw.Center(
                child: pw.Table(
                  children: linhas,
                  border: pw.TableBorder.all(),
                ),
              ),
            ],
          );
        },
      ),
    );
    String dataRealizacao = respostas.first.data.replaceAll('/', '-');
    String name = 'relatorio_diario_de_inspecoes_$dataRealizacao.pdf';
    Directory? directory = await DownloadsPathProvider.downloadsDirectory;
    String path = directory!.path;
    File file = File("$path/$name");
    file = await file.writeAsBytes(await pdf.save());

    return PDFDocument.fromFile(file);
  }
}
