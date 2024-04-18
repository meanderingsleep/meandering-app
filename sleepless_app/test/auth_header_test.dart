import 'package:test/test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sleepless_app/utils.dart';

void main() {
  test('S3 bucket restricted', () async
  {
    await dotenv.load();

    final String uri = dotenv.env['URI']!;
    final Map<String, String> parts = bucketAndPathFromVirtualizedHostURL(uri);
    final String bucket = parts['bucket']!;
    final String path = parts['path']!;

    final url = Uri.https('$bucket.s3.amazonaws.com', path);
    final client = http.Client();
    final response = await client.head(url); // using HEAD request for testing
    expect(response.statusCode, 403);
  });

  test('S3 bucket authorization header', () async
  {
    await dotenv.load();

    final String uri = dotenv.env['URI']!;
    final Map<String, String> parts = bucketAndPathFromVirtualizedHostURL(uri);
    final String bucket = parts['bucket']!;
    final String path = parts['path']!;

    final requestHeaders = createAWSHTTPAuthHeaders(
        dotenv.env['AWS_ACCESS_KEY_ID']!,
        dotenv.env['AWS_SECRET_ACCESS_KEY']!,
        bucket,
        path,
        'HEAD'); // using HEAD request for testing

    final url = Uri.https('$bucket.s3.amazonaws.com', path);
    final client = http.Client();
    final response = await client.head(url, headers:requestHeaders); // using HEAD request for testing
    expect(response.statusCode, 200);
  });
}