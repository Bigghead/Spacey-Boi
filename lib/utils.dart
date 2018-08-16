import 'package:intl/intl.dart';

String getDate( int day ) {
  var now = new DateTime.now();
  var date = DateTime(now.year, now.month, now.day - (day) );
  var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(date);
  return formattedDate;
}
