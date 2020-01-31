import 'package:meta/meta.dart';

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final SimpleLocation origin;
  final SimpleLocation location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;

  Character({
    @required this.id,
    @required this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  })  : assert(id != null),
        assert(name != null);

  DateTime get dateTimeCreated => DateTime.tryParse(created);
}

class SimpleLocation {
  final String name;
  final String url;

  SimpleLocation({
    @required this.name,
    @required this.url,
  })  : assert(name != null),
        assert(url != null);
}
