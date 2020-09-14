import 'package:FlutterNews/pages/featured/featured_view.dart';
import 'package:FlutterNews/pages/home/home_bloc.dart';
import 'package:FlutterNews/pages/home/home_streams.dart';
import 'package:FlutterNews/pages/info/info.dart';
import 'package:FlutterNews/pages/news/news_view.dart';
import 'package:FlutterNews/widgets/bottom_navigation.dart';
import 'package:FlutterNews/widgets/search.dart';
import 'package:bsev/bsev.dart';
import 'package:flutter/material.dart';
import 'package:FlutterNews/support/notifications/firebase.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    new FirebaseNotifications().setUpFirebase(context);
    return Bsev<HomeBloc, HomeStreams>(
      builder: (context, dispatcher, streams) {
        return Scaffold(
          appBar: AppBar(

            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/applogo.png',
                  fit: BoxFit.cover,
                  height: 45.0,
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Farnosť Veľký Šariš'),
                )
              ],
            ),
          ),
          body: Container(
            color: Colors.grey[200],
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: SearchWidget(),
                  ),
                  Expanded(child: _getContent(streams))
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigation((index) {
            streams.tabPosition.set(index);
          }), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }

  Widget _getContent(HomeStreams streams) {
    return StreamListener<int>(
        stream: streams.tabPosition.get,
        builder: (BuildContext context, snapshot) {
          switch (snapshot.data) {
            case 0:
              return FeaturedView();
              break;
            case 1:
              return NewsView();
              break;
            case 2:
              return Info();
            default:
              return Container();
          }
        });
  }
}
