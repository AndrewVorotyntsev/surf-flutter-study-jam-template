import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import '../auth_screen_wm.dart';

/// Билдер для [AuthScreenWidgetModel]
AuthScreenWidgetModel createAuthScreenWidgetModel(
  BuildContext context,
  IAuthRepository repository, {
  NavigatorState? navigator,
}) {
  final wmDependencies = WidgetModelDependencies();

  navigator = navigator ?? Navigator.of(context);

  return AuthScreenWidgetModel(
    wmDependencies,
    navigator,
    repository,
    context
  );
}
