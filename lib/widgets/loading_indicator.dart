import 'package:flutter/material.dart';
import 'dart:math';

class LoadingIndicator extends StatefulWidget {
  final String message;

  const LoadingIndicator({Key? key, this.message = 'Loading...'})
      : super(key: key);

  @override
  LoadingIndicatorState createState() => LoadingIndicatorState();
}

class LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * pi,
                  child: Stack(
                    children: List.generate(4, (index) {
                      return Transform.translate(
                        offset: Offset(
                            20 * cos(index * pi / 2), 20 * sin(index * pi / 2)),
                        child: const Dot(),
                      );
                    }),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(widget.message, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
    );
  }
}
