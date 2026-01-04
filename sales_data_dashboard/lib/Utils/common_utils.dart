class CommonUtils {
  static String formatDate(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    final hour12 = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final hourStr = hour12.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$day-$month-$year $hourStr:$minute $period';
  }

  static String removeDay(String dateStr) {
    final date = DateTime.parse(dateStr);
    return "${date.year}-${date.month.toString().padLeft(2, '0')}";
  }
}
