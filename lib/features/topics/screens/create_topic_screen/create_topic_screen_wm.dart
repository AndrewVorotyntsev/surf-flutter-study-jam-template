import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_send_dto.dart';
import 'package:surf_practice_chat_flutter/features/topics/repository/chart_topics_repository.dart';

/// [WidgetModel] для [CreateTopicScreen]
class CreateTopicScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;
  final IChatTopicsRepository topicsRepository;

  final TextEditingController topicNameController = TextEditingController();
  final TextEditingController topicDescriptionController =
      TextEditingController();

  CreateTopicScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this.topicsRepository,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();
  }

  void onButtonTap() async {
    try {
      String topicName = topicNameController.text;
      String topicDescription = topicDescriptionController.text;
      await topicsRepository.createTopic(
        ChatTopicSendDto(
          name: topicName,
          description: topicDescription,
        ),
      );
      _navigator.pop();
    } on Exception catch (e) {
      print(e);
    }
  }
}
