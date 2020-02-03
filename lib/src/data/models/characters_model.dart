import 'package:ram_app/src/data/consts/field_names.dart' as fn;
import 'package:ram_app/src/data/models/character_model.dart';
import 'package:ram_app/src/data/models/info_model.dart';

class CharactersModel {
  final InfoModel info;
  final List<CharacterModel> results;

  CharactersModel({
    this.info,
    this.results,
  });

  factory CharactersModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
}

CharactersModel _$CharacterModelFromJson(Map<String, dynamic> json) {
  return CharactersModel(
      info: InfoModel.fromJson(json[fn.info] as Map<String, dynamic>),
      results: (json[fn.results] as List)
          .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
          .toList());
}
