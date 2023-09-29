import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleBookAllDetails extends StatefulWidget {
  final int id;
  SingleBookAllDetails({required this.id});

  @override
  State<SingleBookAllDetails> createState() => _SingleBookAllDetailsState();
}

class _SingleBookAllDetailsState extends State<SingleBookAllDetails> {
  bool isFavorite = false;
  late SharedPreferences prefs;
  late int bid;
  String book_name = '';
  String author_name = '';
  String genre = '';
  String fileformat = '';
  String filesize = '';
  String price = '';
  String publisher = '';
  String isbn = '';
  String description = '';
  String publisheddate = '';
  String file = '';
  String image = '';
  List<int> selectedBooks = [];

  @override
  void initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();

    bid = widget.id;
    print('Single Book ${bid}');
    var res = await Api().getData('/api/singlebook/' + bid.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      book_name = body['data']['book_name'];
      author_name = body['data']['author_name'];
      genre = body['data']['genre'];
      fileformat = body['data']['fileformat'];
      filesize = body['data']['filesize'];
      description = body['data']['description'];
      publisher = body['data']['publisher'];
      isbn = body['data']['isbn'];
      publisheddate = body['data']['publisheddate'];
      price = body['data']['price'];
      file = body['data']['file'];
      image = body['data']['image'];
    });
  }

  //
  // void _toggleFavorite() async {
  //   prefs = await SharedPreferences.getInstance();
  //   List<String> favoriteBooks = prefs.getStringList('favorite_books') ?? [];
  //   if (isFavorite) {
  //     favoriteBooks.remove(widget.id.toString());
  //   } else {
  //     favoriteBooks.add(widget.id.toString());
  //   }
  //   prefs.setStringList('favorite_books', favoriteBooks);
  //   setState(() {
  //     isFavorite = !isFavorite;
  //   });
  // }
  //
  // void addToCart() {
  //   setState(() {
  //     if (!selectedBooks.contains(widget.id)) {
  //       selectedBooks.add(widget.id);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book_name),
        // leading: IconButton(
        //   onPressed: () {
        //     _toggleFavorite();
        //   },
        //   icon: Icon(
        //     isFavorite ? Icons.favorite : Icons.favorite_outline,
        //     color: isFavorite ? Colors.red : Colors.grey,
        //   ),
        // ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(Api().url + image),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Text(book_name, style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),),


            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleAuthorDetails(id: bid),
                ),
              );
            },
            child: Text(author_name),
          ), Text(genre),
          Text(fileformat),
          Text(filesize),
          Text(publisher),
          Text(isbn),
          Text(publisheddate),
          Text(file),
          Text(description),

        ],
      ),
    );
  }

}