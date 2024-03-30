import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Test AWS authorization required access', () async
  {
    await dotenv.load();

    var bucket = 'sleepless-boulder-co';
    var domain = '$bucket.s3.amazonaws.com';
    var path = 'sleepless-2024-02-24.mp3';

    final now = DateTime.now().toUtc();
    String formattedDate = DateFormat('E, d MMM yyyy HH:mm:ss').format(now) + " +0000";
    String stringToSign = "HEAD\n\n\n$formattedDate\n/$bucket/$path";

    var hmacSha256 = Hmac(sha1, utf8.encode(dotenv.env['AWS_SECRET_ACCESS_KEY']!));

    var bytes = utf8.encode(stringToSign); // data being hashed

    String signature = base64.encode(hmacSha256.convert(bytes).bytes);
    var authorization = 'AWS ' + dotenv.env['AWS_ACCESS_KEY_ID']! +':$signature';

    Map<String, String> requestHeaders = {
      'Date': formattedDate,
      'Authorization': authorization,
    };

    var url = Uri.https(domain, path);
    var client = http.Client();
    var response = await client.head(url, headers:requestHeaders);
    expect(response.statusCode, 200);
  });
}