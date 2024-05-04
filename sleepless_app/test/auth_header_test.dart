import 'package:test/test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    
    final mcApiKey = dotenv.env['MAILCHIMP_API_KEY'];
    final mcListId  = dotenv.env['MAILCHIMP_LIST_ID'];
    
    final url = Uri.https('us17.api.mailchimp.com', '/3.0/lists/${mcListId!}/members');

    final String basicAuth = 'Basic ${base64.encode(utf8.encode('anystring:$mcApiKey'))}';

    final response = await http.post(url,
        headers: <String, String>{'Authorization': basicAuth},
        body: '{"email_address":"test2@here.com","status":"subscribed"}'
    );

    // response 400 means that the email address already exists, which in this case, is what we're testing for
    expect(response.statusCode, 400);
  });
}