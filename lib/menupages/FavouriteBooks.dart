
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {

    final favourite=Provider.of<FavoriteProvider>(context);
    List itemstore=favourite.favoriteitem;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body:
      FutureBuilder<List<favouriteModel>>(
        future: favourite.fetchfavourites(),
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
                    // Text(object.addcart[index]);

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
                                    Text('Name : ',style: TextStyle(fontSize: 16),),
                                    Text(snapshot.data![index].bookname!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  ],
                                ),
                                // SizedBox(height: 5,),
                                // Row(
                                //   children: [
                                //     Text('Unit : ',style: TextStyle(fontSize: 16),),
                                //     Text(nobook[index],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                //   ],
                                // ),
                                // SizedBox(height: 5,),
                                // Row(
                                //   children: [
                                //     Text('Price : \$ ',style: TextStyle(fontSize: 16),),
                                //     Text(snapshot.data![index].amount!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                //   ],
                                // ),
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