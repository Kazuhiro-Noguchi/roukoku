String japaneseEra(DateTime dt) {
  final y = dt.year;
  if (y >= 2019) {
    final eraYear = y - 2018;
    return '（令和$eraYear年）';
  } else if (y >= 1989) {
    final eraYear = y - 1988;
    return '（平成$eraYear年）';
  } else {
    final eraYear = y - 1925;
    return '（昭和$eraYear年）';
  }
}

String timeString(DateTime t) =>
    '${_two(t.hour)}:${_two(t.minute)}:${_two(t.second)}';

String _two(int n) => n.toString().padLeft(2, '0');

String weekdayJp(int w) {
  const list = ['月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日', '日曜日'];
  return list[w - 1];
}
