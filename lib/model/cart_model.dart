// import 'package:flutter/material.dart';
//
// class CartModel extends ChangeNotifier{
//     final List _shopItems = [
//       ["Item1","4.00","lib/Images/Image1.jpg",Colors.green],
//       ["Item2","2.50","lib/Images/Image2.jpg",Colors.yellow],
//       ["Item3","12.80","lib/Images/Image3.jpg",Colors.brown],
//       ["Item4","1.00","lib/Images/Image4.jpg",Colors.blue],
//
//     ];
//     List _cartItems=[];
//      get shopItems=>_shopItems;
//      get cartItems=>_cartItems;
//
//
//      void addItemsToCart(int index){
//        _cartItems.add(_shopItems[index]);
//        notifyListeners();
//      }
//
//     void removeItemsFromCart(int index){
//       _cartItems.removeAt(index);
//       notifyListeners();
//     }
//     String calculateTotal(){
//        double totalPrice=0;
//        for(int i=0;i<_cartItems.length;i++){
//          totalPrice+=double.parse(_cartItems[i][1]);
//        }
//        return totalPrice.toStringAsFixed(2);
//     }
//
// }
import 'package:hive/hive.dart';
// import 'flutterprojects/model/cart_model.dart';

// part 'photo.g.dart'; // This will be generated
part 'cart_model.g.dart';

@HiveType(typeId: 0)
class Photo {
  @HiveField(0)
  final String path;

  @HiveField(1)
  final DateTime timestamp;

  Photo(this.path) : timestamp = DateTime.now();

  // String get imagePath =>'C:/Users/Amogha/Documents/flutterprojects/assets/Images/';
}