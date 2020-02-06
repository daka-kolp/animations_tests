import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:ram_app/src/domain/entities/character.dart';

class DescriptionPageAnimator extends StatefulWidget {
  final Character character;

  const DescriptionPageAnimator({Key key, this.character}) : super(key: key);

  @override
  _DescriptionPageAnimatorState createState() =>
      _DescriptionPageAnimatorState();
}

class _DescriptionPageAnimatorState extends State<DescriptionPageAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 1,
        milliseconds: 200,
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return DescriptionPage(
      width: MediaQuery.of(context).size.width,
      character: widget.character,
      controller: _animationController,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}

class DescriptionPage extends StatelessWidget {
  final Character character;
  final DescriptionAnimation animation;

  DescriptionPage({Key key, this.character, AnimationController controller, double width,})
      : animation = DescriptionAnimation(controller, width),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 48.0,
            horizontal: 32.0,
          ),
          child: AnimatedBuilder(
            animation: animation.controller,
            builder: _buildAnimation,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildImageCard(context),
              _buildName(context),
              _buildDivider(),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildInfo(context, 'status', character.status,
                      animation.locationOffsets[0]),
                  _buildInfo(context, 'species', character.species,
                      animation.locationOffsets[1]),
                  _buildInfo(context, 'gender', character.gender,
                      animation.locationOffsets[2]),
                  _buildInfo(context, 'origin', character.origin.name,
                      animation.locationOffsets[3]),
                  _buildInfo(context, 'last location', character.location.name,
                      animation.locationOffsets[4]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Theme.of(context).accentColor, width: 0.5)),
      padding: EdgeInsets.all(3.0),
      width: animation.avatarSize.value,
      height: animation.avatarSize.value,
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
        child: Image.network(
          character.image,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    return Text(
      character.name,
      style: Theme.of(context).textTheme.display1.copyWith(
          color: Colors.white.withOpacity(animation.titleOpacity.value)),
    );
  }

  Widget _buildDivider() {
    return Container(
      color: Colors.deepOrange.withOpacity(0.85),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      width: animation.dividerWidth.value,
      height: 2.0,
    );
  }

  Widget _buildInfo(
      BuildContext context, String name, String value, Animation<double> anim) {
    return Transform.translate(
      offset: Offset(anim.value, 0.0),
      child: Container(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              name.toUpperCase(),
              style: Theme.of(context).textTheme.body1.copyWith(
                    color: Colors.grey,
                  ),
            ),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.subhead.copyWith(
                      color: Colors.orange,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptionAnimation {
  final double width;
  final AnimationController controller;
  final Animation<double> avatarSize;
  final Animation<double> titleOpacity;
  final Animation<double> dividerWidth;
  final List<Animation<double>> locationOffsets;

  DescriptionAnimation(this.controller, this.width)
      : avatarSize = Tween(begin: 0.0, end: 110.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              0.5,
              curve: Curves.elasticOut,
            ),
          ),
        ),
        titleOpacity = Tween(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
              parent: controller,
              curve: Interval(
                0.35,
                0.70,
                curve: Curves.easeIn,
              )),
        ),
        dividerWidth = Tween(
          begin: 0.0,
          end: 225.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.65,
              0.75,
              curve: Curves.easeIn,
            ),
          ),
        ),
        locationOffsets = [
          Tween(begin: width, end: 0.0).animate(
            CurvedAnimation(
              parent: controller,
              curve: Interval(
                0.6,
                0.75,
                curve: Curves.fastOutSlowIn,
              ),
            ),
          ),
          Tween(begin: width, end: 0.0).animate(
            CurvedAnimation(
              parent: controller,
              curve: Interval(
                0.65,
                0.8,
                curve: Curves.fastOutSlowIn,
              ),
            ),
          ),
          Tween(begin: width, end: 0.0).animate(
            CurvedAnimation(
              parent: controller,
              curve: Interval(
                0.7,
                0.85,
                curve: Curves.fastOutSlowIn,
              ),
            ),
          ),
          Tween(begin: width, end: 0.0).animate(
            CurvedAnimation(
              parent: controller,
              curve: Interval(
                0.8,
                0.95,
                curve: Curves.fastOutSlowIn,
              ),
            ),
          ),
          Tween(begin: width, end: 0.0).animate(
            CurvedAnimation(
              parent: controller,
              curve: Interval(
                0.85,
                1.0,
                curve: Curves.fastOutSlowIn,
              ),
            ),
          ),
        ];
}
