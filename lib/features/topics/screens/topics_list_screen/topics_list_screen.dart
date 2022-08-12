import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat/widgets/chat_appbar.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_dto.dart';
import 'package:surf_practice_chat_flutter/features/topics/repository/chart_topics_repository.dart';
import 'package:surf_practice_chat_flutter/ui_kit/ui_appbar/ui_appbar.dart';
import 'di/topics_list_screen_wm_builder.dart';
import 'topics_list_screen_wm.dart';

/// Экран
class TopicsListScreen extends CoreMwwmWidget<TopicsListScreenWidgetModel> {
  TopicsListScreen({
    Key? key,
    required IChatTopicsRepository topicsRepository,
    required ChatRepository chatRepository,
    required AuthRepository authRepository,
  }) : super(
          key: key,
          widgetModelBuilder: (context) => createTopicsListScreenWidgetModel(
            context,
            topicsRepository,
            chatRepository,
            authRepository,
          ),
        );

  _TopicsListScreenState createWidgetState() {
    return _TopicsListScreenState();
  }
}

class _TopicsListScreenState
    extends WidgetState<TopicsListScreen, TopicsListScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: UiAppbar(onLeading: wm.signOut,),
        // child: ChatAppBar(
        //   onUpdatePressed: wm.onUpdatePressed,
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: wm.pushToCreateTopic,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StreamedStateBuilder<EntityState<Iterable<ChatTopicDto>>>(
                streamedState: wm.currentTopics,
                builder: (
                  context,
                  snapshot,
                ) {
                  return ListView.separated(
                    separatorBuilder: (_, __) {
                      return Divider();
                    },
                    itemCount: wm.currentTopics.value.data?.length ?? 0,
                    itemBuilder: (_, index) => ListTile(
                      title: Text(
                          '${wm.currentTopics.value.data?.elementAt(index).name}'),
                      subtitle: wm.currentTopics.value.data
                                  ?.elementAt(index)
                                  .description !=
                              null
                          ? Text(
                              '${wm.currentTopics.value.data?.elementAt(index).description}')
                          : null,
                      onTap: () => wm.pushToChat(
                          wm.currentTopics.value.data?.elementAt(index).id),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
