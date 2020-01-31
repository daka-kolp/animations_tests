import 'package:ram_app/src/data/consts/field_names.dart' as fn;
import 'package:ram_app/src/data/models/character_request.dart';
import 'package:ram_app/src/data/models/info_request.dart';

class CharactersRequest {
  final InfoRequest info;
  final List<CharacterRequest> results;

  CharactersRequest({
    this.info,
    this.results,
  });

  factory CharactersRequest.fromJson(Map<String, dynamic> json) =>
      _$CharacterRequestFromJson(json);
}

CharactersRequest _$CharacterRequestFromJson(Map<String, dynamic> json) {
  return CharactersRequest(
      info: InfoRequest.fromJson(json[fn.info] as Map<String, dynamic>),
      results: (json[fn.results] as List)
          .map((e) => CharacterRequest.fromJson(e as Map<String, dynamic>))
          .toList());
}
