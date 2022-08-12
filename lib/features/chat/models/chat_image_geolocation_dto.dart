import 'package:surf_practice_chat_flutter/features/chat/models/chat_geolocation_geolocation_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

/// Сообщение с изображениями и геолоакцией
class ChatImageGeoMessageDto extends ChatMessageDto {
  List<String> images = [];
  /// Location point.
  final ChatGeolocationDto location;

  /// Constructor for [ChatMessageGeolocationDto].
  ChatImageGeoMessageDto({
    required ChatUserDto chatUserDto,
    required String message,
    required DateTime createdDate,
    required this.images,
    required this.location,
  }) : super(
    chatUserDto: chatUserDto,
    message: message,
    createdDateTime: createdDate,
  );

  /// Named constructor for converting DTO from [StudyJamClient].
  ChatImageGeoMessageDto.fromSJClient({
    required SjMessageDto sjMessageDto,
    required SjUserDto sjUserDto,
    required bool isUserLocal,
  })  : images = sjMessageDto.images ?? [],
        location = ChatGeolocationDto.fromGeoPoint(sjMessageDto.geopoint!),
        super(
        createdDateTime: sjMessageDto.created,
        message: sjMessageDto.text,
        chatUserDto: ChatUserDto.fromSJClient(sjUserDto),
      );

  @override
  String toString() =>
      'ChatMessageImageDto(image: ) extends ${super.toString()}';
}