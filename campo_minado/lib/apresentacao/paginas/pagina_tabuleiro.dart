import 'package:flutter/material.dart';
import 'package:campo_minado/dominio/entidades/nivel.dart';
import 'package:campo_minado/nucleo/desbloqueio_niveis.dart';
import 'package:campo_minado/apresentacao/controladores/controlador_jogo.dart';
import 'package:campo_minado/apresentacao/componentes/celula_tabuleiro.dart';

class PaginaTabuleiro extends StatefulWidget {
  final Nivel nivel;

  const PaginaTabuleiro({super.key, required this.nivel});

  @override
  State<PaginaTabuleiro> createState() => _PaginaTabuleiroState();
}

class _PaginaTabuleiroState extends State<PaginaTabuleiro> {
  late final ControladorJogo _controlador;

  @override
  void initState() {
    super.initState();
    _controlador = ControladorJogo(nivel: widget.nivel);
    _controlador.iniciarJogo();
    _controlador.addListener(_ouvinteEstado);
  }

  void _ouvinteEstado() {
    if (_controlador.venceu) {
      DesbloqueioNiveis.marcarVenceu(widget.nivel);
      _mostrarDialog(
        titulo: 'Parabéns!',
        mensagem: 'Você venceu o nível ${widget.nivel.nome}!',
      );
    } else if (_controlador.perdeu) {
      _mostrarDialog(
        titulo: 'Game Over',
        mensagem: 'Você explodiu uma bomba!',
      );
    }
  }

  @override
  void dispose() {
    _controlador.removeListener(_ouvinteEstado);
    _controlador.dispose();
    super.dispose();
  }

  void _voltarSelecao() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 4, 48, 8),
                Color.fromARGB(255, 0, 0, 0),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: AnimatedBuilder(
            animation: _controlador,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Timer:',
                              style: TextStyle(
                                color: Color.fromARGB(255, 9, 230, 17),
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: Color.fromARGB(255, 9, 230, 17),
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${_controlador.segundos}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 9, 230, 17),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                onPressed: () {
                                  _controlador.reiniciarJogo();
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Bombas:',
                              style: TextStyle(
                                color: Color.fromARGB(255, 9, 230, 17),
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.dangerous,
                                  color: Color.fromARGB(255, 9, 230, 17),
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${_controlador.bombas}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Nível: ${_controlador.nivel.nome}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    flex: 2,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _controlador.colunas,
                      ),
                      itemCount: _controlador.tabuleiro.length,
                      itemBuilder: (context, index) {
                        return CelulaTabuleiro(
                          celula: _controlador.tabuleiro[index],
                          onAbrir: () => _controlador.abrirCelula(index),
                          onAlternarBandeira: () =>
                              _controlador.alternarBandeira(index),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: _voltarSelecao,
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: const Text(
                      'Sair',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _mostrarDialog({required String titulo, required String mensagem}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _voltarSelecao();
              },
              child: const Text('Sair'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _controlador.reiniciarJogo();
              },
              child: const Text('Jogar Novamente'),
            ),
          ],
        );
      },
    );
  }
}
