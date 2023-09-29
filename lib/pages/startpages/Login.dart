import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController=TextEditingController();
  TextEditingController pwdController=TextEditingController();


  bool _isLoading=false;

  late SharedPreferences localStorage;
  String role="";
  String status="";
  String storedvalue="1";
  String user="user";

  _pressLoginButton()
  async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email': emailController.text.trim(),
      'password': pwdController.text.trim()
    };
    var res = await Api().authData(data,'/api/login_user');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      status =  body['data']['l_status'];

      localStorage = await SharedPreferences.getInstance();

      localStorage.setInt('login_id', body['data']['login_id']);
      localStorage.setInt('user',  body['data']['user']);



      print('login_id ${body['data']['login_id']}');
      print('user ${body['data']['user']}');

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EbookHomePage()));




    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login",style: TextStyle(color: Colors.black,fontSize:30,fontWeight: FontWeight.bold)),
            SizedBox(height: 15,),

            const Text("Welcome Back! Login with your email and password",style: TextStyle(color: Colors.black,fontSize:15,fontWeight: FontWeight.bold)),
            SizedBox(height: 15,),
//Image.asset('images/login.jpg'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: emailController,

                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(20)

                    ),

                    prefixIcon: Icon(Icons.person,),
                    label: Text("Email"),
                  )

              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: pwdController,

                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(20)

                    ),

                    prefixIcon: Icon(Icons.lock,),
                    label: Text("Password"),
                  )

              ),
            ),


            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()
            {
              _pressLoginButton();
            },
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),fixedSize: Size(350, 57)),
              child: Text("Login",style: TextStyle(
                  fontSize: 18,color: Colors.white
              )),),

            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("dont't have an acoount?",style: TextStyle(fontSize: 20),),TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                }, child: Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))

              ],

            ),

          ],
        )

    );
  }
}
