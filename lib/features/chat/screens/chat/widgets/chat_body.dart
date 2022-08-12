import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat/widgets/chat_message_widget.dart';

class ChatBody extends StatelessWidget {
  final Iterable<ChatMessageDto> messages;

  const ChatBody({
    required this.messages,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (_, index) => ChatMessage(
        chatMessageData: messages.elementAt(index),
      ),
    );
  }
}