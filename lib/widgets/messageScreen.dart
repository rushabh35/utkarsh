import 'package:flutter/material.dart';


class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  double loadingBallSize = 1;
  AlignmentGeometry _alignment = Alignment.center;
  bool stopScaleAnimtion = false;
  bool showMessages = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        _alignment = Alignment.topRight;
        stopScaleAnimtion = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: _alignment,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 500),
            tween: Tween(begin: 0, end: loadingBallSize),
            onEnd: () {
              if (!stopScaleAnimtion) {
                setState(() {
                  if (loadingBallSize == 1) {
                    loadingBallSize = 1.5;
                  } else {
                    loadingBallSize = 1;
                  }
                });
              } else {
                Future.delayed(const Duration(milliseconds: 300), () {
                  setState(() {
                    showMessages = true;
                  });
                });
              }
            },
            builder: (_, value, __) => Transform.scale(
              scale: value,
              child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: !stopScaleAnimtion
                        ? Colors.black.withOpacity(0.8)
                        : null,
                    shape: BoxShape.circle,
                  ),
                  child: stopScaleAnimtion
                      ? TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 600),
                      tween: Tween(begin: 0, end: 1),
                      builder: (_, value, __) => Opacity(
                          opacity: value,
                          child: Image.asset("assets/images/avatar.png")))
                      : null),
            ),
          ),
        ),
        if (showMessages) ...[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TweenAnimationBuilder<double>(
                    duration: const Duration(seconds: 1),
                    tween: Tween(begin: 0, end: 1),
                    builder: (_, value, __) => Opacity(
                      opacity: value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, Hosain",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.85),
                                fontSize: 30,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "You have 2 new\nimportant messages today",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 23,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  // const MessagesList(),
                ],
              ),
            ),
          )
        ]
      ],
    );
  }
}