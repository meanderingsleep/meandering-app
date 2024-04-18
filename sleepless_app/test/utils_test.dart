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

  test('Test correct days of week', ()
  {
     expect(getDayOfWeekString(DateTime(2024, 1, 1)), 'Monday');
     expect(getDayOfWeekString(DateTime(2024, 1, 2)), 'Tuesday');
     expect(getDayOfWeekString(DateTime(2024, 1, 3)), 'Wednesday');
     expect(getDayOfWeekString(DateTime(2024, 1, 4)), 'Thursday');
     expect(getDayOfWeekString(DateTime(2024, 1, 5)), 'Friday');
     expect(getDayOfWeekString(DateTime(2024, 1, 6)), 'Saturday');
     expect(getDayOfWeekString(DateTime(2024, 1, 7)), 'Sunday');

  });
}