import 'package:flutter_test/flutter_test.dart';
import 'package:campo_minado/dominio/casos_de_uso/gerar_tabuleiro.dart';
void main() {
  test('tabuleiro contém bombas únicas e contagem correta dos vizinhos', () {
    final cells=GerarTabuleiro().executar(linhas:4,colunas:4,bombas:5);
    expect(cells.length,16);
    expect(cells.where((c)=>c.eBomba).length,5);
    for(final cell in cells.where((c)=>!c.eBomba)) {
      final row=cell.id~/4; final col=cell.id%4;
      final neighbors=cells.where((other)=>other.eBomba &&
        ((other.id~/4)-row).abs()<=1 && ((other.id%4)-col).abs()<=1);
      expect(cell.bombasAdjacentes,neighbors.length);
    }
  });
  test('dimensões inválidas são rejeitadas', () {
    expect(()=>GerarTabuleiro().executar(linhas:0,colunas:4,bombas:1),throwsArgumentError);
  });
  test('sempre reserva ao menos uma célula segura', () {
    final cells=GerarTabuleiro().executar(linhas:2,colunas:2,bombas:10);
    expect(cells.where((c)=>!c.eBomba).length,1);
  });
}
