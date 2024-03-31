import 'package:test/test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sleepless_app/utils.dart';

void main() {
  test('Test AWS s3 authorization required access', () async
  {
    await dotenv.load();

    String uri = dotenv.env['URI']!;
    Map<String, String> parts = bucketAndPathFromUrl(uri);
    String bucket = parts['bucket']!;
    String path = parts['path']!;

    var requestHeaders = createAWSHTTPAuthHeaders(
        dotenv.env['AWS_ACCESS_KEY_ID']!,
        dotenv.env['AWS_SECRET_ACCESS_KEY']!,
        bucket,
        path,
        'HEAD'); // using HEAD request for testing

    var url = Uri.https('$bucket.s3.amazonaws.com', path);
    var client = http.Client();
    var response = await client.head(url, headers:requestHeaders); // using HEAD request for testing
    expect(response.statusCode, 200);
  });
}