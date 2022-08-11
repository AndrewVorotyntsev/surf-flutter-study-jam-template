import 'package:flutter/material.dart';

/// Кнопка, которая растягивается на всю ширину
class ButtonWidget extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Icon? icon;
  final Color? color;
  final void Function()? onTap;

  const ButtonWidget({
    required this.text,
    this.textColor,
    this.icon,
    this.color,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(16),
      color: color ?? Theme.of(context).scaffoldBackgroundColor,
      shadowColor: const Color.fromARGB(100, 0, 0, 0),
      child: SizedBox(
        height: 56,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TODO: заменить на иконку из дизайна, когда появится
              if (icon != null) icon!,
              const SizedBox(
                width: 16,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}