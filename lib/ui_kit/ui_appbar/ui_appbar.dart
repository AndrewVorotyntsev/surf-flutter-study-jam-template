import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'di/ui_appbar_wm_builder.dart';
import 'ui_appbar_wm.dart';

/// Экран
class UiAppbar extends CoreMwwmWidget<UiAppbarWidgetModel> {
  UiAppbar({
    Key? key,
    WidgetModelBuilder<UiAppbarWidgetModel> widgetModelBuilder =
        createUiAppbarWidgetModel,
  }) : super(
          key: key,
          widgetModelBuilder: widgetModelBuilder,
        );

  _UiAppbarState createWidgetState() {
    return _UiAppbarState();
  }
}

class _UiAppbarState extends WidgetState<UiAppbar, UiAppbarWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EntityStateBuilder<String?>(
              streamedState: wm.usernameState,
              builder: (context, usernameData) {
                return Text(usernameData ?? 'Аноним');
              }),
          // if (onUpdatePressed != null)
          //   IconButton(
          //     onPressed: onUpdatePressed,
          //     icon: const Icon(Icons.refresh),
          //   )
          // onUpdatePressed != null ? IconButton(
          //   onPressed: onUpdatePressed,
          //   icon: const Icon(Icons.refresh),
          // ) : null,
        ],
      ),
    );
  }
}
