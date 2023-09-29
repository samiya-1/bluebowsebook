// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:ebook_application/services/api.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class bookapi{
//   List _loaddata=[];
//
//   _fetchData() async {
//     var res = await Api()
//         .getData('/api/allbooks');
//     if (res.statusCode == 200) {
//       var items = json.decode(res.body)['data'];
//       print(items);
//       setState(() {
//         _loaddata = items;
//
//       });
//     } else {
//       setState(() {
//         _loaddata = [];
//         Fluttertoast.showToast(
//           msg:"Currently there is no data available",
//           backgroundColor: Colors.black,
//         );
//       });
//     }
//   }
// }
