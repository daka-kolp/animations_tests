import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class EnvelopeAnimator extends StatefulWidget {
@override
_EnvelopeAnimatorState createState() => new _EnvelopeAnimatorState();
}

class _EnvelopeAnimatorState extends State<EnvelopeAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _controller.forward();
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
        _controller.reset();
        _controller.forward();
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
        child: AnimatedBuilder(
            animation: envelopeController.controller,
            builder: (context, child) {
              if (envelopeController.controller.value < 0.5) {
                return Stack(
                  children: <Widget>[
                    _center(),
                    _top(),
                    _bottom(),
                    _topRight(),
                    _right(),
                    _left(),
                  ],
                );
              } else {
                return Stack(
                  children: <Widget>[
                    _center(),
                    _left(),
                    _topRight(),
                    _right(),
                    _top(),
                    _bottom(),
                  ],
                );
              }
            }),
      ),
    );
  }

  Widget _center() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
    );
  }

  Widget _topRight() {
    return Positioned(
      right: 0.0,
      top: 0.0,
      child: Transform(
        alignment: Alignment.topRight,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.003)
          ..rotateY(-envelopeController.rightAnimation.value * pi),
        child: Container(
          width: 90,
          height: 100,
          color: envelopeController.controller.value > 0.375 ? Colors.deepPurple : Colors.deepPurple[900],
        ),
      ),
    );
  }

  Widget _top() {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0025)
        ..rotateX(-envelopeController.topAnimation.value * pi),
      alignment: Alignment.topCenter,
      child: Container(
        width: 100,
        height: 90,
        color: envelopeController.controller.value > 0.875 ? Colors.pink : Colors.pink[900],
      ),
    );
  }

  Widget _bottom() {
    return Positioned(
      bottom: 0.0,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0025)
          ..rotateX(envelopeController.bottomAnimation.value * pi),
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 100,
          height: 90,
          color: envelopeController.controller.value > 0.625 ? Colors.lightGreen : Colors.lightGreen[900],
        ),
      ),
    );
  }

  Widget _left() {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.003)
        ..rotateY(envelopeController.leftAnimation.value * pi),
      alignment: Alignment.centerLeft,
      child: Container(
        width: 90,
        height: 100,
        color: envelopeController.controller.value > 0.125 ? Colors.yellowAccent : Colors.orange,
      ),
    );
  }

  Widget _right() {
    return Positioned(
      right: 0.0,
      child: Transform(
        alignment: Alignment.centerRight,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.003)
          ..rotateY(-envelopeController.rightAnimation.value * pi),
        child: Container(
          width: 90,
          height: 100,
          color: envelopeController.controller.value > 0.375 ? Colors.deepPurple : Colors.deepPurple[900],
        ),
      ),
    );
  }
}

class EnvelopeAnimation {
  final AnimationController controller;
  final Animation<double> bottomAnimation;
  final Animation<double> rightAnimation;
  final Animation<double> leftAnimation;
  final Animation<double> topAnimation;

  EnvelopeAnimation(this.controller)
      : leftAnimation = _createAnimation(controller, 0.0, 0.25),
        rightAnimation = _createAnimation(controller, 0.25, 0.5),
        bottomAnimation = _createAnimation(controller, 0.5, 0.75),
        topAnimation = _createAnimation(controller, 0.75, 1.0);

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
