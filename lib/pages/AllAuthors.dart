import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api.dart';

class AllAuthors extends StatefulWidget {
  final int id;
  const AllAuthors({super.key, required this.id});

  @override
  State<AllAuthors> createState() => _AllAuthorsState();
}

class _AllAuthorsState extends State<AllAuthors> {
  bool isFavorite = false;
  late SharedPreferences prefs;
  late int aid;
  void _toggleFavorite() async {
    prefs = await SharedPreferences.getInstance();
    List<String> favoriteBooks = prefs.getStringList('favorite_books') ?? [];
    if (isFavorite) {
      favoriteBooks.remove(widget.id.toString());
    } else {
      favoriteBooks.add(widget.id.toString());
    }
    prefs.setStringList('favorite_books', favoriteBooks);
    setState(() {
      isFavorite = !isFavorite;
    });
  }
  List _loaddata = [];

  _fetchData() async {
    var res = await Api().getData('/api/allauthors');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddata = items;
      });
    } else {
      setState(() {
        _loaddata = [];
        Fluttertoast.showToast(
          msg: "Currently there is no data available",
          backgroundColor: Colors.black,
        );
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Authors'),
          leading: IconButton(
            onPressed: () {
              _toggleFavorite();
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ),
        body: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _loaddata.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 16, right: 12, left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.green,
                          size: 36,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _loaddata[index]['author_name'],
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Text(_loaddata[index]['works'],
                          style: TextStyle(fontSize: 15))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                  )
                ],
              ),
            );
          },
        )
    );
  }
}
