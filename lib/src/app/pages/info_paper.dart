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
                    _left1(),
                    _left2(),
                    _right1(),
                    _right2(),
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

  Widget _centerStatic() {
    return Positioned(
      left: 80,
      child: Column(
        children: <Widget>[
          _buildCenter1Top(),
          _buildCenter1(),
          _buildCenter1Bottom(),
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
              _buildCenter1Top(),
              if (envelopeController.controller.value <= 1.0 &&
                  envelopeController.controller.value > 1 / 3)
                Positioned(
                  right: 0.0,
                  child: _buildRight2(),
                ),
              if (envelopeController.controller.value <= 1.0 &&
                  envelopeController.controller.value > 1 / 3)
                Positioned(
                  left: 0.0,
                  child: _buildLeft2(),
                ),
            ],
          ),
          if (envelopeController.controller.value >= 5 / 6)
            _bottomTwo2Animation(
              child: _center3Part(),
            ),
          if (envelopeController.controller.value < 5 / 6)
            _bottomTwo1Animation(
              child: Stack(
                children: <Widget>[
                  _buildCenter1(),
                  if (envelopeController.controller.value < 5 / 6 &&
                      envelopeController.controller.value > 1 / 3)
                    Positioned(
                      left: 0.0,
                      child: _buildLeft2(),
                    ),
                  if (envelopeController.controller.value < 5 / 6 &&
                      envelopeController.controller.value > 1 / 3)
                    Positioned(
                      right: 0.0,
                      child: _buildRight2(),
                    ),
                  if (envelopeController.controller.value >= 4 / 6)
                    _center2Part()
                ],
              ),
            ),
          if (envelopeController.controller.value < 0.5)
            _bottomOne1Animation(
              child: Stack(
                children: <Widget>[
                  _buildCenter1Bottom(),
                  if (envelopeController.controller.value < 7 / 12 &&
                      envelopeController.controller.value > 1 / 3)
                    Positioned(
                      left: 0.0,
                      child: _buildLeft2(),
                    ),
                  if (envelopeController.controller.value < 7 / 12 &&
                      envelopeController.controller.value > 1 / 3)
                    Positioned(
                      right: 0.0,
                      child: _buildRight2(),
                    ),
                ],
              ),
            ),
          if (envelopeController.controller.value >= 0.5 &&
              envelopeController.controller.value < 4 / 6)
            _bottomOne2Animation(child: _center2Part())
        ],
      ),
    );
  }

  Widget _left1() {
    return Positioned(
      left: 0.0,
      child: _left1Animation(
        child: _buildLeft1(),
      ),
    );
  }

  Widget _left2() {
    return Positioned(
      left: 0.0,
      child: _left2Animation(
        child: _buildLeft2(),
      ),
    );
  }

  Widget _left1Animation({Widget child}) {
    return Transform(
      alignment: Alignment.centerRight,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(-envelopeController.side1Animation.value),
      child: child,
    );
  }

  Widget _left2Animation({Widget child}) {
    return Transform(
      alignment: Alignment.centerRight,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(-envelopeController.side2Animation.value),
      child: child,
    );
  }

  Widget _right1() {
    return Positioned(
      right: 0.0,
      child: _right1Animation(
        child: _buildRight1(),
      ),
    );
  }

  Widget _right2() {
    return Positioned(
      right: 0.0,
      child: _right2Animation(
        child: _buildRight2(),
      ),
    );
  }

  Widget _right1Animation({Widget child}) {
    return Transform(
      alignment: Alignment.centerLeft,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(envelopeController.side1Animation.value),
      child: child,
    );
  }

  Widget _right2Animation({Widget child}) {
    return Transform(
      alignment: Alignment.centerLeft,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(envelopeController.side2Animation.value),
      child: child,
    );
  }

  Widget _bottomOne1Animation({Widget child}) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-envelopeController.bottomOne1Animation.value),
      child: child,
    );
  }

  Widget _bottomOne2Animation({Widget child}) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-envelopeController.bottomOne2Animation.value),
      child: child,
    );
  }

  Widget _bottomTwo1Animation({Widget child}) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-envelopeController.bottomTwo1Animation.value),
      child: child,
    );
  }

  Widget _bottomTwo2Animation({Widget child}) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-envelopeController.bottomTwo2Animation.value),
      child: child,
    );
  }

  Widget _buildCenter1Top() {
    final ContentWidget widget = ContentWidget();
    final child = ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 1 / 3,
        widthFactor: 5 / 9,
        child: widget,
      ),
    );

    return child;
  }

  Widget _buildCenter1() {
    final ContentWidget widget = ContentWidget();
    final child = ClipRect(
      child: Align(
        alignment: Alignment.center,
        heightFactor: 1 / 3,
        widthFactor: 5 / 9,
        child: widget,
      ),
    );

    return child;
  }

  Widget _buildCenter1Bottom() {
    final ContentWidget widget = ContentWidget();
    final child = ClipRect(
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1 / 3,
        widthFactor: 5 / 9,
        child: widget,
      ),
    );

    return child;
  }

  Widget _buildLeft1() {
    final ContentWidget widget = ContentWidget();
    final child = ClipRect(
      child: Align(
        alignment: Alignment.centerLeft,
        widthFactor: 2 / 9,
        child: widget,
      ),
    );
    return child;
  }

  Widget _buildRight1() {
    final ContentWidget widget = ContentWidget();
    final child = ClipRect(
      child: Align(
        alignment: Alignment.centerRight,
        widthFactor: 2 / 9,
        child: widget,
      ),
    );
    return child;
  }

  Widget _buildLeft2() {
    return _side2Part();
  }

  Widget _buildRight2() {
    return _side2Part();
  }

  Widget _side2Part() {
    return Container(
      width: 80,
      height: 360,
      color: Colors.blue[800],
    );
  }

  Widget _center2Part() {
    return Container(
      width: 200,
      height: 120,
      color: Colors.blue[700],
    );
  }

  Widget _center3Part() {
    return Container(
      width: 200,
      height: 120,
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
  final Animation<double> side1Animation;
  final Animation<double> side2Animation;
  final Animation<double> bottomOne1Animation;
  final Animation<double> bottomOne2Animation;
  final Animation<double> bottomTwo1Animation;
  final Animation<double> bottomTwo2Animation;

  InfoPaperAnimation(this.controller)
      : side1Animation = _create1Animation(controller, 0.0, 1 / 6),
        side2Animation = _create2Animation(controller, 1 / 6, 1 / 3),
        bottomOne1Animation = _create1Animation(controller, 1 / 3, 0.5),
        bottomOne2Animation = _create2Animation(controller, 0.5, 2 / 3),
        bottomTwo1Animation = _create1Animation(controller, 2 / 3, 5 / 6),
        bottomTwo2Animation = _create2Animation(controller, 5 / 6, 1.0);

  static Animation<double> _create1Animation(
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

  static Animation<double> _create2Animation(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'open_eyes.png',
            width: 250,
          ),
          Image.asset(
            'logo.png',
            width: 250,
          )
        ],
      ),
//      child: Container(
//        margin: EdgeInsets.all(26.0),
//        child: Image.asset(
//          'qr1_example.png',
//          fit: BoxFit.fill,
//        ),
//      ),
    );
  }
}
