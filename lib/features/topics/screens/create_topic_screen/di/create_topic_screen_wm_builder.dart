import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/topics/repository/chart_topics_repository.dart';
import '../create_topic_screen_wm.dart';

/// Билдер для [CreateTopicScreenWidgetModel]
CreateTopicScreenWidgetModel createCreateTopicScreenWidgetModel(
  BuildContext context,
  IChatTopicsRepository topicsRepository, {
  NavigatorState? navigator,
}) {
  final wmDependencies = WidgetModelDependencies();

  navigator = navigator ?? Navigator.of(context);

  return CreateTopicScreenWidgetModel(
    wmDependencies,
    navigator,
    topicsRepository,
  );
}
