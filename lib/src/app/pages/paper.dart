import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class PaperAnimator extends StatefulWidget {
  @override
  _PaperAnimatorState createState() => new _PaperAnimatorState();
}

class _PaperAnimatorState extends State<PaperAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.status == AnimationStatus.completed) {
          _controller.reverse();
        }
        if (_controller.status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      },
      child: Envelope(
        controller: _controller,
      ),
    );
  }
}

class Envelope extends StatelessWidget {
  final EnvelopeAnimation envelopeController;

  Envelope({Key key, AnimationController controller})
      : envelopeController = EnvelopeAnimation(controller),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 100),
          width: 360,
          height: MediaQuery.of(context).size.height,
          child: AnimatedBuilder(
              animation: envelopeController.controller,
              builder: (context, child) {
                if (envelopeController.controller.value < 0.5) {
                  return Stack(
                    children: <Widget>[
                      _center(),
                      _left(),
                      _right(),
                    ],
                  );
                } else {
                  return Stack(
                    children: <Widget>[
//                      _right(),
//                      _left(),
                      _center(),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget _center() {
    return Positioned(
      right: 80,
//      child: Container(
//        width: 200,
//        height: 360,
//        color: Colors.blue,
//      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 200,
                height: 120,
                color: Colors.blue,
              ),
              if (envelopeController.controller.value < 1.0 &&
                  envelopeController.controller.value > 0.5)
                Positioned(
                  right: 0.0,
                  child: Container(
                    width: 80,
                    height: 120,
                    color: Colors.blue[800],
                  ),
                ),
              if (envelopeController.controller.value < 1.0 &&
                  envelopeController.controller.value > 0.5)
                Positioned(
                  left: 0.0,
                  child: Container(
                    width: 80,
                    height: 120,
                    color: envelopeController.controller.value < 0.375
                        ? Colors.blue
                        : Colors.blue[800],
                  ),
                ),
            ],
          ),
          Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(-envelopeController.bottomTwoAnimation.value * pi),
            child: Stack(
              children: <Widget>[
                if (envelopeController.controller.value < 0.75 &&
                    envelopeController.controller.value > 0.5)
                  Positioned(
                    right: 0.0,
                    child: Container(
                      width: 80,
                      height: 120,
                      color: Colors.blue[800],
                    ),
                  ),
                if (envelopeController.controller.value < 0.75 &&
                    envelopeController.controller.value > 0.5)
                  Positioned(
                    left: 0.0,
                    child: Container(
                      width: 80,
                      height: 120,
                      color: envelopeController.controller.value < 0.375
                          ? Colors.blue
                          : Colors.blue[800],
                    ),
                  ),
                Container(
                  width: 200,
                  height: 120,
                  color: envelopeController.controller.value < 0.75
                      ? Colors.blue
                      : Colors.blue[900],
                ),
                if (envelopeController.controller.value < 0.75 &&
                    envelopeController.controller.value > 0.5)
                  Positioned(
                    right: 0.0,
                    child: Container(
                      width: 80,
                      height: 120,
                      color: Colors.blue[800],
                    ),
                  ),
                if (envelopeController.controller.value < 0.75 &&
                    envelopeController.controller.value > 0.5)
                  Positioned(
                    left: 0.0,
                    child: Container(
                      width: 80,
                      height: 120,
                      color: envelopeController.controller.value < 0.375
                          ? Colors.blue
                          : Colors.blue[800],
                    ),
                  )
              ],
            ),
          ),
          if (envelopeController.controller.value < 0.75)
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(-envelopeController.bottomOneAnimation.value * pi),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 120,
                    color: envelopeController.controller.value < 0.625
                        ? Colors.blue
                        : Colors.blue[900],
                  ),
                  if (envelopeController.controller.value < 0.625 &&
                      envelopeController.controller.value > 0.5)
                    Positioned(
                      right: 0.0,
                      child: Container(
                        width: 80,
                        height: 120,
                        color: Colors.blue[800],
                      ),
                    ),
                  if (envelopeController.controller.value < 0.625 &&
                      envelopeController.controller.value > 0.5)
                    Positioned(
                      left: 0.0,
                      child: Container(
                        width: 80,
                        height: 120,
                        color: envelopeController.controller.value < 0.375
                            ? Colors.blue
                            : Colors.blue[800],
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _right() {
    return Positioned(
      right: 0.0,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(envelopeController.leftAnimation.value * pi),
        alignment: Alignment.centerLeft,
        child: Column(
          children: <Widget>[
            Container(
              width: 80,
              height: 120,
              color: envelopeController.controller.value < 0.125
                  ? Colors.blue
                  : Colors.blue[800],
            ),
            Container(
              width: 80,
              height: 120,
              color: envelopeController.controller.value < 0.125
                  ? Colors.blue
                  : Colors.blue[800],
            ),
            Container(
              width: 80,
              height: 120,
              color: envelopeController.controller.value < 0.125
                  ? Colors.blue
                  : Colors.blue[800],
            ),
          ],
        ),
      ),
    );
  }

  Widget _left() {
    return Positioned(
      left: 0.0,
      child: Transform(
        alignment: Alignment.centerRight,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(-envelopeController.rightAnimation.value * pi),
        child: Column(
          children: <Widget>[
            Container(
              width: 80,
              height: 120,
              color: envelopeController.controller.value < 0.375
                  ? Colors.blue
                  : Colors.blue[800],
            ),
            Container(
              width: 80,
              height: 120,
              color: envelopeController.controller.value < 0.375
                  ? Colors.blue
                  : Colors.blue[800],
            ),
            Container(
              width: 80,
              height: 120,
              color: envelopeController.controller.value < 0.375
                  ? Colors.blue
                  : Colors.blue[800],
            ),
          ],
        ),
      ),
    );
  }
}

class EnvelopeAnimation {
  final AnimationController controller;
  final Animation<double> rightAnimation;
  final Animation<double> leftAnimation;
  final Animation<double> bottomOneAnimation;
  final Animation<double> bottomTwoAnimation;

  EnvelopeAnimation(this.controller)
      : leftAnimation = _createAnimation(controller, 0.0, 0.25),
        rightAnimation = _createAnimation(controller, 0.25, 0.5),
        bottomOneAnimation = _createAnimation(controller, 0.5, 0.75),
        bottomTwoAnimation = _createAnimation(controller, 0.75, 1.0);

  static Animation<double> _createAnimation(
      AnimationController controller, double from, double to) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          from,
          to,
        ),
      ),
    );
  }
}
