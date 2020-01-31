import 'package:ram_app/src/data/consts/field_names.dart' as fn;
import 'package:ram_app/src/domain/entities/character.dart';

class CharacterRequest extends Character {
  CharacterRequest({
    int id,
    String name,
    String status,
    String species,
    String type,
    String gender,
    SimpleLocation origin,
    SimpleLocation location,
    String image,
    List<String> episode,
    String url,
    String created,
  }) : super(
          id: id,
          name: name,
          status: status,
          species: species,
          type: type,
          gender: gender,
          origin: origin,
          location: location,
          image: image,
          episode: episode,
          url: url,
          created: created,
        );

  factory CharacterRequest.fromJson(Map<String, dynamic> json) =>
      _$CharacterRequestFromJson(json);
}

class SimpleLocationRequest extends SimpleLocation {
  SimpleLocationRequest({
    String name,
    String url,
  }) : super(
          name: name,
          url: url,
        );

  factory SimpleLocationRequest.fromJson(Map<String, dynamic> json) =>
      _$SimpleLocationRequestFromJson(json);
}

CharacterRequest _$CharacterRequestFromJson(Map<String, dynamic> json) {
  return CharacterRequest(
    id: json[fn.id] as int,
    name: json[fn.name] as String,
    status: json[fn.status] as String,
    species: json[fn.species] as String,
    type: json[fn.type] as String,
    gender: json[fn.gender] as String,
    origin: SimpleLocationRequest.fromJson(json[fn.origin] as Map<String, dynamic>),
    location: SimpleLocationRequest.fromJson(json[fn.location] as Map<String, dynamic>),
    image: json[fn.image] as String,
    episode: (json[fn.episode] as List).map((e) => e as String).toList(),
    url: json[fn.url] as String,
    created: json[fn.created] as String,
  );
}

SimpleLocationRequest _$SimpleLocationRequestFromJson(Map<String, dynamic> json) {
  return SimpleLocationRequest(
    name: json[fn.name] as String,
    url: json[fn.url] as String,
  );
}
