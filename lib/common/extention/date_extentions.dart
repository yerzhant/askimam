import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String format() => DateFormat('d.MM.yyyy HH:mm:ss').format(this);
}
