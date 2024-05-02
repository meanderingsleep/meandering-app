import 'package:test/test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void main() {
  test('S3 bucket accessible', () async
  {
    await dotenv.load();

    final String bucket = dotenv.env['S3_BUCKET']!;

    final url = Uri.https('$bucket.s3.amazonaws.com', 'test.txt');
    final client = http.Client();
    final response = await client.head(url); // using HEAD request for testing
    expect(response.statusCode, 200);
  });

  test('mailchimp access', () async
  {
    await dotenv.load();
    
    final mc_api_key = dotenv.env['MAILCHIMP_API_KEY'];
    final mc_list_id  = dotenv.env['MAILCHIMP_LIST_ID'];
    
    final url = Uri.https('us17.api.mailchimp.com', '/3.0/lists/' + mc_list_id! + '/members');
    final client = http.Client();

    final String basicAuth = 'Basic ' + base64.encode(utf8.encode('anystring:$mc_api_key'));

    final response = await http.get(url, headers: <String, String>{'Authorization': basicAuth});
    expect(response.statusCode, 200);


  });
}