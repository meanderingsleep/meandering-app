import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

Map<String, String> createAWSHTTPAuthHeaders(String key, String secret, String bucket, String path, String method) {
  final now = DateTime.now().toUtc();
  String formattedDate = DateFormat('E, d MMM yyyy HH:mm:ss').format(now) + " +0000";
  String stringToSign = "$method\n\n\n$formattedDate\n/$bucket/$path";
  var bytes = utf8.encode(stringToSign);

  var hmacSha256 = Hmac(sha1, utf8.encode(secret));
  String signature = base64.encode(hmacSha256.convert(bytes).bytes);
  String authorization = 'AWS ' + key +':$signature';

  Map<String, String> requestHeaders = {
    'Date': formattedDate,
    'Authorization': authorization,
  };
  return requestHeaders;
}

void main() {
  test('Test AWS s3 authorization required access', () async
  {
    await dotenv.load();

    String s3Uri = dotenv.env['S3_URI']!; // URI of format s3://bucket_name/object
    var parts = s3Uri.split('/');
    String bucket = parts[2];
    String path = parts[3];
    var domain = '$bucket.s3.amazonaws.com';

    var requestHeaders = createAWSHTTPAuthHeaders(
        dotenv.env['AWS_ACCESS_KEY_ID']!,
        dotenv.env['AWS_SECRET_ACCESS_KEY']!,
        bucket,
        path,
        'HEAD'); // using HEAD request for testing

    var url = Uri.https(domain, path);
    var client = http.Client();
    var response = await client.head(url, headers:requestHeaders); // using HEAD request for testing
    expect(response.statusCode, 200);
  });
}