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
  final double size = 360;

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
    Widget sideOuter = Container(
      width: size / 4.5,
      height: size,
      color: Colors.blue[800],
    );

    Widget centerOuter = Container(
      width: size / 1.8,
      height: size / 3,
      color: Colors.blue[700],
    );

    Widget centerTopOuter = Container(
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
        size: size,
        sideOuter: sideOuter,
        centerOuter: centerOuter,
        centerTopOuter: centerTopOuter,
      ),
    );
  }
}

class InfoPaper extends StatelessWidget {
  final InfoPaperAnimation envelopeController;
  final double size;
  final Widget sideOuter;
  final Widget centerOuter;
  final Widget centerTopOuter;

  InfoPaper({
    Key key,
    AnimationController controller,
    @required this.size,
    @required this.sideOuter,
    @required this.centerOuter,
    @required this.centerTopOuter,
  })  : envelopeController = InfoPaperAnimation(controller),
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
            child: ContentWidget(
              size: size,
            ),
            animation: envelopeController.controller,
            builder: (context, child) {
              if (envelopeController.controller.value < 1 / 3) {
                return Stack(
                  children: <Widget>[
                    _centerStatic(child),
                    _buildLeftInner(child),
                    _buildLeftOuter(),
                    _buildRightInner(child),
                    _buildRightOuter(),
                  ],
                );
              } else {
                return _centerAnimated(child);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _centerAnimated(Widget child) {
    return Center(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              _buildCenterTopInner(child),
              if (envelopeController.controller.value <= 1.0 &&
                  envelopeController.controller.value > 1 / 3)
                Positioned(
                  right: 0.0,
                  child: sideOuter,
                ),
              if (envelopeController.controller.value <= 1.0 &&
                  envelopeController.controller.value > 1 / 3)
                Positioned(
                  left: 0.0,
                  child: sideOuter,
                ),
            ],
          ),
          if (envelopeController.controller.value >= 5 / 6)
            _bottomTwoOuterAnimation(
              child: centerTopOuter,
            ),
          if (envelopeController.controller.value < 5 / 6)
            _bottomTwoInnerAnimation(
              child: Stack(
                children: <Widget>[
                  _buildCenterInner(child),
                  if (envelopeController.controller.value < 5 / 6 &&
                      envelopeController.controller.value > 1 / 3)
                    Positioned(
                      left: 0.0,
                      child: sideOuter,
                    ),
                  if (envelopeController.controller.value < 5 / 6 &&
                      envelopeController.controller.value > 1 / 3)
                    Positioned(
                      right: 0.0,
                      child: sideOuter,
                    ),
                  if (envelopeController.controller.value >= 4 / 6)
                    centerOuter
                ],
              ),
            ),
          if (envelopeController.controller.value < 0.5)
            _bottomOneInnerAnimation(
              child: Stack(
                children: <Widget>[
                  _buildCenterBottomInner(child),
                  if (envelopeController.controller.value < 7 / 12 &&
                      envelopeController.controller.value > 1 / 3)
                    Positioned(
                      left: 0.0,
                      child: sideOuter,
                    ),
                  if (envelopeController.controller.value < 7 / 12 &&
                      envelopeController.controller.value > 1 / 3)
                    Positioned(
                      right: 0.0,
                      child: sideOuter,
                    ),
                ],
              ),
            ),
          if (envelopeController.controller.value >= 0.5 &&
              envelopeController.controller.value < 4 / 6)
            _bottomOneOuterAnimation(child: centerOuter)
        ],
      ),
    );
  }

  Widget _centerStatic(Widget child) {
    return Positioned(
      left: size / 4.5,
      child: Column(
        children: <Widget>[
          _buildCenterTopInner(child),
          _buildCenterInner(child),
          _buildCenterBottomInner(child),
        ],
      ),
    );
  }

  Widget _buildLeftInner(Widget child) {
    return Positioned(
      left: 0.0,
      child: _leftInnerAnimation(
        child: _leftInner(child),
      ),
    );
  }

  Widget _buildLeftOuter() {
    return Positioned(
      left: 0.0,
      child: _leftOuterAnimation(
        child: sideOuter,
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

  Widget _buildRightInner(Widget child) {
    return Positioned(
      right: 0.0,
      child: _rightInnerAnimation(
        child: _rightInner(child),
      ),
    );
  }

  Widget _buildRightOuter() {
    return Positioned(
      right: 0.0,
      child: _rightOuterAnimation(
        child: sideOuter,
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

  Widget _buildCenterTopInner(Widget child) {
    return _centerInner(Alignment.topCenter, child);
  }

  Widget _buildCenterInner(Widget child) {
    return _centerInner(Alignment.center, child);
  }

  Widget _buildCenterBottomInner(Widget child) {
    return _centerInner(Alignment.bottomCenter, child);
  }

  Widget _centerInner(Alignment alignment, Widget child) {
    return ClipRect(
      child: Align(
        alignment: alignment,
        heightFactor: 1 / 3,
        widthFactor: 5 / 9,
        child: child,
      ),
    );
  }

  Widget _leftInner(Widget child) {
    return _sideInner(Alignment.centerLeft, child);
  }

  Widget _rightInner(Widget child) {
    return _sideInner(Alignment.centerRight, child);
  }

  Widget _sideInner(Alignment alignment, Widget child) {
    return ClipRect(
      child: Align(
        alignment: alignment,
        widthFactor: 2 / 9,
        child: child,
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
        bottomTwoInnerAnimation =
            _createInnerAnimation(controller, 2 / 3, 5 / 6),
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
  final double size;

  const ContentWidget({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return Container(
      height: size,
      width: size,
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
