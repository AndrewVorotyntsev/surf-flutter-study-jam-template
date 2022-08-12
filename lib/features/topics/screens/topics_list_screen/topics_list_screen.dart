import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat/widgets/chat_appbar.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_dto.dart';
import 'package:surf_practice_chat_flutter/features/topics/repository/chart_topics_repository.dart';
import 'di/topics_list_screen_wm_builder.dart';
import 'topics_list_screen_wm.dart';

/// Экран
class TopicsListScreen extends CoreMwwmWidget<TopicsListScreenWidgetModel> {
  TopicsListScreen({
    Key? key,
    required IChatTopicsRepository topicsRepository,
  }) : super(
          key: key,
          widgetModelBuilder: (context) => createTopicsListScreenWidgetModel(
            context,
            topicsRepository,
          ),
        );
  //   WidgetModelBuilder<TopicsListScreenWidgetModel> widgetModelBuilder =
  //       createTopicsListScreenWidgetModel,
  // }) : super(
  //         key: key,
  //         widgetModelBuilder: widgetModelBuilder,
  //       );

  _TopicsListScreenState createWidgetState() {
    return _TopicsListScreenState();
  }
}

class _TopicsListScreenState
    extends WidgetState<TopicsListScreen, TopicsListScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: ChatAppBar(
          onUpdatePressed: wm.onUpdatePressed,
        ),
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
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
