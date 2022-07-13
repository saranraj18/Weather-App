import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  const GlassMorphism({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 2, color: Colors.white30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [Colors.white60, Colors.white10],
        ),
      ),
      child: Text("Hello"),
    );
  }
}
