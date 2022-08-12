import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// [WidgetModel] для [UiAppbar]
class UiAppbarWidgetModel extends WidgetModel {
  String? userName;
  BuildContext context;
  final NavigatorState _navigator;
  final EntityStreamedState<String?> usernameState =
      EntityStreamedState<String?>(null);
  final VoidCallback onLeading;

  UiAppbarWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this.context,
    this.onLeading,
  ) : super(dependencies);

  @override
  void onLoad() async {
    final prefs = await SharedPreferences.getInstance();

    userName = prefs.getString('username');
    usernameState.content(userName);
    print(userName);
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();
  }

  void clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('username');
    onLeading();
    Navigator.of(context).pop();
  }
}
