import 'package:sleepless_app/utils.dart';
import 'package:test/test.dart';

void main() {
  test('Test bucket and path extraction from a URL', ()
  {
    final Map<String, String> components = bucketAndPathFromVirtualizedHostURL(
      'http://something.region.here.com/another_something.mp3'
    );
    expect(components['bucket'], 'something');
    expect(components['path'], 'another_something.mp3');
  });
}