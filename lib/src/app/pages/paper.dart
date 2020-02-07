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
      child: Paper(
        controller: _controller,
      ),
    );
  }
}

class Paper extends StatelessWidget {
  final PaperAnimation envelopeController;
  final double size = 360;

  Paper({Key key, AnimationController controller})
      : envelopeController = PaperAnimation(controller),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 100),
          width: size,
          height: MediaQuery.of(context).size.height,
          child: AnimatedBuilder(
              animation: envelopeController.controller,
              builder: (context, child) {
                if (envelopeController.controller.value < 0.5) {
                  return Stack(
                    children: <Widget>[
                      _centerStatic(),
                      _left(),
                      _right(),
                    ],
                  );
                } else {
                  return _centerAnimated();
                }
              }),
        ),
      ),
    );
  }

  Widget _centerStatic() {
    return Positioned(
      left: 80,
      child: Column(
        children: <Widget>[
          _buildCenterTop(),
          _buildCenter(),
          _buildCenterBottom(),
        ],
      ),
    );
  }

  Widget _centerAnimated() {
    return Center(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              _buildCenterTop(),
              if (envelopeController.controller.value < 1.0 &&
                  envelopeController.controller.value > 0.5)
                Positioned(
                  right: 0.0,
                  child: _buildRightTop(),
                ),
              if (envelopeController.controller.value < 1.0 &&
                  envelopeController.controller.value > 0.5)
                Positioned(
                  left: 0.0,
                  child: _buildLeftTop()
                ),
            ],
          ),
          _bottomTwoAnimation(
            child: Stack(
              children: <Widget>[
                _buildCenter(),
                if (envelopeController.controller.value < 0.75 &&
                    envelopeController.controller.value > 0.5)
                  Positioned(
                    left: 0.0,
                    child: _buildLeftCenter(),
                  ),
                if (envelopeController.controller.value < 0.75 &&
                    envelopeController.controller.value > 0.5)
                  Positioned(
                    right: 0.0,
                    child: _buildRightCenter(),
                  ),
              ],
            ),
          ),
          if (envelopeController.controller.value < 0.75)
            _bottomOneAnimation(
              child: Stack(
                children: <Widget>[
                  _buildCenterBottom(),
                  if (envelopeController.controller.value < 0.625 &&
                      envelopeController.controller.value > 0.5)
                    Positioned(
                      left: 0.0,
                      child: _buildLeftBottom(),
                    ),
                  if (envelopeController.controller.value < 0.625 &&
                      envelopeController.controller.value > 0.5)
                    Positioned(
                      right: 0.0,
                      child: _buildRightBottom(),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _left() {
    return Positioned(
      left: 0.0,
      child: _leftAnimation(
        child: Column(
          children: <Widget>[
            _buildLeftTop(),
            _buildLeftCenter(),
            _buildLeftBottom(),
          ],
        ),
      ),
    );
  }

  Widget _leftAnimation({Widget child}) {
    return Transform(
      alignment: Alignment.centerRight,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(-envelopeController.leftAnimation.value * pi),
      child: child,
    );
  }

  Widget _right() {
    return Positioned(
      right: 0.0,
      child: _rightAnimation(
        child: Column(
          children: <Widget>[
            _buildRightTop(),
            _buildRightCenter(),
            _buildRightBottom(),
          ],
        ),
      ),
    );
  }

  Widget _rightAnimation({Widget child}) {
    return Transform(
      alignment: Alignment.centerLeft,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(envelopeController.rightAnimation.value * pi),
      child: child,
    );
  }

  Widget _buildLeftTop() {
    return _leftPart();
  }

  Widget _buildLeftCenter() {
    return _leftPart();
  }

  Widget _buildLeftBottom() {
    return _leftPart();
  }

  Widget _buildCenterTop() {
    return _centerPart(true);
  }

  Widget _buildCenter() {
    return _centerPart(envelopeController.controller.value < 0.75);
  }

  Widget _buildCenterBottom() {
    return _centerPart(envelopeController.controller.value < 0.625);
  }

  Widget _buildRightTop() {
    return _rightPart();
  }

  Widget _buildRightCenter() {
    return _rightPart();
  }

  Widget _buildRightBottom() {
    return _rightPart();
  }

  Widget _leftPart() {
    return Container(
      width: 80,
      height: 120,
      color: envelopeController.controller.value < 0.125
          ? Colors.blue
          : Colors.blue[800],
    );
  }

  Widget _rightPart() {
    return Container(
      width: 80,
      height: 120,
      color: envelopeController.controller.value < 0.375
          ? Colors.blue
          : Colors.blue[800],
    );
  }

  Widget _centerPart(bool isLightSize) {
    return Container(
      width: 200,
      height: 120,
      color: isLightSize ? Colors.blue : Colors.blue[700],
    );
  }

  Widget _bottomOneAnimation({Widget child}) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-envelopeController.bottomOneAnimation.value * pi),
      child: child,
    );
  }

  Widget _bottomTwoAnimation({Widget child}) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-envelopeController.bottomTwoAnimation.value * pi),
      child: child,
    );
  }
}

class PaperAnimation {
  final AnimationController controller;
  final Animation<double> rightAnimation;
  final Animation<double> leftAnimation;
  final Animation<double> bottomOneAnimation;
  final Animation<double> bottomTwoAnimation;

  PaperAnimation(this.controller)
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
