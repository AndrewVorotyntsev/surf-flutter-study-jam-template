import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  final ValueChanged<String> onSendPressed;
  final VoidCallback onImageButtonTap;

  final _textEditingController = TextEditingController();

  ChatTextField({
    required this.onSendPressed,
    required this.onImageButtonTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: mediaQuery.padding.bottom + 8,
          left: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Сообщение',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.image),
              color: colorScheme.onSurface,
              onPressed: onImageButtonTap,
            ),
            IconButton(
              onPressed: () => onSendPressed(_textEditingController.text),
              icon: const Icon(Icons.send),
              color: colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
