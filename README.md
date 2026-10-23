# 💣 Campo Minado — Flutter Mobile

Jogo **Campo Minado** desenvolvido em **Flutter** para dispositivos **mobile (Android/iOS)**, com foco em lógica de jogo, organização de código e boa experiência de uso.

---

## 🎯 Objetivo
Praticar Flutter através da implementação de um jogo clássico, aplicando boas práticas de UI e separação de responsabilidades.

---

## 📱 Plataforma
- Mobile (Android / iOS)
- Flutter
- Sem backend
- Sem login

---

## 🧩 Funcionalidades
- Tabuleiro em grade com minas aleatórias
- Revelação de células por toque
- Marcação de bandeiras (long press)
- Contador de tempo e minas
- Detecção de vitória e derrota
- Reinício do jogo

---

## 🏗️ Estrutura
```

lib/
├── models/
├── controllers/
├── screens/
├── widgets/
└── main.dart

````

---

## 🚀 Executar
```bash
flutter pub get
flutter run
````

---

## 🔮 Melhorias Futuras

* Seleção de dificuldade
* Temas visuais
* Ranking local

```



## Desenvolvimento e validação

O aplicativo está em `campo_minado`. Use Flutter 3.41.1. Na pasta do aplicativo, execute:

```sh
flutter pub get
flutter analyze --no-fatal-infos --no-fatal-warnings
flutter test
flutter run
```

A CI valida análise e testes em pushes e pull requests. Serviços externos precisam de configuração própria.


## Stack e bibliotecas

Flutter/Dart e domínio Dart.


## Licença

Não há licença de distribuição definida neste repositório. Os direitos de terceiros e as atribuições existentes devem ser respeitados; esta revisão não concede permissão de redistribuição.


## Organização e manutenção

Uma única funcionalidade com domínio e apresentação já separados. `GerarTabuleiro` mantém regra pura e é testável sem interface. Estrutura em português foi preservada; não há Cubits de features diferentes misturados.

Veja [a revisão de desenvolvimento](docs/REVISAO.md) para decisões, testes e limites, e [o guia de contribuição](CONTRIBUTING.md) para o fluxo de manutenção.
