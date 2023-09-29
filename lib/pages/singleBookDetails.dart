import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleBookDetails extends StatefulWidget {
  final int id;

  SingleBookDetails({required this.id});

  @override
  State<SingleBookDetails> createState() => _SingleBookDetailsState();
}

class _SingleBookDetailsState extends State<SingleBookDetails> {
  List _loaddata = [];

  String get user => user;

  _fetchData() async {
    var res = await Api().getData('/api/allbooks');
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

  bool isFavorite = false;
  late SharedPreferences prefs;
   late int aid;
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
    _fetchData();
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

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Providerclass>(context);
    final favourite=Provider.of<FavoriteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(book_name),

        leading: IconButton(
          onPressed: () {
            favourite.addtofavourites(book_name,user);
          },
          icon: favourite.icon_change(book_name) ?
          const Icon(Icons.favorite,color: Colors.red,) :
          Icon(Icons.favorite_outline,color: Colors.grey.shade500,),
          ),

        ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(Api().url + image),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleBookAllDetails(id: bid),
                      ));
                },
                child: Text(
                  book_name,
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {
                print(bid);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookReviewPage( bid: bid,)));
              }, icon: Icon(Icons.star_border)),
            ],
          ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => SingleAuthorDetails(id: aid),
          //       ),
          //     );
          //   },
          //   child:
    Text(author_name),
         // ),
          Text(description),
          SizedBox(height: 30,),
          Row(
            children: [
              Text(
                'Price :',style: TextStyle(color: Colors.red),
              ),
              Text(price,),
              Text('\$'),
            ],
          ),
          Expanded(child: Padding(padding: EdgeInsets.all(10.0))),
          SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.download),
                  onPressed: () {
                    //final fileUrl = 'https://example.com/api/book/123/download'; 
                    downloadFile(file);
                  },
                  style: ElevatedButton.styleFrom(fixedSize: Size(200, 30)),
                  label: Text('Download'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("add");

                    cart.addtoCart(
                        book_name,price);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                  },
                  child: Text('Add to cart'),
                  style: ElevatedButton.styleFrom(fixedSize: Size(200, 30)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


void downloadFile(String fileUrl) async {
  final response = await http.get(Uri.parse(fileUrl));

  if (response.statusCode == 200) {
    final fileName = 'file';
    final file = File(fileName);
    await file.writeAsBytes(response.bodyBytes);
    print('File downloaded to: ${file.path}');
  } else {
    throw Exception('Failed to download file');
  }
}
