import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Icon(
        Icons.menu,
        color: Colors.black45,
      ),
      title: Text(
        'movies-db'.toUpperCase(),
        style: TextStyle(
            color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 15),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://previews.123rf.com/images/ylivdesign/ylivdesign1211/ylivdesign121100088/16526995-blue-movie-logo-on-a-black-background.jpg"),
          ),
        )
      ],
    ));
  }
}
