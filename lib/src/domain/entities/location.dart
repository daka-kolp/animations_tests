import 'package:meta/meta.dart';

class Location {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;
  final String url;
  final String created;

  Location({
    @required this.id,
    @required this.name,
    this.type,
    this.dimension,
    this.residents,
    this.url,
    this.created,
  })  : assert(id != null),
        assert(name != null);

  DateTime get dateTimeCreated => DateTime.tryParse(created);
}
