import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/api.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List _loaddata = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    var res = await Api().getData('/api/myorders');
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
          backgroundColor: Colors.grey,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: AppBar(

            title: Text('My orders'),
          ),
          body: ListView.builder(
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
                                _loaddata[index]['notification'],
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Text(_loaddata[index]['date'],
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
