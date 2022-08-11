import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/auth/widgets/button.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/auth/widgets/input_field.dart';
import 'di/auth_screen_wm_builder.dart';
import 'auth_screen_wm.dart';

/// Экран
class AuthScreen extends CoreMwwmWidget<AuthScreenWidgetModel> {
  AuthScreen({
    Key? key,
    required IAuthRepository authRepository,
  }) : super(
          key: key,
          widgetModelBuilder: (context) => createAuthScreenWidgetModel(
            context,
            authRepository,
          ),
        );

  _AuthScreenState createWidgetState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends WidgetState<AuthScreen, AuthScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Авторизация',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        height: 56,
                        child: InputFieldWidget(
                          hintText: 'Логин',
                          controller: wm.loginController,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        height: 56,
                        child: InputFieldWidget(
                          hintText: 'Пароль',
                          controller: wm.passwordController,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ButtonWidget(
                        text: 'Далее',
                        color: Colors.green,
                        textColor: Colors.white,
                        onTap: wm.onButtonTap,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: ButtonWidget(
            //     text: 'Далее',
            //     color: Colors.green,
            //     textColor: Colors.white,
            //     onTap: wm.onButtonTap,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
