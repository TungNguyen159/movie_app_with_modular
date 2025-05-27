import 'package:movie_app2/models/showtime.dart';

class ShowtimeHelper {
  static DateTime getShowEndTime(Showtime show) {
    final timeParts = show.endtime.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    final second = timeParts.length > 2 ? int.parse(timeParts[2]) : 0;

    return DateTime(
      show.date.year,
      show.date.month,
      show.date.day,
      hour,
      minute,
      second,
    );
  }

  static DateTime getShowStartTime(Showtime show) {
    final timeParts = show.starttime.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    final second = timeParts.length > 2 ? int.parse(timeParts[2]) : 0;

    return DateTime(
      show.date.year,
      show.date.month,
      show.date.day,
      hour,
      minute,
      second,
    );
  }
}
