enum StarSign {
  //白羊座, 3月21日-4月20日
  aries(monthTimeRange: MonthTimeRange(MonthTime(3, 21), MonthTime(4, 20))),
  //金牛座, 4月21-5月21日
  taurus(monthTimeRange: MonthTimeRange(MonthTime(4, 21), MonthTime(5, 21))),
  //双子座, 5月22日-6月21日
  gemini(monthTimeRange: MonthTimeRange(MonthTime(5, 22), MonthTime(6, 21))),
  //巨蟹座, 6月22日-7月22日
  cancer(monthTimeRange: MonthTimeRange(MonthTime(6, 22), MonthTime(7, 22))),
  //狮子座, 7月23日-8月23日
  leo(monthTimeRange: MonthTimeRange(MonthTime(7, 23), MonthTime(8, 23))),
  //处女座, 8月24日-9月23日
  virgo(monthTimeRange: MonthTimeRange(MonthTime(8, 24), MonthTime(9, 23))),
  //天秤座, 9月24日-10月23日
  libra(monthTimeRange: MonthTimeRange(MonthTime(9, 24), MonthTime(10, 23))),
  //天蝎座, 10月24日-11月22日
  scorpio(monthTimeRange: MonthTimeRange(MonthTime(10, 24), MonthTime(11, 22))),
  //射手座, 11月23日-12月21日
  sagittarius(
      monthTimeRange: MonthTimeRange(MonthTime(11, 23), MonthTime(12, 21))),
  //摩羯座, 12月22日-1月20日
  capricorn(
      monthTimeRange: MonthTimeRange(MonthTime(12, 22), MonthTime(1, 20))),
  //水瓶座, 1月21日-2月19日
  aquarius(monthTimeRange: MonthTimeRange(MonthTime(1, 21), MonthTime(2, 19))),
  //双鱼座, 2月20日-3月20日
  pisces(monthTimeRange: MonthTimeRange(MonthTime(2, 20), MonthTime(3, 20))),
  ;

  final MonthTimeRange monthTimeRange;

  const StarSign({required this.monthTimeRange});

  static StarSign? from(String? displayName) {
    if (displayName == null) return null;
    if (displayName.contains("白羊")) return aries;
    if (displayName.contains("金牛")) return taurus;
    if (displayName.contains("双子")) return gemini;
    if (displayName.contains("巨蟹")) return cancer;
    if (displayName.contains("狮子")) return leo;
    if (displayName.contains("处女")) return virgo;
    if (displayName.contains("天秤")) return libra;
    if (displayName.contains("天蝎")) return scorpio;
    if (displayName.contains("射手")) return sagittarius;
    if (displayName.contains("摩羯")) return capricorn;
    if (displayName.contains("水瓶")) return aquarius;
    if (displayName.contains("双鱼")) return pisces;
    return null;
  }
}

class MonthTime {
  final int month;
  final int day;

  const MonthTime(this.month, this.day);

  bool isAfter(MonthTime other) {
    if (month > other.month) return true;
    if (month == other.month && day > other.day) return true;
    return false;
  }

  static String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  @override
  String toString() => "${_twoDigits(month)}.${_twoDigits(day)}";
}

class MonthTimeRange {
  final MonthTime start;
  final MonthTime end;

  const MonthTimeRange(this.start, this.end);

  bool isAfter(MonthTime other) {
    return start.isAfter(other);
  }

  bool isBefore(MonthTime other) {
    return other.isAfter(end);
  }

  @override
  String toString() => "$start - $end";
}
