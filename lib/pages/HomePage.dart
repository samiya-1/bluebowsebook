import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api.dart';

class EbookHomePage extends StatefulWidget {
  const EbookHomePage({super.key});

  @override
  State<EbookHomePage> createState() => _EbookHomePageState();
}

class _EbookHomePageState extends State<EbookHomePage> {
  TextEditingController searchController = TextEditingController();
  List _loaddata = [];

  var bid;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _performSearch() {
    String searchTerm = searchController.text;

    print('Searching for: $searchTerm');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
leadingWidth: 69,
        leading: IconButton(
          onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>UserNotification()));
          },
            icon: Icon(Icons.notifications_none),

        ),
        title: Text('Bluebows'),

      ),
      endDrawer: MenuDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _performSearch,
                    ),
                  ),
                ),
                // Add widgets to display search results here.
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All Books',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                crossAxisSpacing: 40,
                                mainAxisSpacing: 40),
                        itemCount: _loaddata.length,
                        itemBuilder: (BuildContext ctx, index)
                        {
                          print(_loaddata[index]['id']);
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap:
                                  () {
                                print('jhhgjfh');
                                    print(bid);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SingleBookDetails(
                                                id: _loaddata[index]['id'])));
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Image.network(
                                      Api().url + _loaddata[index]['image'],
                                      //  height: 100,
                                      // width: 200,

                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  // Spacer(),
                                  Expanded(
                                    child: Text(
                                      _loaddata[index]['book_name'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('login_id');
}
