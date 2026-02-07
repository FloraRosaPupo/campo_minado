import 'package:flutter/material.dart';
import 'package:campo_minado/dominio/entidades/nivel.dart';
import 'package:campo_minado/nucleo/niveis.dart';
import 'package:campo_minado/nucleo/desbloqueio_niveis.dart';
import 'package:campo_minado/apresentacao/paginas/pagina_tabuleiro.dart';

class PaginaSelecaoNivel extends StatefulWidget {
  const PaginaSelecaoNivel({super.key});

  @override
  State<PaginaSelecaoNivel> createState() => _PaginaSelecaoNivelState();
}

class _PaginaSelecaoNivelState extends State<PaginaSelecaoNivel> {
  bool _medioDesbloqueado = false;
  bool _dificilDesbloqueado = false;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarDesbloqueios();
  }

  Future<void> _carregarDesbloqueios() async {
    final medio = await DesbloqueioNiveis.medioDesbloqueado();
    final dificil = await DesbloqueioNiveis.dificilDesbloqueado();
    if (mounted) {
      setState(() {
        _medioDesbloqueado = medio;
        _dificilDesbloqueado = dificil;
        _carregando = false;
      });
    }
  }

  void _iniciarJogo(Nivel nivel) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => PaginaTabuleiro(nivel: nivel),
          ),
        )
        .then((_) => _carregarDesbloqueios());
  }

  Future<void> _confirmarResetarTudo() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resetar tudo?'),
        content: const Text(
          'Isso vai bloquear os níveis Médio e Difícil. Só o Fácil ficará disponível.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Resetar'),
          ),
        ],
      ),
    );
    if (confirmar == true && mounted) {
      await DesbloqueioNiveis.resetarTudo();
      _carregarDesbloqueios();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: _carregando
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 9, 230, 17),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Campo Minado',
                        style: TextStyle(
                          color: Color.fromARGB(255, 9, 230, 17),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Escolha o nível',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 48),
                      _botaoNivel(
                        nivel: Niveis.facil,
                        desbloqueado: true,
                        descricao: '5×5 • 5 bombas',
                      ),
                      const SizedBox(height: 16),
                      _botaoNivel(
                        nivel: Niveis.medio,
                        desbloqueado: _medioDesbloqueado,
                        descricao: '6×6 • 10 bombas',
                      ),
                      const SizedBox(height: 16),
                      _botaoNivel(
                        nivel: Niveis.dificil,
                        desbloqueado: _dificilDesbloqueado,
                        descricao: '8×8 • 18 bombas',
                      ),
                      if (!_medioDesbloqueado || !_dificilDesbloqueado) ...[
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            _medioDesbloqueado
                                ? 'Vence o Médio para desbloquear o Difícil'
                                : 'Vence o Fácil para desbloquear o Médio',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                      const Spacer(),
                      TextButton.icon(
                        onPressed: _confirmarResetarTudo,
                        icon: const Icon(
                          Icons.restart_alt,
                          color: Colors.white54,
                          size: 20,
                        ),
                        label: const Text(
                          'Resetar tudo',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _botaoNivel({
    required Nivel nivel,
    required bool desbloqueado,
    required String descricao,
  }) {
    return Opacity(
      opacity: desbloqueado ? 1.0 : 0.5,
      child: Material(
        color: desbloqueado
            ? const Color.fromARGB(255, 9, 230, 17)
            : Colors.grey,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: desbloqueado ? () => _iniciarJogo(nivel) : null,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              children: [
                Text(
                  nivel.nome,
                  style: TextStyle(
                    color: desbloqueado ? Colors.black87 : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  descricao,
                  style: TextStyle(
                    color: desbloqueado ? Colors.black54 : Colors.white70,
                    fontSize: 14,
                  ),
                ),
                if (!desbloqueado)
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      'Complete o nível anterior',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
