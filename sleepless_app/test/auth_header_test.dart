import 'package:test/test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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
}