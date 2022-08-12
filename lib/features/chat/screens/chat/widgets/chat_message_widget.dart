import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_image_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_location_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_local_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat/widgets/chat_avatar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:card_swiper/card_swiper.dart';

class ChatMessage extends StatelessWidget {
  final ChatMessageDto chatMessageData;

  const ChatMessage({
    required this.chatMessageData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Bubble(
      margin: BubbleEdges.all(10),
      nip: chatMessageData.chatUserDto is ChatUserLocalDto
          ? BubbleNip.rightBottom
          : BubbleNip.leftBottom,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChatAvatar(userData: chatMessageData.chatUserDto),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        chatMessageData.chatUserDto.name ?? 'Аноним',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(chatMessageData.message ?? ''),
                    ],
                  ),
                ),
                chatMessageData is ChatMessageGeolocationDto
                    ? IconButton(
                        icon: Icon(Icons.pin_drop),
                        onPressed: () async {
                          ChatMessageGeolocationDto data =
                              chatMessageData as ChatMessageGeolocationDto;
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
                    : SizedBox.shrink(),
              ],
            ),
            chatMessageData is ChatImageMessageDto
                ? Container(
                    height: 200,
                    child: Swiper(
                      loop: false,
                      itemCount: getImages(chatMessageData).length,
                      pagination: getImages(chatMessageData).length > 2
                          ? SwiperPagination()
                          : null,
                      itemBuilder: (_, i) {
                        return Container(
                          child: Image.network(
                            getImages(chatMessageData)[i],
                            errorBuilder: (_, __, ___) => Text('Изображение не загружено'),
                            // loadingBuilder: (_, __, ice) {
                            //   if (ice?.expectedTotalBytes != ice?.cumulativeBytesLoaded) {
                            //     return CupertinoActivityIndicator();
                            //   } else {
                            //     return null;
                            //   }
                            //
                            // },
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  List<String> getImages(ChatMessageDto data) {
    ChatImageMessageDto imageMessageDto = data as ChatImageMessageDto;
    return imageMessageDto.images;
  }
}
