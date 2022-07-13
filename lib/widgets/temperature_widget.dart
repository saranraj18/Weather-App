import 'package:flutter/material.dart';

class Temperature extends StatelessWidget {
  const Temperature({
    Key? key,
    this.temperature = 0,
    this.tempSize,
    this.degSize,
    this.rightDiff,
    this.topDiff,
  }) : super(key: key);

  final int? temperature;
  final double? tempSize;
  final double? degSize;
  final double? rightDiff;
  final double? topDiff;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:
              EdgeInsets.only(right: rightDiff ?? 11.5, top: topDiff ?? 1.5),
          child: Text(
            "$temperature",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
              fontSize: tempSize,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Text(
            "°C",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontSize: degSize,
            ),
          ),
        ),
      ],
    );
  }
}
