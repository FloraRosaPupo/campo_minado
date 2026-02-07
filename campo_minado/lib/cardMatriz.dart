import 'package:flutter/material.dart';

class CardMatriz extends StatefulWidget {
  final int posicao;
  final bool eBomba;

  const CardMatriz({super.key, required this.posicao, required this.eBomba});

  @override
  State<CardMatriz> createState() => _CardMatrizState();
}

class _CardMatrizState extends State<CardMatriz>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.eBomba ? Colors.red : Colors.grey[300],
      ),

      margin: EdgeInsets.all(1),
      child: Center(child: Text('${widget.posicao}')),
    );
  }
}
