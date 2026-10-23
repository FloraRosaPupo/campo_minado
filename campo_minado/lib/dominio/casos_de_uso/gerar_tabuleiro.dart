import 'dart:math';
import 'package:campo_minado/dominio/entidades/celula.dart';

class GerarTabuleiro {
  /// Gera um tabuleiro com [linhas], [colunas] e [bombas] nas posições aleatórias.
  List<Celula> executar({required int linhas, required int colunas, required int bombas}) {
    if (linhas <= 0 || colunas <= 0 || bombas < 0) {
      throw ArgumentError('Dimensões devem ser positivas e bombas não negativas.');
    }
    final totalCelulas = linhas * colunas;
    if (bombas >= totalCelulas) bombas = totalCelulas - 1;

    // Posições únicas para as bombas (evita repetição)
    final random = Random();
    final posicoesBombas = <int>{};
    while (posicoesBombas.length < bombas) {
      posicoesBombas.add(random.nextInt(totalCelulas));
    }

    // Criar células
    List<Celula> tabuleiro = [];
    for (int i = 0; i < totalCelulas; i++) {
      tabuleiro.add(Celula(id: i, eBomba: posicoesBombas.contains(i)));
    }

    // Calcular bombas adjacentes
    for (int i = 0; i < tabuleiro.length; i++) {
      if (tabuleiro[i].eBomba) continue;

      int bombasAoRedor = 0;
      List<int> vizinhos = _obterVizinhos(i, linhas, colunas);

      for (int vizinhoIndex in vizinhos) {
        if (tabuleiro[vizinhoIndex].eBomba) {
          bombasAoRedor++;
        }
      }
      tabuleiro[i].bombasAdjacentes = bombasAoRedor;
    }

    return tabuleiro;
  }

  List<int> _obterVizinhos(int index, int linhas, int colunas) {
    List<int> vizinhos = [];
    int linha = index ~/ colunas;
    int coluna = index % colunas;

    List<List<int>> offsets = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1],
      [1, -1], [1, 0], [1, 1],
    ];

    for (var offset in offsets) {
      int novaLinha = linha + offset[0];
      int novaColuna = coluna + offset[1];

      if (novaLinha >= 0 &&
          novaLinha < linhas &&
          novaColuna >= 0 &&
          novaColuna < colunas) {
        vizinhos.add(novaLinha * colunas + novaColuna);
      }
    }
    return vizinhos;
  }
}
