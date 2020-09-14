import 'dart:async';
import 'package:FlutterNews/pages/home/home_view.dart';
import 'package:FlutterNews/support/di/init_dependencies.dart';
import 'package:FlutterNews/support/localization/MyLocalizationsDelegate.dart';
import 'package:bsev/flavors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'support/di/init_dependencies.dart';
import 'package:FlutterNews/homescreen.dart';
import 'package:FlutterNews/support/notifications/firebase.dart';
import 'package:FlutterNews/support/util/colors.dart';

void main() => runApp(new NewsApp());

class NewsApp extends StatelessWidget {
  MyLocalizationsDelegate myLocation = const MyLocalizationsDelegate();
  NewsApp() {
    Flavors.configure(Flavor.PROD);
    initDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farnosť Veľký Šariš',
      theme: new ThemeData(
          primarySwatch: createMaterialColor(Color(0xff590111)),
          primaryColor: createMaterialColor(Color(0xff8c021c)),
          accentColor: createMaterialColor(Color(0xff260007)),
          brightness: Brightness.light,
          fontFamily: 'Georgia',
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
      ),
      supportedLocales: MyLocalizationsDelegate.supportedLocales(),
      localizationsDelegates: [
        myLocation,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: myLocation.resolution,
      //home: HomeView(),
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomeView()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset('assets/flutterlogo.jpg'),
                Text('Vitajte v aplikácii farnosti Veľký Šariš'),
              ]),
        ),
      ),
    );
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState() {
    super.initState();
    new FirebaseNotifications().setUpFirebase(context);
    startTime();
  }
}
