import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';

class ChatAvatar extends StatelessWidget {
  static const double _size = 42;

  final ChatUserDto userData;

  const ChatAvatar({
    required this.userData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: _size,
      height: _size,
      child: Material(
        // Используем хэш от каждого имени чтобы однозначно определить цвет
        color: Color(userData.name.hashCode),
        shape: const CircleBorder(),
        child: Center(
          child: Text(
            userData.name != null
                ? '${userData.name!.split(' ').first[0]}${userData.name!.split(' ').last != '' ? userData.name!.split(' ').last[0] : ""}'
                : '?',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}