import 'package:ram_app/src/data/consts/field_names.dart' as fn;

class InfoRequest {
  final int count;
  final int pages;
  final String next;
  final String prev;

  InfoRequest({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  factory InfoRequest.fromJson(Map<String, dynamic> json) =>
      _$InfoRequestFromJson(json);
}

InfoRequest _$InfoRequestFromJson(Map<String, dynamic> json) {
  return InfoRequest(
      count: json[fn.count] as int,
      pages: json[fn.pages] as int,
      next: json[fn.next] as String,
      prev: json[fn.prev] as String);
}
