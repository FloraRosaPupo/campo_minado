import 'package:shared_preferences/shared_preferences.dart';
import 'package:campo_minado/dominio/entidades/nivel.dart';
import 'package:campo_minado/nucleo/niveis.dart';

/// Persiste e consulta quais níveis foram vencidos (para desbloquear o próximo).
class DesbloqueioNiveis {
  static const String _keyPassouFacil = 'passou_facil';
  static const String _keyPassouMedio = 'passou_medio';

  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  /// Médio só fica disponível depois de vencer o Fácil.
  static Future<bool> medioDesbloqueado() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_keyPassouFacil) ?? false;
  }

  /// Difícil só fica disponível depois de vencer o Médio.
  static Future<bool> dificilDesbloqueado() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_keyPassouMedio) ?? false;
  }

  static Future<void> marcarVenceu(Nivel nivel) async {
    final prefs = await _getPrefs();
    if (nivel.id == Niveis.idFacil) {
      await prefs.setBool(_keyPassouFacil, true);
    } else if (nivel.id == Niveis.idMedio) {
      await prefs.setBool(_keyPassouMedio, true);
    }
  }

  /// Remove todo o progresso; Médio e Difícil voltam a ficar bloqueados.
  static Future<void> resetarTudo() async {
    final prefs = await _getPrefs();
    await prefs.remove(_keyPassouFacil);
    await prefs.remove(_keyPassouMedio);
  }
}
