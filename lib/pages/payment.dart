import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payment extends StatefulWidget {
  final double cartItems;
  Payment({required this.cartItems});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  DateTime datetime = DateTime.now();
  String datetime1 = '';
  late SharedPreferences prefs;
  late int user;
  late double amount;

  get result => widget.cartItems;

  Future<void> submitForm(
      // String amount,
      String payment_method,
      String date,
      ) async {
    bool _isLoading = false;
    // Submit form logic here
  }

  void addPayment() async {
    datetime1 = DateFormat("yyyy-MM-dd").format(datetime);

    setState(() {
      bool _isLoading = true;
    });

    var data = {
      "user": user.toString(),
      "amount": widget.cartItems.toString(),
      "payment_method": _selectedCard,
      "date": datetime1,
    };

    print("User data: $data");

    var res = await Api().authData(data, '/api/payment');
    var body = json.decode(res.body);
    print('Response: $body');

    if (body['success'] == true) {


      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  String _selectedCard = '';
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    initUser();
  }

  Future<void> initUser() async {
    prefs = await SharedPreferences.getInstance();
    user = prefs.getInt('user') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Payment'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Please let us know your Payment Method:'),
                ListTile(
                  leading: Radio<String>(
                    value: 'Credit Card',
                    groupValue: _selectedCard,
                    onChanged: (value) {
                      setState(() {
                        _selectedCard = value!;
                      });
                    },
                  ),
                  title: const Text('Credit Card'),
                ),
                ListTile(
                  leading: Radio<String>(
                    value: 'Debit Card',
                    groupValue: _selectedCard,
                    onChanged: (value) {
                      setState(() {
                        _selectedCard = value!;
                      });
                    },
                  ),
                  title: const Text('Debit Card'),
                ),
                const SizedBox(height: 25),
                Text(_selectedCard == 'Credit Card' ? 'You Selected Credit Card ' : 'You Selected Debit Card'),
                SizedBox(height: 20,),
                Text("Total Amount"),
                Text(
                  result.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    addPayment();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),
                    primary: Colors.green,
                    fixedSize: const Size(350, 57),
                  ),
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
