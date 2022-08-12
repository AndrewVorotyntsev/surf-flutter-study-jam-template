import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/auth/widgets/input_field.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';

/// [WidgetModel] для [ChatScreen]
class ChatScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;
  final IChatRepository chatRepository;
  final BuildContext context;

  final nameEditingController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  List<String> imagesToSend = [];

  final currentMessages = EntityStreamedState<Iterable<ChatMessageDto>>(
      const EntityState.loading([]));

  int? id;

  ChatScreenWidgetModel(WidgetModelDependencies dependencies,
      this._navigator,
      this.chatRepository,
      this.id,
      this.context,) : super(dependencies);

  @override
  void onLoad() {
    // Обновляем сообщения при запуске экранов
    onUpdatePressed();
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();
  }

  Future<void> onUpdatePressed() async {
    final messages = await chatRepository.getMessages(id: id);
    currentMessages.content(messages);
  }

  Future<void> onSendPressed(String messageText) async {
    if (imagesToSend.isNotEmpty) {
      final messages = await chatRepository.sendMessage(
        messageText,
        id: id,
        images: imagesToSend,
      );
      currentMessages.content(messages);
    }
  }

  void chooseImages() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Введите ссылку на изображение'),
          content: InputFieldWidget(
            hintText: 'Url',
            controller: imageController,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Прикрепить'),
              onPressed: () {
                imagesToSend.add(imageController.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Введите ссылку на фото'),
                InputFieldWidget(
                  hintText: 'Url',
                  controller: imageController,
                ),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () {
                    imagesToSend.add(imageController.text);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
    print(imagesToSend);
    //imagesToSend.add(imageController.text);
  }
}