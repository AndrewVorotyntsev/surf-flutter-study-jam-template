import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';

/// [WidgetModel] для [ChatScreen]
class ChatScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;
  final IChatRepository chatRepository;
  final nameEditingController = TextEditingController();
  final currentMessages =
  EntityStreamedState<Iterable<ChatMessageDto>>(const EntityState.loading([]));

  ChatScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this.chatRepository,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();
  }

  Future<void> onUpdatePressed() async {
    final messages = await chatRepository.getMessages();
    currentMessages.content(messages);
    // setState
    //_currentMessages = messages;
  }

  Future<void> onSendPressed(String messageText) async {
    final messages = await chatRepository.sendMessage(messageText);
    currentMessages.content(messages);
    // setState
    //_currentMessages = messages;
  }
}
