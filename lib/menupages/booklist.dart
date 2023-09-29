//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';
//
// import '../pages/cart.dart';
// import '../providers/cartProvider.dart';
//
// class Products extends StatefulWidget {
//   const Products({super.key});
//
//   @override
//   State<Products> createState() => _ProductsState();
// }
//
// class _ProductsState extends State<Products> {
//
//   List images=['images/apple.png',
//     'images/avagado.png',
//     'images/banana.png',
//     'images/kiwi.png',
//     'images/mango.png',
//     'images/orange.png',
//     'images/pomegranate.png',
//     'images/strawberry.png',
//     'images/watermelon.png'];
//   List name=['Apple','Avagado','Banana','Kiwi','Mango','Orange','Pomegranate','Strawberry','Water Melon'];
//   List unit=['kg','Pc','Doz','Doz','Doz','Doz','Doz','Pc','kg'];
//   List price=['45','35','30','72','30','25','55','40','35'];
//
//   get cid => null;
//
//   @override
//   Widget build(BuildContext context) {
//     final object= Provider.of<Providerclass>(context);
//     return Scaffold(
//       appBar: AppBar(title: Text('Book List',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white ),
//       ),
//         centerTitle: true,
//         actions: [Padding(padding: EdgeInsets.only(right: 15),
//           child: Badge(
//
//             child:   IconButton(onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => Cart(),));
//             },
//                 icon: Icon(Icons.shopping_cart,size: 35,
//                 )
//
//             ),
//           ),
//         )
//         ],
//       ),
//       body: ListView.builder(
//           shrinkWrap:true,
//           itemCount:images.length,
//           itemBuilder:(context,index){
//             return Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 5),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height*.112,
//                 decoration: BoxDecoration(
//                     color: Colors.grey,
//                     borderRadius: BorderRadius.circular(9)
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(padding: EdgeInsets.only(left: 10),
//                           child: Image.asset(images[index],width: 90,height: 90,),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text('Name: ',style: TextStyle(fontSize: 20),),
//                             Text(name[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//                           ],
//                         ),
//                         SizedBox(height: 12,),
//                         Row(
//                           children: [
//                             Text('Unit: ',style: TextStyle(fontSize: 20),),
//                             Text(unit[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Text('Price: \$',style: TextStyle(fontSize: 20),),
//                             Text(price[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(padding: EdgeInsets.only(right: 10),
//                           child: ElevatedButton(onPressed: (){
//                             object.add_to_cart(images[index], name[index], price[index], unit[index]);
//                           },
//                             child: Text('Add to Cart',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blueGrey.shade900,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                               fixedSize: Size(89, 27),
//                             ),
//                           ),
//                         ) ],
//                     ),
//
//                   ],
//                 ),
//               ),
//             );
//           }
//
//       ),
//     );
//   }
// }
