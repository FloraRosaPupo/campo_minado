import 'dart:async';
import 'package:flutter/material.dart';
import 'package:campo_minado/variaveisGlobais.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  int _secondsElapsed = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    gerarCampo();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(255, 4, 48, 8),
                const Color.fromARGB(255, 0, 0, 0),
              ],
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Timer:',
                            style: TextStyle(
                              color: Color.fromARGB(255, 9, 230, 17),
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.timer,
                                color: Color.fromARGB(255, 9, 230, 17),
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                '$_secondsElapsed',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 9, 230, 17),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              gerarCampo();
                              _secondsElapsed = 0;
                            });
                          },
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Bombas:',
                            style: TextStyle(
                              color: Color.fromARGB(255, 9, 230, 17),
                              fontSize: 16,
                            ),
                          ),

                          Row(
                            children: [
                              Icon(
                                Icons.dangerous,
                                color: Color.fromARGB(255, 9, 230, 17),
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                '$bombas',
                                style: TextStyle(
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
              ),
              Expanded(flex: 3, child: campo_minado),
            ],
          ),
        ),
      ),
    );
  }
}
