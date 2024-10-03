// import 'package:flutter/material.dart';
// import 'package:flutterprojects/model/cart_model.dart';
// import 'package:provider/provider.dart';
//
// import 'components/grocery_item_tile.dart';
// import 'cart_page.dart';
//
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//           onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context){
//             return CartPage();
//           })),
//          backgroundColor: Colors.black,
//         child:Icon(Icons.shopping_bag),
//       ),
//         body:SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 45),
//
//                 const Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                     child:Text("Good Morning")
//                 ),
//
//                  const Padding(
//                   padding: EdgeInsets.symmetric(horizontal:24.0),
//                   child: Text(
//                       "Let's prepare fresh items for You",
//                       style:TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         fontStyle: FontStyle.italic,
//                       )
//                   ),
//                 ),
//               const SizedBox(height: 22),
//
//                 const Padding(
//                   padding: const EdgeInsets.symmetric(horizontal:24),
//                   child:Divider(),
//                 ),
//                 const SizedBox(height: 22),
//
//                 const Padding(
//                     padding: const EdgeInsets.symmetric(horizontal:24),
//                     child: Text(
//                       "Fresh items",
//                          style:TextStyle(
//                          fontSize: 16,
//                  ),
//                  ),
//                 ),
//                 Expanded(
//                   child: Consumer<CartModel>(builder: (context,value,child){
//                     return GridView.builder(
//                       itemCount: value.shopItems.length,
//                         padding: const EdgeInsets.all(12.0),
//                       gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount:2),
//                       itemBuilder: (context,index){
//                         return GroceryItemTile(
//                           itemName: value.shopItems[index][0],
//                           itemPrice: value.shopItems[index][1],
//                           imagePath: value.shopItems[index][2],
//                           color: value.shopItems[index][3],
//                             onPressed:(){
//                             Provider.of<CartModel>(context,listen:false)
//                               .addItemsToCart(index);
//                             },
//                         );
//
//                       },
//                     );
//                   })
//                 ),
//           ],
//             )),
//
//     );
//   }
// }
//
//
