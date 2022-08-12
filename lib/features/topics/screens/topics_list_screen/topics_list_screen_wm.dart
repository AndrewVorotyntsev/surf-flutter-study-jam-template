import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat/chat_screen.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_dto.dart';
import 'package:surf_practice_chat_flutter/features/topics/repository/chart_topics_repository.dart';
import 'package:surf_practice_chat_flutter/features/topics/screens/create_topic_screen/create_topic_screen.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

/// [WidgetModel] для [TopicsListScreen]
class TopicsListScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;
  final IChatTopicsRepository topicsRepository;
  final ChatRepository chatRepository;
  final AuthRepository authRepository;
  final currentTopics = EntityStreamedState<Iterable<ChatTopicDto>>(
      const EntityState.loading([]));

  TopicsListScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this.topicsRepository,
    this.chatRepository,
      this.authRepository,
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
        topicsStartDate: DateTime(2022, 8, 10)); // as List<ChatTopicDto>;
    print(topics);
    currentTopics.content(topics);
  }

  void pushToCreateTopic() {
    _navigator.push(
      MaterialPageRoute(
        builder: (_) {
          return CreateTopicScreen(
            topicsRepository: topicsRepository,
          );
        },
      ),
    );
  }

  void pushToChat(int? id) {
    _navigator.push(
      MaterialPageRoute(
        builder: (_) {
          return ChatScreen(
            chatRepository: chatRepository,
            id: id,
          );
        },
      ),
    );
  }

  void signOut() {
    authRepository.signOut();
  }
}
