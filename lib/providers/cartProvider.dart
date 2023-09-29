import 'dart:convert';
import 'package:ebook_application/models/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../main.dart';
import '../services/api.dart';

class Providerclass extends ChangeNotifier {
  List bookname = [];
  List nobook = [];
  List amount = [];
  List image = [];

  List get cart_bookname => bookname;

  List get cart_nobook => nobook;

  List get cart_amount => amount;

  List get cart_image => image;
  List addcart = [];

  // void add_to_cart(String bookname, String amount, String nobook, String image) {
  //   addcart.add(bookname);
  //
  //   final c_bookname=bookname.contains(bookname);
  //   // final c_name=_name.contains(name);
  //   // final c_price=_price.contains(price);
  //   // final c_unit=_unit.contains(unit);
  //   // if(c_image){
  //   //   bookname.remove(bookname);
  //   //   _name.remove(name);
  //   //   _price.remove(price);
  //   //   _unit.remove(unit);
  //   // }
  //   // else{
  //   //   bookname.add(bookname);
  //   //   _name.add(name);
  //   //   _price.add(price);
  //   //   _unit.add(unit);
  //   // }
    int  userpref= sharedp!.getInt('user')?? 0;

    bool _isLoading=false;
    Future<void> addtoCart(String bookname, String amount,)async{
      //
      // setState(() {
      //   _isLoading = true;
      // });

      var data = {

        "book_name":bookname,
        "amount":amount,
        "user":userpref.toString(),

      };

      print("Added to Cart${data}");
      var res = await Api().authData(data,'/api/addtocart');
      var body = json.decode(res.body);
      print('res${body}');
      print(body['success']);
      if(body['success']==true)
      {
        print('Added to Cart succesfully');

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

    Future<List<CartModel>> fetchCart() async {
      var res = await Api().getData('/api/allcart');
      try {


        if (res.statusCode == 200) {
          var data = jsonDecode(res.body);
          List<CartModel> modelList  =data['data'].map<CartModel>((e)=>CartModel.fromJson(e)).toList();

          return modelList;


        } else {
          throw Exception('something went wrong');
        }
      } catch (error) {
        rethrow;

      }
    }
  Future<List<CartModel>> deleteCart(String id) async {
      var res = await Api().deleteData('/api/deletecart');

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        List<CartModel> modelList  =data['data'].map<CartModel>((e)=>CartModel.fromJson(e)).toList();
        return modelList;

      } else {
      throw Exception('Failed to delete album.');
    }
  }

  notifyListeners();
  }

