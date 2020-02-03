import 'package:ram_app/src/data/consts/field_names.dart' as fn;
import 'package:ram_app/src/domain/entities/character.dart';

class CharacterModel extends Character {
  CharacterModel({
    String id,
    String name,
    String status,
    String species,
    String type,
    String gender,
    SimpleLocation origin,
    SimpleLocation location,
    String image,
    String url,
    String created,
  }) : super(
          id: int.parse(id),
          name: name,
          status: status,
          species: species,
          type: type,
          gender: gender,
          origin: origin,
          location: location,
          image: image,

          url: url,
          created: created,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
}

class SimpleLocationModel extends SimpleLocation {
  SimpleLocationModel({
    String name,
    String url,
  }) : super(
          name: name,
          url: url,
        );

  factory SimpleLocationModel.fromJson(Map<String, dynamic> json) =>
      _$SimpleLocationModelFromJson(json);
}

CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) {
  return CharacterModel(
    id: json[fn.id] as String,
    name: json[fn.name] as String,
    status: json[fn.status] as String,
    species: json[fn.species] as String,
    type: json[fn.type] as String,
    gender: json[fn.gender] as String,
    origin: SimpleLocationModel.fromJson(json[fn.origin] as Map<String, dynamic>),
    location: SimpleLocationModel.fromJson(json[fn.location] as Map<String, dynamic>),
    image: json[fn.image] as String,
    url: json[fn.url] as String,
    created: json[fn.created] as String,
  );
}

SimpleLocationModel _$SimpleLocationModelFromJson(Map<String, dynamic> json) {
  return SimpleLocationModel(
    name: json[fn.name] as String,
    url: json[fn.url] as String,
  );
}
