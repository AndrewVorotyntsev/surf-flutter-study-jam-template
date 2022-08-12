import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/auth/widgets/input_field.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_geolocation_geolocation_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';
import 'package:geolocator/geolocator.dart';

/// [WidgetModel] для [ChatScreen]
class ChatScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;
  final IChatRepository chatRepository;
  final BuildContext context;

  final nameEditingController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  List<String> imagesToSend = [];
  ChatGeolocationDto? geolocation;

  final currentMessages = EntityStreamedState<Iterable<ChatMessageDto>>(
      const EntityState.loading([]));

  int? id;

  ChatScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this.chatRepository,
    this.id,
    this.context,
  ) : super(dependencies);

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
    if (geolocation == null) {
      final messages = await chatRepository.sendMessage(
        messageText,
        id: id,
        images: imagesToSend,
      );
      currentMessages.content(messages);
    } else {
      geolocation;
      final messages = await chatRepository.sendGeolocationMessage(
        location: geolocation!,
        // ChatGeolocationDto(
        //   longitude: 0,
        //   latitude: 0,
        // ), //geolocation!,
        id: id,
        message: messageText,
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
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
  }

  void pinGeo() async {
    Position position = await _determinePosition();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Прикрепить геолокацию?'),
          content: Text('${position.longitude}, ${position.latitude}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Да'),
              onPressed: () {
                geolocation = ChatGeolocationDto(
                  longitude: position.longitude,
                  latitude: position.latitude,
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
