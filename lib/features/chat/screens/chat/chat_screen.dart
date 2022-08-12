import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat/widgets/chat_appbar.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat/widgets/chat_body.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat/widgets/chat_text_field.dart';
import 'di/chat_screen_wm_builder.dart';
import 'chat_screen_wm.dart';

/// Экран
class ChatScreen extends CoreMwwmWidget<ChatScreenWidgetModel> {
  ChatScreen({
    Key? key,
    required IChatRepository chatRepository,
  }) : super(
          key: key,
          widgetModelBuilder: (context) => createChatScreenWidgetModel(
            context,
            chatRepository,
          ),
        );

  _ChatScreenState createWidgetState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends WidgetState<ChatScreen, ChatScreenWidgetModel> {
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
            child: StreamedStateBuilder<EntityState<Iterable<ChatMessageDto>>>(
                streamedState: wm.currentMessages,
                builder: (
                  context,
                  snapshot,
                ) {
                  return ChatBody(
                    messages: wm.currentMessages.value.data ?? [],
                  );
                }),
          ),
          ChatTextField(onSendPressed: wm.onSendPressed),
        ],
      ),
    );
  }
}
