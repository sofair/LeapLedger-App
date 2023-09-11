DateTime dateTimeFromJson(dynamic timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(
      timestamp != null ? timestamp * 1000 + 28800000 : 0);
}

int dateTimeToJson(DateTime? dateTime) {
  return dateTime != null ? dateTime.millisecondsSinceEpoch ~/ 1000 - 28800 : 0;
}
