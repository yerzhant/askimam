import 'dart:convert';

mixin Model {
  Map<String, dynamic> toJson();
  List<int> toJsonUtf8() => utf8.encode(jsonEncode(toJson()));
}
