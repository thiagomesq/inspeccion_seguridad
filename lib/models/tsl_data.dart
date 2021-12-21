import 'dart:async';
import 'package:inspeccion_seguridad/models/empresa.dart';
import 'package:inspeccion_seguridad/models/localidade.dart';
import 'package:inspeccion_seguridad/models/questao.dart';
import 'package:inspeccion_seguridad/models/resposta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TSLData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Empresa>> getEmpresas() {
    return _firestore.collection('empresas').orderBy('nome').snapshots().map(
        (event) => event.docs.map((e) => Empresa.fromMap(e.data())).toList());
  }

  FutureOr<Iterable<Empresa>> getEmpresasFiltradas(String nome) {
    return _firestore.collection('empresas').orderBy('nome').get().then(
          (value) => value.docs
              .map((e) => Empresa.fromMap(e.data()))
              .toList()
              .where(
                (element) =>
                    element.nome.toLowerCase().startsWith(nome.toLowerCase()),
              )
              .toList(),
        );
  }

  Stream<List<Localidade>> getLocalidades() {
    return _firestore.collection('localidades').orderBy('nome').snapshots().map(
          (event) =>
              event.docs.map((e) => Localidade.fromMap(e.data())).toList(),
        );
  }

  FutureOr<Iterable<Localidade>> getLocalidadesFiltrada(String nome) {
    return _firestore.collection('localidades').orderBy('nome').get().then(
          (value) => value.docs
              .map((e) => Localidade.fromMap(e.data()))
              .toList()
              .where(
                (element) =>
                    element.nome.toLowerCase().startsWith(nome.toLowerCase()),
              )
              .toList(),
        );
  }

  Stream<List<Questao>> getQuestoes() {
    return _firestore
        .collection('questoes')
        .orderBy('id')
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return Questao.fromMap(e.data());
      }).toList();
    });
  }

  Stream<List<Resposta>> getRespostas({
    required String data,
    required String empresa,
    required String localidade,
  }) {
    return _firestore
        .collection('respostas')
        .where('data', isEqualTo: data)
        .where('empresa', isEqualTo: empresa)
        .where('localidade', isEqualTo: localidade)
        .orderBy('idQuestao')
        .snapshots()
        .asBroadcastStream(
            onListen: (subscription) => subscription.onData((event) {
                  event.docs.map((e) => Resposta.fromMap(e.data())).toList();
                }))
        .map((event) =>
            event.docs.map((e) => Resposta.fromMap(e.data())).toList());
  }

  Stream<List<Resposta>> getRespostasPorData({required String data}) {
    return _firestore
        .collection('respostas')
        .where('data', isEqualTo: data)
        .orderBy('veiculo')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Resposta.fromMap(e.data())).toList());
  }

  void gerarRespostas(
    List<Questao> questaoValidaList,
    String data,
    String localidade,
    String empresa,
  ) {
    questaoValidaList.forEach((e) {
      var addRespostaData = Map<String, dynamic>();
      addRespostaData['idQuestao'] = e.id;
      addRespostaData['questao'] = e.nome;
      addRespostaData['empresa'] = empresa;
      addRespostaData['data'] = data;
      addRespostaData['localidade'] = localidade;
      addRespostaData['opcao'] = '1';
      addRespostaData['dscNC'] = '';
      addRespostaData['usuario'] = 'Paracel';
      _firestore
          .collection('respostas')
          .where('idQuestao', isEqualTo: e.id)
          .where('data', isEqualTo: data)
          .where('empresa', isEqualTo: empresa)
          .where('localidade', isEqualTo: localidade)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          _firestore.collection('respostas').doc().set(addRespostaData);
        }
      });
    });
  }

  void updateResposta(Resposta resposta) {
    _firestore
        .collection('respostas')
        .where('idQuestao', isEqualTo: resposta.idQuestao)
        .where('data', isEqualTo: resposta.data)
        .where('empresa', isEqualTo: resposta.empresa)
        .where('localidade', isEqualTo: resposta.localidade)
        .get()
        .then((value) {
      value.docs.forEach((e) {
        var addRespostaData = Map<String, dynamic>();
        addRespostaData['idQuestao'] = resposta.idQuestao;
        addRespostaData['questao'] = resposta.questao;
        addRespostaData['empresa'] = resposta.empresa;
        addRespostaData['data'] = resposta.data;
        addRespostaData['localidade'] = resposta.localidade;
        addRespostaData['opcao'] = resposta.opcao;
        addRespostaData['dscNC'] = resposta.dscNC;
        addRespostaData['usuario'] = 'Paracel';
        e.reference.set(addRespostaData);
      });
    });
  }

  void upadateDscNC(String dscNCOld, String dscNCNew) {
    _firestore
        .collection('respostas')
        .where('dscNC', isEqualTo: dscNCOld)
        .get()
        .then((value) => value.docs.forEach((e) {
              var addRespostaData = e.data();
              addRespostaData['dscNC'] = dscNCNew;
              addRespostaData['usuario'] = 'Paracel';
              e.reference.set(addRespostaData);
            }));
  }

  void deleteRespostas(String veiculo, String data, String localidade) {
    _firestore
        .collection('respostas')
        .where('veiculo', isEqualTo: veiculo)
        .where('data', isEqualTo: data)
        .where('localidade', isEqualTo: localidade)
        .get()
        .then((value) {
      value.docs.forEach((e) {
        e.reference.delete();
      });
    });
  }

  void updateRespostas(String data, String localidade) {
    _firestore
        .collection('respostas')
        .where('data', isEqualTo: data)
        .where('localidade', isEqualTo: localidade)
        .get()
        .then((value) {
      value.docs.forEach((e) {
        var addRespostaData = e.data();
        addRespostaData['data'] = '06/05/2021';
        addRespostaData['usuario'] = 'Paracel';
        e.reference.set(addRespostaData);
      });
    });
  }
}
