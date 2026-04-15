import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          title: Text('Dice App'),
          backgroundColor: Colors.deepPurple,
          elevation: 0,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 2; // Match the dot pattern in the document screenshot
  int rightDiceNumber = 5;

  void rollDice() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Left Dice
              DiceFace(value: leftDiceNumber),
              SizedBox(width: 40),
              // Right Dice
              DiceFace(value: rightDiceNumber),
            ],
          ),
          SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: rollDice,
            child: Text(
              'Roll Dice',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiceFace extends StatelessWidget {
  final int value;
  const DiceFace({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.yellow[300]!, Colors.yellow[700]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: CustomPaint(
        painter: DicePainter(value),
      ),
    );
  }
}

class DicePainter extends CustomPainter {
  final int value;
  DicePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    final double radius = size.width / 10;
    
    // Grid positions for dots
    final offsetLeft = size.width * 0.25;
    final offsetRight = size.width * 0.75;
    final offsetTop = size.width * 0.25;
    final offsetBottom = size.width * 0.75;
    final offsetCenter = size.width * 0.5;

    void drawDot(double x, double y) {
      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // Center dot (for 1, 3, 5)
    if (value % 2 != 0) {
      drawDot(offsetCenter, offsetCenter);
    }
    // Top-right and bottom-left dots (for 2, 3, 4, 5, 6)
    if (value > 1) {
      drawDot(offsetLeft, offsetBottom);
      drawDot(offsetRight, offsetTop);
    }
    // Top-left and bottom-right dots (for 4, 5, 6)
    if (value > 3) {
      drawDot(offsetLeft, offsetTop);
      drawDot(offsetRight, offsetBottom);
    }
    // Middle-left and middle-right dots (for 6)
    if (value == 6) {
      drawDot(offsetLeft, offsetCenter);
      drawDot(offsetRight, offsetCenter);
    }
  }

  @override
  bool shouldRepaint(covariant DicePainter oldDelegate) => oldDelegate.value != value;
}
