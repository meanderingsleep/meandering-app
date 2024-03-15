import 'package:flutter/widgets.dart' as widgets;
import 'package:provider/provider.dart';

final class AppDependencies {
  final String stub;

  AppDependencies({required this.stub});
}

extension AppDependenciesGetter on widgets.BuildContext {
  AppDependencies appDependencies() => Provider.of<AppDependencies>(this, listen: false);
}
