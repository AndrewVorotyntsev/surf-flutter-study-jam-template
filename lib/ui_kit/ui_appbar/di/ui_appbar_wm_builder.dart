import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import '../ui_appbar_wm.dart';

/// Билдер для [UiAppbarWidgetModel]
UiAppbarWidgetModel createUiAppbarWidgetModel(
  BuildContext context, {
  NavigatorState? navigator,
}) {
  final wmDependencies = WidgetModelDependencies(
  );

  navigator = navigator ?? Navigator.of(context);

  return UiAppbarWidgetModel(
    wmDependencies,
    navigator,
  );
}
