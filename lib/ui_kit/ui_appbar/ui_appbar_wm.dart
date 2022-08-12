import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// [WidgetModel] для [UiAppbar]
class UiAppbarWidgetModel extends WidgetModel {
  String? userName;
  final NavigatorState _navigator;
  final EntityStreamedState<String?> usernameState =
      EntityStreamedState<String?>(null);

  UiAppbarWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
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
}
