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
