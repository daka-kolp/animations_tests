import 'package:graphql/client.dart';
import 'package:ram_app/src/data/models/characters_model.dart';
import 'package:ram_app/src/device/utils/graph_ql_client.dart';
import 'package:ram_app/src/domain/entities/character.dart';

class RaMRepo {

  Future<List<Character>> getCharacters(int page) async {
    final result = await graphQLClient.query(_queryOptions(page));

    final responseModel = CharactersModel.fromJson(result.data['characters']);
    final info = responseModel.info;
    if(page < info.count){
      return responseModel.results;
    }
    return [];
  }

  QueryOptions _queryOptions(int page) => QueryOptions(
    documentNode: gql(fetchCharacters),
    variables: <String, dynamic>{
      'page': page,
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
