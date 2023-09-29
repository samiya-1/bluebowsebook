import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../services/api.dart';

class UserFeedback extends StatefulWidget {

  UserFeedback();

  @override
  _UserFeedbackState createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  int  userpref= sharedp!.getInt('user')?? 0;
  double _rating = 0.0;
  TextEditingController feedbackController = TextEditingController();
  DateTime datetime = DateTime.now();
  String datetime1='';
  String feedback='';


  bool _isLoading=false;
  void _submitReview()async {
    datetime1 = DateFormat("yyyy-MM-dd").format(datetime);

    setState(() {
      _isLoading = true;
    });

    var data = {
      "date": datetime1,
      "feedback":feedbackController.text.trim(),
      "rating":_rating.toString(),
      "user":userpref.toString(),


    };

    print("User Feedback${data}");
    var res = await Api().authData(data,'/api/addfeedback');
    var body = json.decode(res.body);
    print('res${body}');
    print(body['success']);
    if(body['success']==true)
    {
      print('feedback added succesfully');

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

     // Navigator.push(context, MaterialPageRoute(builder: (context)=>BookReviewPage(bid:widget.bid)));

    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
  }
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }
  // void _submitReview() {
  //
  //   print('Rating: $_rating');
  //   print('Review: ${reviewController.text}');
  // }

  @override
  Widget build(BuildContext context) {
    print('hhhhhi');

    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Rate the app',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Rating: $_rating',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 20),
                Slider(
                  value: _rating,
                  onChanged: (newRating) {
                    setState(() {
                      _rating = newRating;
                    });
                  },
                  min: 0,
                  max: 5,
                  divisions: 5,
                  label: '$_rating',
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: feedbackController,
              decoration: InputDecoration(
                labelText: 'Write a Feedback(optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReview,
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }
}
