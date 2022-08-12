import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/auth/widgets/button.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/auth/widgets/input_field.dart';
import 'package:surf_practice_chat_flutter/features/topics/repository/chart_topics_repository.dart';
import 'di/create_topic_screen_wm_builder.dart';
import 'create_topic_screen_wm.dart';

/// Экран
/// Screen, that is used for creating new chat topics.
class CreateTopicScreen extends CoreMwwmWidget<CreateTopicScreenWidgetModel> {
  CreateTopicScreen({
    Key? key,
    required IChatTopicsRepository topicsRepository,
  }) : super(
    key: key,
    widgetModelBuilder: (context) => createCreateTopicScreenWidgetModel(
      context,
      topicsRepository,
    ),
  );

  _CreateTopicScreenState createWidgetState() {
    return _CreateTopicScreenState();
  }
}

class _CreateTopicScreenState extends WidgetState<CreateTopicScreen, CreateTopicScreenWidgetModel> {
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
                          controller: wm.topicNameController,
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
                          controller: wm.topicDescriptionController,
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
          ],
        ),
      ),
    );
  }
}
