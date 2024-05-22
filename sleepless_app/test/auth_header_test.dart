import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('S3 bucket accessible', () async
  {
    final url = Uri.https('net-coventry-audio.s3.amazonaws.com', 'Monday_classic_male.mp3');
    final client = http.Client();
    final response = await client.head(url); // using HEAD request for testing
    expect(response.statusCode, 200);
  });

  test('email post', () async
  {
    final url = Uri.https('coventrylabs.net', '/email-subscribe');

    final headers = <String, String> {'Content-Type': 'application/json'};
    var response = await http.post(url,
        headers: headers,
        body: '{"email":"malformedEmail@"}');
    expect(response.statusCode, 400);

    response = await http.post(url,
        headers: headers,
        body: '{"email":"jvaleski@gmail.com"}');
    expect(response.statusCode, 500); // 500 is the response we get if they're already subscribed
  });

}