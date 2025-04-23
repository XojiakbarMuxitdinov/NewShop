import 'package:flutter/material.dart';

import 'shoe.dart';



class Cart extends ChangeNotifier {
  // list of shoes for slie
  List<Shoe> shoeShop = [
    Shoe(
      name: 'Nike Air Max Dn',
      price: '160',
      description: 'Sustainable Materials',
      imagePath: 'lib/image/Gazelle_Indoor_Shoes_Burgundy_IG4996_01_standard.avif', 
      category: '', 
      imageUrl: null,
    ),
    Shoe(
        name: 'Gradiant sneak',
        price: '510',
        description:
            'Bu krasovkamiz elektr quvatli xisoblanadi',
        imagePath: 'lib/image/Gazelle_Bold_Shoes_Black_IE0876_01_standard.avif',
        category: '', 
        imageUrl: null,
        ),
    Shoe(
        name: 'Ultra boots',
        price: '359',
        description:
            'New',
        imagePath: 'lib/image/Ultraboost_1.0_Shoes_Black_HQ4199_01_standard.avif',
        category: '', 
        imageUrl: null,
      ),
    Shoe(
        name: 'Adidas New collection',
        price: '160',
        description: 'description',
        imagePath: 'lib/image/Gazelle_Shoes_Pink_ID7006_01_standard.avif',
        category: '', 
        imageUrl: null,
      ),
   
  ];

  // list of items in user cart
  List<Shoe> userCart = [];

  // get list of shoes for sale
  List<Shoe> getShoeList() {
    return shoeShop;
  }

  // get cart
  List<Shoe> getUserCart() {
    return userCart;
  }

  // add items to cart
  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();

  }
}
