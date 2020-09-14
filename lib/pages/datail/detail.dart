import 'dart:async';
import 'dart:io';
import 'package:FlutterNews/support/util/StringsLocation.dart';
import 'package:FlutterNews/support/util/date_util.dart';
import 'package:FlutterNews/support/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:FlutterNews/support/util/colors.dart';
import 'package:FlutterNews/support/notifications/firebase.dart';

class DetailPage extends StatelessWidget{

  final _img;
  final _title;
  final _date;
  final _description;
  final _link;
  final _category;
  final _origin;

  DetailPage(this._img,this._title,this._date,this._description,this._category,this._link,this._origin);

  @override
  Widget build(BuildContext context) {
    new FirebaseNotifications().setUpFirebase(context);
    return new Scaffold(
      backgroundColor: Colors.grey,
      appBar: new AppBar(
        title: new Text(_origin),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              shareNotice();
            },
            color: Colors.white,
          )
        ],
      ),
      body: new Container(
        margin: new EdgeInsets.all(10.0),
        child: new Material(
          elevation: 4.0,
          borderRadius: new BorderRadius.circular(6.0),
          child: new ListView(
            children: <Widget>[
             new Hero(
                 tag: _title,
                 child: _getImageNetwork(Functions.getImgResizeUrl(_img,250,''))
             ),
              _getBody(_title,_date,_description,_origin,context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImageNetwork(url){

    try{
      if(url != '') {

        return ClipRRect(
          borderRadius: new BorderRadius.only(topLeft: Radius.circular(6.0),topRight: Radius.circular(6.0)),
          child: new Container(
            height: 200.0,
            child: new FadeInImage.assetNetwork(
              placeholder: 'assets/place_holder.jpg',
              image: url,
              fit: BoxFit.cover,),
          ),
        );
      }else{
        return new Container(
          height: 200.0,
          child: new Image.asset('assets/place_holder_3.jpg'),
        );
      }

    }catch(e){
      return new Container(
        height: 200.0,
        child: new Image.asset('assets/place_holder_3.jpg'),
      );
    }

  }

  Widget _getBody(tittle,date,description,origin,context){

    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getTittle(tittle),
          _getDate(date,origin),
          _getDescription(description),
          _getAntLink(),
          _getLink(_link,context)
        ],
      ),
    );
  }

  Widget _getAntLink() {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Center(
        child:new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Plné znenie oznamu:",
            style: new TextStyle(fontWeight: FontWeight.bold,
                color: Colors.grey[600],
                fontSize: 15.0,
            ),

          )
        ]
      )
      )
      );
  }
  Widget _getLink(link,context){

    /*return new GestureDetector(
      child: new Text(
        link,
        style: new TextStyle(color: createMaterialColor(Color(0xff8c021c))),
      ),
      onTap: (){
        _launchURL(link,context);
      },
    );*/
    return new Center(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  color: createMaterialColor(Color(0xff8c021c)),
                  onPressed: () => _launchURL(link,context),
                  elevation:5.0,
                  child: new Text("ZOBRAZIŤ",
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      fontFamily: 'Roboto',
                    ),),
                  splashColor: createMaterialColor(Color(0xff260007)),
                  animationDuration: Duration(seconds: 2),
                  colorBrightness: Brightness.dark,
                  shape: RoundedRectangleBorder(  borderRadius: new BorderRadius.circular(2),  side: BorderSide(color: createMaterialColor(Color(0xff590111))),)
              )],
    ),
    );

  }

  _getTittle(tittle) {
    return new Text(tittle,
    style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Georgia',
        color: createMaterialColor(Color(0xff590111)),
        backgroundColor: Colors.white70,
        fontSize: 25.0),
    );
  }

  _getDate(date,origin) {
    return new Container(
      margin: new EdgeInsets.only(top: 4.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(new DateUtil().buildDate(date),
            style: new TextStyle(
                fontSize: 15.0,
                color: Colors.grey
            ),
          ),
          new Text(origin,
            style: new TextStyle(
                fontSize: 10.0,
                color: Colors.grey
            ),
          )
        ],
      ),
    );
  }

  _getDescription(description) {
    return new Container(
      margin: new  EdgeInsets.only(top: 20.0),
      child: new Text(description,
        style: new TextStyle(
            fontSize: 18.0,
            color: Colors.black
        ),),
    );
  }

  _launchURL(url,context) async {
    if(Platform.isAndroid) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Nie je možné spustiť $url');
      }
    }else{
      Clipboard.setData(new ClipboardData(text: url));
      _showDialog(context);
    }
  }

  Future shareNotice() async {
    await Share.share("$_title:\n$_link");
  }

  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(getString("text_copy")),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(getString("text_fechar")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}