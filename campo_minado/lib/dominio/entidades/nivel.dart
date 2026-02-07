/// Representa um nível de dificuldade do jogo.
class Nivel {
  final String id;
  final String nome;
  final int linhas;
  final int colunas;
  final int bombas;

  const Nivel({
    required this.id,
    required this.nome,
    required this.linhas,
    required this.colunas,
    required this.bombas,
  });

  int get totalCelulas => linhas * colunas;
}
