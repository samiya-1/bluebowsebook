import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../services/api.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool isObscurePassword=true;
  late int user;

  String email='';
  String username='';
  String password='';

  late SharedPreferences prefs;

  TextEditingController emailController=TextEditingController();
  TextEditingController unameController=TextEditingController();
  TextEditingController pwdController=TextEditingController();

  final List<Widget> screen =[
    EbookHomePage(),
    // ClassNotify(),
    // My_Orders(),
    Profile(),
  ];
  int currentTab = 3;




  @override
  void initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    user = (prefs.getInt('user') ?? 0);
    print('update profile $user');
    var res = await Api().getData('/api/singleuser/'+user.toString());
    var body = json.decode(res.body);
    print(body);

    setState(() {
      username = body['data']['name']; // Assuming the API response has 'name' field
      email = body['data']['email'];


      emailController.text = email;
      unameController.text = username;

    });
  }



  Future<void> _update(int user,String username,String email) async {

    prefs = await SharedPreferences.getInstance();
    user = (prefs.getInt('user') ?? 0 );
    String id=user.toString();

    var uri = Uri.parse(Api().url+'/api/updateuser/${id}'); // Replace with your API endpoint

    var request = http.MultipartRequest('PUT', uri);

    request.fields['user'] = user.toString();
    request.fields['name'] = username;
    request.fields['email'] = email;
       print(request.fields);



    final response = await request.send();
    print(response);

    if (response.statusCode == 200) {
      print('Profile Updated successfully');
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => EbookHomePage()));
    } else {
      print('Error Updating profile. Status code: ${response.statusCode}');
    }
  }

  Widget currentScreen = Profile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [



          ],
        ),
      ),
      appBar: AppBar(

        title: Text("Profile"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            tooltip: "Logout",
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
            },
            icon: Icon(
              Icons.logout,
              size: 28,
            ),
          )
        ],
      ),

      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    SizedBox(height: 10,),


                  ],
                ),
              ),
              SizedBox(height: 60,),

              buildTextField("name",unameController),
              buildTextField("email", emailController),
                          SizedBox(height: 70,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EbookHomePage()));
                    },
                    child: Text("CANCEL",style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black
                    )),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),

                  ElevatedButton(
                    onPressed: (){
                      _update(user,unameController.text,emailController.text);
                    },
                    child: Text("EDIT",style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white),),
                    style: ElevatedButton.styleFrom(

                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),

    );
  }

  Widget buildTextField(String labelText,TextEditingController controller){
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextFormField(
        controller: controller,
        //obscureText: isPasswordTextField ? isObscurePassword: false,
        decoration: InputDecoration(

          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 18),
          floatingLabelBehavior: FloatingLabelBehavior.always,


        ),
      ),
    );
  }
}
