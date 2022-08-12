import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_dto.dart';
import 'package:surf_practice_chat_flutter/features/topics/repository/chart_topics_repository.dart';

/// [WidgetModel] для [TopicsListScreen]
class TopicsListScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;
  final IChatTopicsRepository topicsRepository;
  final currentTopics =
      EntityStreamedState<Iterable<ChatTopicDto>>(const EntityState.loading([]));

  TopicsListScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this.topicsRepository,
  ) : super(dependencies);

  @override
  void onLoad() {
    onUpdatePressed();
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();
  }

  Future<void> onUpdatePressed() async {
    final topics = await topicsRepository.getTopics(
        topicsStartDate: DateTime(2022, 8, 10));// as List<ChatTopicDto>;
    print(topics);
    currentTopics.content(topics);
  }


}
