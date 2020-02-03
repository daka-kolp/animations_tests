import 'package:graphql/client.dart';
import 'package:ram_app/src/data/models/characters_model.dart';
import 'package:ram_app/src/device/utils/graph_ql_client.dart';
import 'package:ram_app/src/domain/entities/character.dart';

class RaMRepo{
  int _page;

  List<Character> _characters = [];

  List<Character> get characters => _characters;

  RaMRepo() : _page = 1;

  Future<void> getCharacters() async {
    final result = await graphQLClient.query(_queryOptions());
    print(result.data['characters']);

    final responseModel = CharactersModel.fromJson(result.data['characters']);
    final info = responseModel.info;
    if(_page < info.count){
      _page += 1;
    }
    return responseModel.results;
  }

  QueryOptions _queryOptions() => QueryOptions(
    documentNode: gql(fetchCharacters),
    variables: <String, dynamic>{
      'page': _page,
    },
  );
}

String fetchCharacters = r'''
query fetchCharacters($page: Int){
  characters(page: $page) {
    info {
      count,
      pages
    }
    results {
      id,
      name,
      status,
      species,
      type,
      gender,
      origin {
        name
      }
      location {
        name
      }
      image,      
    }
  }
}
''';
