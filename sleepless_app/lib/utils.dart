import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String getDayOfWeekString(DateTime now) {
  final int dayOfWeek = now.weekday;
  final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  return days[dayOfWeek - 1];  // Subtract 1 to match the index
}


Future<http.Response> saveEmail(String email) async {
  await dotenv.load();
  final mc_api_key = dotenv.env['MAILCHIMP_API_KEY'];
  final mc_list_id  = dotenv.env['MAILCHIMP_LIST_ID'];

  final url = Uri.https('us17.api.mailchimp.com', '/3.0/lists/${mc_list_id!}/members');
  final String basicAuth = 'Basic ${base64.encode(utf8.encode('anystring:$mc_api_key'))}';

  return await http.post(url,
      headers: <String, String>{'Authorization': basicAuth},
      body: '{"email_address":"$email","status":"subscribed"}'
  );
}