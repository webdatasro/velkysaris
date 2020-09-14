/**import 'dart:async';
import 'package:FlutterNews/widgets/message_bean.dart';
import 'package:flutter/material.dart';


class DetailPage extends StatefulWidget {
DetailPage(this.itemId);
final String itemId;
@override
_DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  MessageBean _item;
  StreamSubscription<MessageBean> _subscription;

  @override
  void initState() {
    super.initState();
    _item = _items[widget.itemId];
    _subscription = _item.onChanged.listen((MessageBean item) {
      if (!mounted) {
        _subscription.cancel();
      } else {
        setState(() {
          _item = item;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item ${_item.itemId}"),
      ),
      body: Material(
        child: Center(child: Text("Item status: ${_item.status}")),
      ),
    );
  }
}
**/