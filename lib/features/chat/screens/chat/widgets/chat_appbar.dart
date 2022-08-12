import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  final VoidCallback onUpdatePressed;

  const ChatAppBar({
    required this.onUpdatePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onUpdatePressed,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}