import 'package:intl/intl.dart';

String parseDateTime(DateTime date) {
  final dateFormatted = DateFormat.MMMMd().format(date);
  //using split we split the date into two parts
  final splitedDate = dateFormatted.split(' ');
  //here _splitedDate.last is second word that is month name and other one is the first word
  return "${splitedDate.last}  ${splitedDate.first} ";
}
