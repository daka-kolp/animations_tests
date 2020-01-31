import 'package:ram_app/src/data/consts/field_names.dart' as fn;

class ResourcesRequest {
  final String characters;
  final String locations;
  final String episodes;

  ResourcesRequest({
    this.characters,
    this.locations,
    this.episodes,
  });

  factory ResourcesRequest.fromJson(Map<String, dynamic> json) =>
      _$ResourcesRequestFromJson(json);
}

ResourcesRequest _$ResourcesRequestFromJson(Map<String, dynamic>json) {
  return ResourcesRequest(
    characters: json[fn.characters] as String,
    locations: json[fn.locations] as String,
    episodes: json[fn.episodes] as String,
  );
}
