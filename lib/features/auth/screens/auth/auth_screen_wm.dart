import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/auth/exceptions/auth_exception.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import 'package:surf_practice_chat_flutter/features/auth/models/token_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat/chat_screen.dart';
import 'package:surf_practice_chat_flutter/features/topics/repository/chart_topics_repository.dart';
import 'package:surf_practice_chat_flutter/features/topics/screens/topics_list_screen/topics_list_screen.dart';
import 'package:surf_study_jam/surf_study_jam.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [WidgetModel] для [AuthScreen]
class AuthScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;
  final BuildContext context;
  final IAuthRepository authRepository;
  late StudyJamClient _studyJamClient;

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this.authRepository,
    this.context,
  ) : super(dependencies);

  @override
  void onLoad() async {
    super.onLoad();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      _studyJamClient =
          StudyJamClient().getAuthorizedClient(prefs.getString('token')!);
      _pushToTopics(TokenDto(token: prefs.getString('token')!));
    }
  }

  @override
  void onBind() {
    super.onBind();
  }

  void onButtonTap() async {
    try {
      _openLoadingDialog(context);
      String login = loginController.text;
      String password = passwordController.text;
      TokenDto token =
          await authRepository.signIn(login: login, password: password);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token.token);
      _studyJamClient = StudyJamClient().getAuthorizedClient(token.token);

      final localUser = await _studyJamClient.getUser();
      await prefs.setString('username', localUser?.username ?? 'Me');
      _navigator.pop();
      _pushToTopics(token);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        // TODO: добавить дизайн
        SnackBar(
          content: Text(e.message),
        ),
      );
      print(e);
      // TODO показать снэк
    }
  }

  void _pushToTopics(TokenDto token) {
    _navigator.push(
      MaterialPageRoute(
        builder: (_) {
          return TopicsListScreen(
            topicsRepository: ChatTopicsRepository(
              _studyJamClient,
            ),
            chatRepository: ChatRepository(
              _studyJamClient,
            ),
            authRepository: authRepository as AuthRepository,
          );
        },
      ),
    );
  }

  void _openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          content: Container(
            height: 100,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
