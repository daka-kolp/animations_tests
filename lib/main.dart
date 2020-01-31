import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:ram_app/src/app/pages/main_page.dart';
import 'package:ram_app/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final link = HttpLink(uri: 'https://rickandmortyapi.com/graphql/');

    final client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: link,
        cache: InMemoryCache(),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Rick&Morty',
        theme: RaMTheme().themeData,
        home: MainScreen(),
      ),
    );
  }
}
