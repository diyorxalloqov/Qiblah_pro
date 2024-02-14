DateTime findStartOfWeek(DateTime date, {int startingDay = DateTime.monday}) {
  int daysUntilStartOfWeek = (date.weekday - startingDay + 7) % 7;
  return date.subtract(Duration(days: daysUntilStartOfWeek));
}

DateTime findEndOfWeek(DateTime date, {int startingDay = DateTime.monday}) {
  int daysUntilEndOfWeek = (6 + startingDay - date.weekday + 7) % 7;
  return date.add(Duration(days: daysUntilEndOfWeek));
}

extension FormattedCountdown on Duration {
  String getFormattedCountdown() {
    int hours = inHours;
    int minutes = inMinutes % 60;
    int seconds = inSeconds % 60;

    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String getFormattedCountdownHour() {
    int hours = inHours;
    // if (hours > 0) {
    //   return '$hours:';
    // }

    // return '';
    return "$hours";
  }

  String getFormattedCountdownMinute() {
    int minutes = inMinutes % 60;

    return minutes.toString().padLeft(2, '0');
  }
}
