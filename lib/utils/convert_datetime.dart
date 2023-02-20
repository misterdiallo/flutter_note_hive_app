import 'package:intl/intl.dart';

class ConvertDateTime {
  static String convertDate(DateTime data) {
    if (data.difference(DateTime.now()).inDays == 0) {
      return DateFormat('kk:mm').format(data);
    }
    return DateFormat('yyyy-MM-dd kk:mm').format(data);
  }
}
