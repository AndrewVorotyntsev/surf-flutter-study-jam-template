import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';

/// [WidgetModel] для [ChatScreen]
class ChatScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;
  final IChatRepository chatRepository;
  final nameEditingController = TextEditingController();
  final currentMessages = EntityStreamedState<Iterable<ChatMessageDto>>(
      const EntityState.loading([]));

  int? id;

  ChatScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this.chatRepository,
    this.id,
  ) : super(dependencies);

  @override
  void onLoad() {
    // Обновляем сообщения при запуске экранов
    onUpdatePressed();
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();
  }

  Future<void> onUpdatePressed() async {
    final messages = await chatRepository.getMessages(id: id);
    currentMessages.content(messages);
  }

  Future<void> onSendPressed(String messageText) async {
    final messages = await chatRepository.sendMessage(messageText, id: id);
    currentMessages.content(messages);
  }
}
