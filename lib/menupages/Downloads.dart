import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/api.dart';

class Downloads extends StatefulWidget {
  const Downloads({super.key});

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  List _loaddata = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    var res = await Api().getData('/api/');
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
    return Scaffold(
        appBar: AppBar(

          title: const Text('Downloaded file'),

        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
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
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.download_for_offline,

                          size: 36,
                        ),
                      ),
                      const SizedBox(
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
                      const SizedBox(
                        width: 14,
                      ),
                      Text(_loaddata[index]['date'],
                          style: TextStyle(fontSize: 15))
                    ],
                  ),
                  const SizedBox(
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
        ));
  }
}
