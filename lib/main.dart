
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences ? sharedp;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedp = await SharedPreferences.getInstance();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  int  pref= sharedp!.getInt('login_id')?? 0;
  int  userpref= sharedp!.getInt('user')?? 0;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("login id $pref",);
    print("user Id $userpref");

    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (BuildContext context){return Providerclass();}),
          ChangeNotifierProvider(create: (BuildContext context){return FavoriteProvider();})
        ],

        // print('hi');


        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,

          ),
          home: pref != 0 ? EbookHomePage():WelcomePage(),
        ),
      );

  }
}

