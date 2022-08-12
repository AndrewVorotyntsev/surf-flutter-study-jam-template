import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/topics/repository/chart_topics_repository.dart';
import '../topics_list_screen_wm.dart';

/// Билдер для [TopicsListScreenWidgetModel]
TopicsListScreenWidgetModel createTopicsListScreenWidgetModel(
  BuildContext context,
  IChatTopicsRepository topicsRepository, {
  NavigatorState? navigator,
}) {
  final wmDependencies = WidgetModelDependencies();

  navigator = navigator ?? Navigator.of(context);

  return TopicsListScreenWidgetModel(
    wmDependencies,
    navigator,
      topicsRepository
  );
}
