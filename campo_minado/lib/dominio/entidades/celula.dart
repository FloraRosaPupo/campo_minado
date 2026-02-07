class Celula {
  final int id;
  final bool eBomba;
  bool aberta;
  bool bandeira;
  int bombasAdjacentes;

  Celula({
    required this.id,
    required this.eBomba,
    this.aberta = false,
    this.bandeira = false,
    this.bombasAdjacentes = 0,
  });
}
