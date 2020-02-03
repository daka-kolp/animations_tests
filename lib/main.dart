import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:ram_app/src/app/pages/main_page.dart';
import 'package:ram_app/src/device/utils/graph_ql_client.dart';
import 'package:ram_app/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier<GraphQLClient>(graphQLClient),
      child: CacheProvider(
        child: MaterialApp(
          title: 'Rick&Morty',
          theme: RaMTheme().themeData,
          home: MainScreen(),
        ),
      ),
    );
  }
}
