import 'package:ram_app/src/data/consts/field_names.dart' as fn;

class InfoModel {
  final int count;
  final int pages;
  final String next;
  final String prev;

  InfoModel({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) =>
      _$InfoModelFromJson(json);
}

InfoModel _$InfoModelFromJson(Map<String, dynamic> json) {
  return InfoModel(
      count: json[fn.count] as int,
      pages: json[fn.pages] as int,
      next: json[fn.next] as String,
      prev: json[fn.prev] as String);
}
