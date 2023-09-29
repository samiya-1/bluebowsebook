import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/cartProvider.dart';

class Cart extends StatefulWidget {
  // int id;
   Cart();

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {


  bool isFavorite = false;
  late SharedPreferences prefs;
  late int bid;
  String book_name = '';
  String amount = '';
  String image = '';
  String nobook='';
  List<int> selectedBooks = [];

  // @override
  // void initState() {
  //   fetchCart();
  //   super.initState();
  //
  // }

  // Future<void> _viewPro() async {
  //   prefs = await SharedPreferences.getInstance();
  //
  //   bid = widget.id;
  //   print('all cart Book ${bid}');
  //   var res = await Api().getData('/api/allcart/' );
  //   var body = json.decode(res.body);
  //   print(body);
  //   setState(() {
  //     book_name = body['data']['book_name'];
  //     genre = body['data']['genre'];
  //     price = body['data']['price'];
  //     nobook=body['data']['nobook'];
  //     image = body['data']['image'];
  //
  //   });
  // }


  @override
  Widget build(BuildContext context) {



  final object = Provider.of<Providerclass>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('book List'),
        centerTitle: true,
      ),
      body:
      FutureBuilder<List<CartModel>>(
        future: object.fetchCart(),
        builder:(context, snapshot)  {

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child:CircularProgressIndicator(),);
          }
          if(snapshot.hasData){
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context,index){
                  return

                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*.113,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 10),
                            //       child: Image.asset(image[index],width: 90,height: 90,),
                            //     ),
                            //   ],
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text('Book Name : ',style: TextStyle(fontSize: 16),),
                                    Text(snapshot.data![index].bookName!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Price : \$ ',style: TextStyle(fontSize: 16),),
                                        Text(snapshot.data![index].amount!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                      ],
                                    ),

                        // <Widget>[
                        //   Text(snapshot.data?.body ?? 'Deleted'),
                        //   ElevatedButton(
                        //     child: const Text('Delete Data'),
                        //     onPressed: () {
                        //       setState(() {
                        //         object =
                        //             deleteCart(snapshot.data!.id.toString());
                        //       });
                        //     },
                        //   ),
                        // ],
                      //);
                                  ],
                                ),

                              ],
                            ),

                            //
                          ],
                        ),
                      ),
                    );

                }
            );
          }else{
            return Text('no data');
          }



        },

      ),
    );
  }
}






// import 'package:ebook_application/pages/payment.dart';
// import 'package:flutter/material.dart';
//
// import '../models/cartmodel.dart';
//
//
//
// class ShoppingCart extends StatefulWidget {
//   @override
//   _ShoppingCartState createState() => _ShoppingCartState();
// }
//
// class _ShoppingCartState extends State<ShoppingCart> {
//
//
//   List<Product> cartItems = [];
//   List<Product> _products = [
//     Product("Product 1", 10.99),
//     Product("Product 2", 19.99),
//     Product("Product 3", 5.99),
//     Product("Product 4", 15.99),
//   ];
//
//   double _getTotalPrice() {
//     double total = 0;
//     for (Product item in cartItems) {
//       total += item.price;
//     }
//     return total;
//   }
//
//   void _placeOrder() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => Payment(cartItems: double.parse(cartItems.toString()),)),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shopping Cart'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: _products.length,
//               itemBuilder: (context, index) {
//                 final product = _products[index];
//                 final isInCart = cartItems.contains(product);
//
//                 return ListTile(
//                   title: Text(product.name),
//                   subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
//                   trailing: isInCart
//                       ? IconButton(
//                     icon: Icon(Icons.remove_shopping_cart),
//                     onPressed: () {
//                       setState(() {
//                         cartItems.remove(product);
//                       });
//                     },
//                   )
//                       : IconButton(
//                     icon: Icon(Icons.add_shopping_cart),
//                     onPressed: () {
//                       setState(() {
//                         cartItems.add(product);
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Total: \$${_getTotalPrice().toStringAsFixed(2)}',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Container(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed:()
//               {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment(cartItems: double.parse(cartItems.toString()),)));
//               },
//               child: Text('Place Order'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
