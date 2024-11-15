import 'package:http/http.dart' as http;

String getDayOfWeekString(DateTime now) {
  final int dayOfWeek = now.weekday;
  final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  return days[dayOfWeek - 1];  // Subtract 1 to match the index
}

Future<http.Response> saveEmail(String email) async {
  final url = Uri.https('coventrylabs.net', '/email-subscribe');
  final headers = <String, String> {'Content-Type': 'application/json'};
  return await http.post(url,
      headers: headers,
      body: '{"email": "$email"}');
}