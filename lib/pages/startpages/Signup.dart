import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool passwordVisible1=false;

  TextEditingController emailController=TextEditingController();
  TextEditingController pwdController=TextEditingController();
  TextEditingController unameController=TextEditingController();


  bool _isLoading=false;
  void registerUser()async {
    setState(() {
      _isLoading = true;
    });

    var data = {

      "username": unameController.text.trim(),
      "password": pwdController.text.trim(),
      "email": emailController.text.trim(),

    };

    print("User data${data}");
    var res = await Api().authData(data,'/api/userregister');
    var body = json.decode(res.body);
    print('res${body}');
    print(body['success']);
    if(body['success']=='True')
    {
      print('hello');

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      // ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            const Text("Register",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),


            Container(
              child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: TextField(
                    controller: unameController,
                    decoration: InputDecoration(

                        prefixIcon: Icon(Icons.person),
                        label: Text("Username "),
                        // hintText: "Enter your Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ))

                ),
              ),
            ),


            Padding(
              padding:  EdgeInsets.all(8.0),
              child: TextField(
                  controller: pwdController,
                  obscureText: passwordVisible1,
                  //keyboardType: TextInputType.number,
                  decoration: InputDecoration(

                      prefixIcon: Icon(Icons.lock),
                      label: Text("Password"),
                      // hintText: "Enter your Password",
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(20),
                      ))

              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(

                      prefixIcon: const Icon(Icons.email),
                      label: const Text("Email"),
                      //hintText: "Enter your Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                      ))

              ),
            ),

            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()
            {
              registerUser();

            },
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),fixedSize: Size(350, 57)),
              child: const Text("Signup",style: TextStyle(
                  fontSize: 18,color: Colors.white
              )),),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",style: TextStyle(fontSize: 20),),TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
                }, child: const Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }
}
