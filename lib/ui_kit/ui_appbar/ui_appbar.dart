import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'di/ui_appbar_wm_builder.dart';
import 'ui_appbar_wm.dart';

/// Экран
class UiAppbar extends CoreMwwmWidget<UiAppbarWidgetModel> {
  UiAppbar({
    Key? key,
    required VoidCallback onLeading,
    VoidCallback? onUpdate,
  }) : super(
          key: key,
          widgetModelBuilder: (context) => createUiAppbarWidgetModel(
            context,
            onLeading,
            onUpdate,
          ),
        );

  _UiAppbarState createWidgetState() {
    return _UiAppbarState();
  }
}

class _UiAppbarState extends WidgetState<UiAppbar, UiAppbarWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.door_front_door),
        onPressed: wm.clearToken,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EntityStateBuilder<String?>(
              streamedState: wm.usernameState,
              builder: (context, usernameData) {
                return Text(usernameData ?? 'Аноним');
              }),
          if (wm.onUpdate != null)
            IconButton(
              onPressed: wm.onUpdate,
              icon: const Icon(Icons.refresh),
            )
        ],
      ),
    );
  }
}
