/*import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'package:FlutterNews/widgets/detail_page.dart';
import 'package:flutter/material.dart';

//Model class to represent the message return by FCM
class MessageBean {
  MessageBean({this.itemId});
  final String itemId;

  StreamController<MessageBean> _controller =
  StreamController<MessageBean>.broadcast();
  Stream<MessageBean> get onChanged => _controller.stream;

  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
          () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => DetailPage(itemId),
      ),
    );
  }
}*/