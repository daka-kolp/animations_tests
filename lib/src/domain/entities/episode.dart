import 'package:meta/meta.dart';

class Episode {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characters;
  final String url;
  final String created;

  Episode({
    @required this.id,
    @required this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.url,
    this.created,
  })  : assert(id != null),
        assert(name != null);

  DateTime get dateTimeCreated => DateTime.tryParse(created);
}
