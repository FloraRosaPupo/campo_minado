import 'package:flutter/material.dart';
import 'package:campo_minado/dominio/entidades/celula.dart';

class CelulaTabuleiro extends StatelessWidget {
  final Celula celula;
  final VoidCallback onAbrir;
  final VoidCallback onAlternarBandeira;

  const CelulaTabuleiro({
    super.key,
    required this.celula,
    required this.onAbrir,
    required this.onAlternarBandeira,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAbrir,
      onLongPress: onAlternarBandeira,
      onSecondaryTap: onAlternarBandeira,
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: _getCor(),
        ),
        child: Center(child: _getConteudo()),
      ),
    );
  }

  Color _getCor() {
    if (celula.aberta) {
      if (celula.eBomba) return Colors.red;
      return Colors.white;
    }
    if (celula.bandeira) return Colors.orange;
    return Colors.grey[300]!;
  }

  Widget _getConteudo() {
    if (celula.aberta) {
      if (celula.eBomba) {
        return const Icon(Icons.dangerous, color: Colors.black);
      }
      if (celula.bombasAdjacentes > 0) {
        return Text(
          '${celula.bombasAdjacentes}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _getCorNumero(celula.bombasAdjacentes),
          ),
        );
      }
      return const SizedBox.shrink();
    }
    if (celula.bandeira) {
      return const Icon(Icons.flag, color: Colors.white);
    }
    return const SizedBox.shrink();
  }

  Color _getCorNumero(int numero) {
    switch (numero) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      case 4:
        return Colors.purple;
      default:
        return Colors.black;
    }
  }
}
