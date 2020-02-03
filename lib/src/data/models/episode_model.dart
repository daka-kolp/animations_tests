import 'package:ram_app/src/data/consts/field_names.dart' as fn;
import 'package:ram_app/src/domain/entities/episode.dart';

class EpisodeModel extends Episode {
  EpisodeModel({
    int id,
    String name,
    String airDate,
    String episode,
    List<String> characters,
    String url,
    String created,
  }) : super(
          id: id,
          name: name,
          airDate: airDate,
          episode: episode,
          characters: characters,
          url: url,
          created: created,
        );

  DateTime get dateTimeCreated => DateTime.tryParse(created);

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);
}

Episode _$EpisodeModelFromJson(Map<String, dynamic> json) {
  return Episode(
      id: json[fn.id] as int,
      name: json[fn.name] as String,
      airDate: json[fn.airDate] as String,
      episode: json[fn.episode] as String,
      characters: (json[fn.characters] as List).map((e) => e as String).toList(),
      url: json[fn.url] as String,
      created: json[fn.created] as String);
}
