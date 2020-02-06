import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ram_app/src/app/pages/description_page.dart';
import 'package:ram_app/src/app/pages/main_page_change_notifier.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () {
        if (_controller.position.pixels >=
            _controller.position.maxScrollExtent) {
          Provider.of<MainPageChangeNotifier>(context, listen: false)
              .loadCharacters();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Rick'n'Morty's characters"),
          centerTitle: true,
        ),
        body: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            Consumer<MainPageChangeNotifier>(
                builder: (context, notifier, child) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            '${notifier.characters[index].name}',
                          ),
                          onTap: () =>
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => DescriptionPageAnimator(
                                        character: notifier.characters[index],
                                      ))),
                        ),
                        Divider(height: 1.0)
                      ],
                    );
                  },
                  childCount: notifier.characters.length,
                ),
              );
            }),
            if (Provider.of<MainPageChangeNotifier>(context).isLoading)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
