import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  final VoidCallback? onUpdatePressed;

  const ChatAppBar({
    this.onUpdatePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (onUpdatePressed != null)
            IconButton(
              onPressed: onUpdatePressed,
              icon: const Icon(Icons.refresh),
            )
          // onUpdatePressed != null ? IconButton(
          //   onPressed: onUpdatePressed,
          //   icon: const Icon(Icons.refresh),
          // ) : null,
        ],
      ),
    );
  }
}
