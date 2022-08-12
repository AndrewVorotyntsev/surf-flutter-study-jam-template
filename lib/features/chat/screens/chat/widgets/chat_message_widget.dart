import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_location_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_local_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat/widgets/chat_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatMessage extends StatelessWidget {
  final ChatMessageDto chatData;

  const ChatMessage({
    required this.chatData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Bubble(
      margin: BubbleEdges.all(10),
      nip: chatData.chatUserDto is ChatUserLocalDto
          ? BubbleNip.rightBottom
          : BubbleNip.leftBottom,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChatAvatar(userData: chatData.chatUserDto),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    chatData.chatUserDto.name ?? 'Аноним',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(chatData.message ?? ''),
                ],
              ),
            ),
            chatData is ChatMessageGeolocationDto
                ? IconButton(
                    icon: Icon(Icons.pin_drop),
                    onPressed: () async {
                      ChatMessageGeolocationDto data =
                          chatData as ChatMessageGeolocationDto;
                      double lat = data.location.latitude;
                      double lon = data.location.longitude;

                      final url =
                          'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
