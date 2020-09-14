import 'package:FlutterNews/support/util/StringsLocation.dart';
import 'package:FlutterNews/widgets/message_bean.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:FlutterNews/support/util/colors.dart';
import 'package:FlutterNews/support/notifications/firebase.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> with TickerProviderStateMixin {

  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 500)
    );

    CurvedAnimation curve = CurvedAnimation(
        parent: animationController, curve: Curves.decelerate);
    animation = Tween(begin: 0.0, end: 1.0).animate(curve);

    super.initState();
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    new FirebaseNotifications().setUpFirebase(context);
    return new ScaleTransition(
      scale: animation,
      child: new Container(
        margin: new EdgeInsets.all(30.0),
        child: new Center(
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _getTittle(),
              _getContent(getString("text_info")),
              _getContentSecond("web farnosti", "farnostvelkysaris.sk",
                  "https://farnostvelkysaris.sk"),
              _getContentSecond("e-mail", "fara.vsaris@gmail.com",
                  "mailto:fara.vsaris@gmail.com"),
              _getContent(getString("phone_info")),
              _getContentSecond(
                  "CMS Westo", "westo.sk", "http://promo.westo.sk/"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTittle() {
    return Center(
      child: new Text("Farnosť Veľký Šariš",
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: createMaterialColor(Color(0xFF590111)),
            fontSize: 25.0),
      ),
    );
  }

  Widget _getContent(String text) {
    return new Container(
      margin: new EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: new Text(text,
        textAlign: TextAlign.center,
        style: new TextStyle( fontSize: 20.0),
      ),
    );
  }

  Widget _getContentSecond(tittle, tittleLink, link) {
    return new Container(
      margin: new EdgeInsets.only(top: 10.0),
      child: new Column(
        children: <Widget>[
          new Text(tittle),
          new GestureDetector(
            child: new Text(
              tittleLink,
              style: new TextStyle(color: createMaterialColor(Color(0xFF8c021c))),
            ),
            onTap: () {
              _launchURL(link);
            },
          )
        ],
      ),
    );
  }

  _launchURL(url) async {
    await launch(url);
  }

  }