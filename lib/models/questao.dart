class Questao {
  final int id;
  final String nome;

  Questao({required this.id, required this.nome});

  factory Questao.fromMap(Map data) {
    return Questao(
      id: data['id'],
      nome: data['nome'],
    );
  }
}
