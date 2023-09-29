
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Welcome!",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 25,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Buy RealBooks and Read Ebooks here ",
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 55,
          ),
          Image.asset(
            "images/page1.jpg",
            width: 540.0,
            height: 350.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 100,
          ),

          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  backgroundColor: Colors.lightBlueAccent,
                  fixedSize: Size(450, 57)),
              child: const Text(
                "GetStarted",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),

        ]),
      ),
    );
  }
}
