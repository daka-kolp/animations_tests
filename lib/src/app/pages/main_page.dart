import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: RaMSliverAppBarDelegate(),
            pinned: true,
          ),
//          SliverToBoxAdapter(
//            child: Center(
//              child: Container(
//                margin: EdgeInsets.symmetric(
//                  vertical: 32.0,
//                ),
//                width: 200.0,
//                child: ClipRRect(
//                  borderRadius: BorderRadius.all(
//                    Radius.circular(16.0),
//                  ),
//                  child: Column(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      _buildTop(context),
//                      _buildTile(context, 'status', 'Dead'),
//                      Divider(height: 0.0),
//                      _buildTile(context, 'species', 'Humanoid'),
//                      Divider(height: 0.0),
//                      _buildTile(context, 'gender', 'Male'),
//                      Divider(height: 0.0),
//                      _buildTile(context, 'origin', 'Alien Spa'),
//                      Divider(height: 0.0),
//                      _buildTile(context, 'last location', 'Earth'),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
              ListTile(),
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://rickandmortyapi.com/api/character/avatar/361.jpeg',
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            color: Colors.black87,
            height: 46,
            width: 300,
            child: Text(
              'Toxic Rick',
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTile(BuildContext context, String name, String value) {
    return Container(
      color: Colors.grey[800],
      height: 36,
      width: 300,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  name.toUpperCase(),
                  style: Theme.of(context).textTheme.body1.copyWith(
                        color: Colors.grey,
                      ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.subhead.copyWith(
                        color: Colors.orange,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RaMSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1EC9E8).withOpacity(0.6),
                  Color(0xFFA7E541).withOpacity(0.6)
                ],
              ),
            ),
          ),
        ),
        Container(
          width: shrinkOffset < 140
              ? MediaQuery.of(context).size.width / 2
              : MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 35.0, top: 24),
          alignment: Alignment.centerLeft,
          child: Text(
            "Main",
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 26 - shrinkOffset / kToolbarHeight * 2,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 250.0;

  @override
  double get minExtent => kToolbarHeight * 2;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration(
        stretchTriggerOffset: 20000,
        onStretchTrigger: () async => print('asd'),
      );
}
