import 'dart:convert';

import 'package:ebook_application/models/favouritemodel.dart';
import 'package:ebook_application/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class FavoriteProvider extends ChangeNotifier {
  List item=[];
  List get favoriteitem =>item;

  void favorites(String items){
    final favitem=item.contains(items);

    if(favitem){
      item.remove(items);
    }
    else{
      item.add(items);
    }
    notifyListeners();
  }
  int  userpref= sharedp!.getInt('user')?? 0;

  bool _isLoading=false;
  Future<void> addtofavourites(String bookname, String user,)async{
    final favitem=item.contains(bookname);
    if(favitem){
      item.remove(bookname);
    }
    else{
      item.add(bookname);
    }
    //
    // setState(() {
    //   _isLoading = true;
    // });

    var data = {

      "book_name":bookname,
      //"amount":amount,
      "user":userpref.toString(),

    };

    print("Added to favourite${data}");
    var res = await Api().authData(data,'/api/addfavouritebooks');
    var body = json.decode(res.body);
    print('res${body}');
    print(body['success']);
    if(body['success']==true)
    {

      print('Added favourite book succesfully');

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
  }

  Future<List<favouriteModel>> fetchfavourites() async {
    var res = await Api().getData('/api/favouritebooks');
    try {


      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        List<favouriteModel> modelList  =data['data'].map<favouriteModel>((e)=>favouriteModel.fromJson(e)).toList();

        return modelList;


      } else {
        throw Exception('something went wrong');
      }
    } catch (error) {
      rethrow;

    }
  }

  bool icon_change(String book_name){
    final favicon= book_name.contains(book_name);
    return favicon;
  }
}