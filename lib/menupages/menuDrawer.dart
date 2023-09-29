
import 'package:flutter/material.dart';


class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Menu',style: TextStyle(color: Colors.teal[700]),),
              decoration: BoxDecoration(

              ),
            ),
            ListTile(
              title: Text('My Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
              },
            ),
            ListTile(
              title: Text('My orders'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrders()));

              },
            ),
            ListTile(
              title: Text('Favourites'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Favourite()));
              },
            ),
            ListTile(
              title: Text('Downloads'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Downloads()));
              },
            ),
            ListTile(
              title: Text('Contact us'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Complaint()));
              },
            ),

            ListTile(
              title: Text(' Cart'),
              onTap: () {
                logout();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
              },
            ),
            ListTile(
              title: Text('Rate us'),
              onTap: () {
                logout();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserFeedback()));
              },
            ),
            ListTile(
              title: Text('Log out'),
              onTap: () {
                logout();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              },
            ),
            // Add more ListTile widgets for additional menu items
          ],
        ),

      ),
    );
  }
}
