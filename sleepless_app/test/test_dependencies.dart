import 'package:flutter/widgets.dart';
import 'package:sleepless_app/app_dependencies/app_dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

final class TestDependencies {
  final String test = 'test';

  AppDependencies buildAppDependencies() => AppDependencies(
        stub: 'test',
      );
}

extension WidgetTesterWithTestDependencies on WidgetTester {
  Future<TestDependencies> pumpWithTestDependencies(Widget widget) async {
    final testDependencies = TestDependencies();
    final appDependencies = testDependencies.buildAppDependencies();

    await pumpWidget(Provider(create: (_) => appDependencies, child: widget));

    return testDependencies;
  }
}
