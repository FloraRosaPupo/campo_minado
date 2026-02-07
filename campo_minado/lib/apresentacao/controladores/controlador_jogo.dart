import 'dart:async';
import 'package:flutter/material.dart';
import 'package:campo_minado/dominio/entidades/celula.dart';
import 'package:campo_minado/dominio/entidades/nivel.dart';
import 'package:campo_minado/dominio/casos_de_uso/gerar_tabuleiro.dart';

class ControladorJogo extends ChangeNotifier {
  final GerarTabuleiro _gerarTabuleiro = GerarTabuleiro();
  late Nivel _nivel;
  List<Celula> tabuleiro = [];
  int segundos = 0;
  Timer? _timer;

  bool venceu = false;
  bool perdeu = false;

  Nivel get nivel => _nivel;
  int get linhas => _nivel.linhas;
  int get colunas => _nivel.colunas;
  int get bombas => _nivel.bombas;

  ControladorJogo({required Nivel nivel}) {
    _nivel = nivel;
  }

  void iniciarJogo() {
    tabuleiro = _gerarTabuleiro.executar(
      linhas: _nivel.linhas,
      colunas: _nivel.colunas,
      bombas: _nivel.bombas,
    );
    segundos = 0;
    venceu = false;
    perdeu = false;
    _iniciarTimer();
    notifyListeners();
  }

  void reiniciarJogo() {
    _timer?.cancel();
    iniciarJogo();
  }

  void _iniciarTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      segundos++;
      notifyListeners();
    });
  }

  void abrirCelula(int index) {
    if (venceu || perdeu) return;
    if (index < 0 || index >= tabuleiro.length) return;
    if (tabuleiro[index].aberta || tabuleiro[index].bandeira) return;

    tabuleiro[index].aberta = true;

    if (tabuleiro[index].eBomba) {
      perdeu = true;
      _timer?.cancel();
      _revelarBombas();
    } else {
      if (tabuleiro[index].bombasAdjacentes == 0) {
        _abrirVizinhos(index);
      }
      _verificarVitoria();
    }
    notifyListeners();
  }

  void alternarBandeira(int index) {
    if (index < 0 || index >= tabuleiro.length) return;
    if (tabuleiro[index].aberta) return;

    tabuleiro[index].bandeira = !tabuleiro[index].bandeira;
    notifyListeners();
  }

  void _abrirVizinhos(int index) {
    List<int> vizinhos = _obterVizinhos(index);
    for (var vizinhoIndex in vizinhos) {
      abrirCelula(vizinhoIndex);
    }
  }

  void _revelarBombas() {
    for (var i = 0; i < tabuleiro.length; i++) {
      if (tabuleiro[i].eBomba) {
        tabuleiro[i].aberta = true;
      }
    }
  }

  void _verificarVitoria() {
    bool todasAsNaoBombasAbertas = true;
    for (var celula in tabuleiro) {
      if (!celula.eBomba && !celula.aberta) {
        todasAsNaoBombasAbertas = false;
        break;
      }
    }

    if (todasAsNaoBombasAbertas) {
      venceu = true;
      _timer?.cancel();
    }
  }

  List<int> _obterVizinhos(int index) {
    List<int> vizinhos = [];
    int linha = index ~/ _nivel.colunas;
    int coluna = index % _nivel.colunas;

    List<List<int>> offsets = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1],
      [1, -1], [1, 0], [1, 1],
    ];

    for (var offset in offsets) {
      int novaLinha = linha + offset[0];
      int novaColuna = coluna + offset[1];

      if (novaLinha >= 0 &&
          novaLinha < _nivel.linhas &&
          novaColuna >= 0 &&
          novaColuna < _nivel.colunas) {
        vizinhos.add(novaLinha * _nivel.colunas + novaColuna);
      }
    }
    return vizinhos;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
