import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

/// Сообщение с изображениями
class ChatImageMessageDto extends ChatMessageDto {
  List<String> images = [];

  /// Constructor for [ChatMessageGeolocationDto].
  ChatImageMessageDto({
    required ChatUserDto chatUserDto,
    required String message,
    required DateTime createdDate,
    required this.images,
  }) : super(
          chatUserDto: chatUserDto,
          message: message,
          createdDateTime: createdDate,
        );

  /// Named constructor for converting DTO from [StudyJamClient].
  ChatImageMessageDto.fromSJClient({
    required SjMessageDto sjMessageDto,
    required SjUserDto sjUserDto,
    required bool isUserLocal,
  })  : images = sjMessageDto.images ?? [],
        super(
          createdDateTime: sjMessageDto.created,
          message: sjMessageDto.text,
          chatUserDto: ChatUserDto.fromSJClient(sjUserDto),
        );

  @override
  String toString() =>
      'ChatMessageImageDto(image: ) extends ${super.toString()}';
}
