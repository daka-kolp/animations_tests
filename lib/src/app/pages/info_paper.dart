import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class InfoPaperAnimator extends StatefulWidget {
  @override
  _InfoPaperAnimatorState createState() => new _InfoPaperAnimatorState();
}

class _InfoPaperAnimatorState extends State<InfoPaperAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
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
      child: InfoPaper(
        controller: _controller,
      ),
    );
  }
}

class InfoPaper extends StatelessWidget {
  final InfoPaperAnimation envelopeController;
  final double size = 360;

  InfoPaper({Key key, AnimationController controller})
      : envelopeController = InfoPaperAnimation(controller),
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
              if (envelopeController.controller.value < 1 / 3) {
                return Stack(
                  children: <Widget>[
                    _centerStatic(),
                    _buildLeftInner(),
                    _buildLeftOuter(),
                    _buildRightInner(),
                    _buildRightOuter(),
                  ],
                );
              } else {
                return _centerAnimated();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _centerAnimated() {
    return Center(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              _buildCenterTopInner(),
              if (envelopeController.controller.value <= 1.0 &&
                  envelopeController.controller.value > 1 / 3)
                Positioned(
                  right: 0.0,
                  child: _buildSideOuter(),
                ),
              if (envelopeController.controller.value <= 1.0 &&
                  envelopeController.controller.value > 1 / 3)
                Positioned(
                  left: 0.0,
                  child: _buildSideOuter(),
                ),
            ],
          ),
          if (envelopeController.controller.value >= 5 / 6)
            _bottomTwoOuterAnimation(
              child: _buildCenterTopOuter(),
            ),
          if (envelopeController.controller.value < 5 / 6)
            _bottomTwoInnerAnimation(
              child: Stack(
                children: <Widget>[
                  _buildCenterInner(),
                  if (envelopeController.controller.value < 5 / 6 &&
                      envelopeController.controller.value > 1 / 3)
                    Positioned(
                      left: 0.0,
                      child: _buildSideOuter(),
                    ),
                  if (envelopeController.controller.value < 5 / 6 &&
                      envelopeController.controller.value > 1 / 3)
                    Positioned(
                      right: 0.0,
                      child: _buildSideOuter(),
                    ),
                  if (envelopeController.controller.value >= 4 / 6)
                    _buildCenterOuter()
                ],
              ),
            ),
          if (envelopeController.controller.value < 0.5)
            _bottomOneInnerAnimation(
              child: Stack(
                children: <Widget>[
                  _buildCenterBottomInner(),
                  if (envelopeController.controller.value < 7 / 12 &&
                      envelopeController.controller.value > 1 / 3)
                    Positioned(
                      left: 0.0,
                      child: _buildSideOuter(),
                    ),
                  if (envelopeController.controller.value < 7 / 12 &&
                      envelopeController.controller.value > 1 / 3)
                    Positioned(
                      right: 0.0,
                      child: _buildSideOuter(),
                    ),
                ],
              ),
            ),
          if (envelopeController.controller.value >= 0.5 &&
              envelopeController.controller.value < 4 / 6)
            _bottomOneOuterAnimation(child: _buildCenterOuter())
        ],
      ),
    );
  }

  Widget _centerStatic() {
    return Positioned(
      left: size / 4.5,
      child: Column(
        children: <Widget>[
          _buildCenterTopInner(),
          _buildCenterInner(),
          _buildCenterBottomInner(),
        ],
      ),
    );
  }

  Widget _buildLeftInner() {
    return Positioned(
      left: 0.0,
      child: _leftInnerAnimation(
        child: _leftInner(),
      ),
    );
  }

  Widget _buildLeftOuter() {
    return Positioned(
      left: 0.0,
      child: _leftOuterAnimation(
        child: _buildSideOuter(),
      ),
    );
  }

  Widget _leftInnerAnimation({Widget child}) {
    return _sideAnimation(
      value: -envelopeController.sideInnerAnimation.value,
      alignment: Alignment.centerRight,
      child: child,
    );
  }

  Widget _leftOuterAnimation({Widget child}) {
    return _sideAnimation(
      value: -envelopeController.sideOuterAnimation.value,
      alignment: Alignment.centerRight,
      child: child,
    );
  }

  Widget _buildRightInner() {
    return Positioned(
      right: 0.0,
      child: _rightInnerAnimation(
        child: _rightInner(),
      ),
    );
  }

  Widget _buildRightOuter() {
    return Positioned(
      right: 0.0,
      child: _rightOuterAnimation(
        child: _buildSideOuter(),
      ),
    );
  }

  Widget _rightInnerAnimation({Widget child}) {
    return _sideAnimation(
      value: envelopeController.sideInnerAnimation.value,
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

  Widget _rightOuterAnimation({Widget child}) {
    return _sideAnimation(
      value: envelopeController.sideOuterAnimation.value,
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

  Widget _sideAnimation({Widget child, Alignment alignment, double value}) {
    return Transform(
      alignment: alignment,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(value),
      child: child,
    );
  }

  Widget _bottomOneInnerAnimation({Widget child}) {
    return _bottomAnimation(
      value: envelopeController.bottomOneInnerAnimation.value,
      child: child,
    );
  }

  Widget _bottomOneOuterAnimation({Widget child}) {
    return _bottomAnimation(
      value: envelopeController.bottomOneOuterAnimation.value,
      child: child,
    );
  }

  Widget _bottomTwoInnerAnimation({Widget child}) {
    return _bottomAnimation(
      value: envelopeController.bottomTwoInnerAnimation.value,
      child: child,
    );
  }

  Widget _bottomTwoOuterAnimation({Widget child}) {
    return _bottomAnimation(
      value: envelopeController.bottomTwoOuterAnimation.value,
      child: child,
    );
  }

  Widget _bottomAnimation({Widget child, double value}) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-value),
      child: child,
    );
  }

  Widget _buildCenterTopInner() {
    return _centerInner(Alignment.topCenter);
  }

  Widget _buildCenterInner() {
    return _centerInner(Alignment.center);
  }

  Widget _buildCenterBottomInner() {
    return _centerInner(Alignment.bottomCenter);
  }

  Widget _centerInner(Alignment alignment) {
    final ContentWidget widget = ContentWidget();
    final child = ClipRect(
      child: Align(
        alignment: alignment,
        heightFactor: 1 / 3,
        widthFactor: 5 / 9,
        child: widget,
      ),
    );
    return child;
  }

  Widget _leftInner() {
    return _sideInner(Alignment.centerLeft);
  }

  Widget _rightInner() {
    return _sideInner(Alignment.centerRight);
  }

  Widget _sideInner(Alignment alignment) {
    final ContentWidget widget = ContentWidget();
    final child = ClipRect(
      child: Align(
        alignment: alignment,
        widthFactor: 2 / 9,
        child: widget,
      ),
    );
    return child;
  }

  Widget _buildSideOuter() {
    return Container(
      width: size / 4.5,
      height: size,
      color: Colors.blue[800],
    );
  }

  Widget _buildCenterOuter() {
    return Container(
      width: size / 1.8,
      height: size / 3,
      color: Colors.blue[700],
    );
  }

  Widget _buildCenterTopOuter() {
    return Container(
      width: size / 1.8,
      height: size / 3,
      color: Colors.blue[900],
      child: Center(
        child: Transform(
          transform: Matrix4.rotationX(pi),
          alignment: Alignment.center,
          child: Text(
            'Open me',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class InfoPaperAnimation {
  final AnimationController controller;
  final Animation<double> sideInnerAnimation;
  final Animation<double> sideOuterAnimation;
  final Animation<double> bottomOneInnerAnimation;
  final Animation<double> bottomOneOuterAnimation;
  final Animation<double> bottomTwoInnerAnimation;
  final Animation<double> bottomTwoOuterAnimation;

  InfoPaperAnimation(this.controller)
      : sideInnerAnimation = _createInnerAnimation(controller, 0.0, 1 / 6),
        sideOuterAnimation = _createOuterAnimation(controller, 1 / 6, 1 / 3),
        bottomOneInnerAnimation = _createInnerAnimation(controller, 1 / 3, 0.5),
        bottomOneOuterAnimation = _createOuterAnimation(controller, 0.5, 2 / 3),
        bottomTwoInnerAnimation = _createInnerAnimation(controller, 2 / 3, 5 / 6),
        bottomTwoOuterAnimation = _createOuterAnimation(controller, 5 / 6, 1.0);

  static Animation<double> _createInnerAnimation(
      AnimationController controller, double from, double to) {
    return Tween<double>(begin: 0.0, end: pi / 2).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          from,
          to,
        ),
      ),
    );
  }

  static Animation<double> _createOuterAnimation(
      AnimationController controller, double from, double to) {
    return Tween<double>(begin: pi / 2, end: pi).animate(
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

class ContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return Container(
      height: 360,
      width: 360,
      color: Colors.blue[100],
      child: Container(
        margin: EdgeInsets.all(26.0),
        child: Image.asset(
          'qr1_example.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
