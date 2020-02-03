import 'package:ram_app/src/data/consts/field_names.dart' as fn;

class ResourcesModel {
  final String characters;
  final String locations;
  final String episodes;

  ResourcesModel({
    this.characters,
    this.locations,
    this.episodes,
  });

  factory ResourcesModel.fromJson(Map<String, dynamic> json) =>
      _$ResourcesModelFromJson(json);
}

ResourcesModel _$ResourcesModelFromJson(Map<String, dynamic>json) {
  return ResourcesModel(
    characters: json[fn.characters] as String,
    locations: json[fn.locations] as String,
    episodes: json[fn.episodes] as String,
  );
}
