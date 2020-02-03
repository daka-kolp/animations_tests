import 'dart:io';

import 'package:graphql/client.dart';

final HttpLink _httpLink = HttpLink(
  uri: 'https://rickandmortyapi.com/graphql',
);

final Link _link = _httpLink;

GraphQLClient _client;

GraphQLClient get graphQLClient {
  _client ??= GraphQLClient(
    link: _link,
    cache: InMemoryCache(),
  );

  return _client;
}