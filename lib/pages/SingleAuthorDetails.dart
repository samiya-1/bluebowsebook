import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api.dart';

class SingleAuthorDetails extends StatefulWidget {
  int id;
   SingleAuthorDetails({required this.id});

  @override
  State<SingleAuthorDetails> createState() => _SingleAuthorDetailsState();
}

class _SingleAuthorDetailsState extends State<SingleAuthorDetails> {

  late SharedPreferences prefs;
  late int aid;
  String book_name='';
  String author_name='';
  String genre='';
  String contact='';

  String about='';
  String works='';
  String publisheddate='';
  String file='';
  String image='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();

    aid =widget.id;
    print('Single Author ${aid}');
    var res = await Api()
        .getData('/api/singleauthor/' + aid.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      book_name = body['data']['book_name'];
      author_name = body['data']['author_name'];
      genre=body['data']['genre'];
      contact=body['data']['contact'];
      about=body['data']['about'];
      works=body['data']['works'];
      image=body['data']['image'];

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(author_name),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_outline),
            color: Colors.red,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network( Api().url+ image,),
            Text(
              author_name,
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(contact),
            Text(works),
            Text(about),


          ],
        ));
  }
}

