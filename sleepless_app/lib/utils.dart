String getDayOfWeekString(DateTime now) {
  int dayOfWeek = now.weekday;
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  return days[dayOfWeek - 1];  // Subtract 1 to match the index
}