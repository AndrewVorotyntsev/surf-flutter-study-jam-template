import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';
import '../chat_screen_wm.dart';

/// Билдер для [ChatScreenWidgetModel]
ChatScreenWidgetModel createChatScreenWidgetModel(
  BuildContext context,
  IChatRepository chatRepository,
  int? id, {
  NavigatorState? navigator,
}) {
  final wmDependencies = WidgetModelDependencies();

  navigator = navigator ?? Navigator.of(context);

  return ChatScreenWidgetModel(wmDependencies, navigator, chatRepository, id,context);
}
