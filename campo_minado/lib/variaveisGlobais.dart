import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:campo_minado/cardMatriz.dart';

var linhas = 5;
var colunas = 5;
var bombas = 5;

// Inicializa as variáveis
var posicoesBombasAleatorias = <int>[];
var campo_minado = GridView.count(crossAxisCount: colunas, children: []);

void gerarCampo() {
  posicoesBombasAleatorias = List.generate(
    bombas,
    (index) => Random().nextInt(linhas * colunas),
  );

  campo_minado = GridView.count(
    crossAxisCount: colunas,
    children: <Widget>[
      for (var i = 0; i < (linhas * colunas); i++)
        if (posicoesBombasAleatorias.contains(i))
          CardMatriz(posicao: i, eBomba: true)
        else
          CardMatriz(posicao: i, eBomba: false),
    ],
  );
}
