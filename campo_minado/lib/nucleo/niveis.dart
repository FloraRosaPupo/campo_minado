import 'package:campo_minado/dominio/entidades/nivel.dart';

/// Níveis disponíveis no jogo. Médio e Difícil são desbloqueados ao vencer o anterior.
class Niveis {
  static const String idFacil = 'facil';
  static const String idMedio = 'medio';
  static const String idDificil = 'dificil';

  static const Nivel facil = Nivel(
    id: idFacil,
    nome: 'Fácil',
    linhas: 5,
    colunas: 5,
    bombas: 5,
  );

  static const Nivel medio = Nivel(
    id: idMedio,
    nome: 'Médio',
    linhas: 6,
    colunas: 6,
    bombas: 10,
  );

  static const Nivel dificil = Nivel(
    id: idDificil,
    nome: 'Difícil',
    linhas: 8,
    colunas: 8,
    bombas: 18,
  );

  static const List<Nivel> todos = [facil, medio, dificil];

  static Nivel porId(String id) {
    return todos.firstWhere(
      (n) => n.id == id,
      orElse: () => facil,
    );
  }
}
