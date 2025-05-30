import 'package:flutter/material.dart';
import 'package:new_shop/components/cart_item.dart';
import 'package:new_shop/models/cart.dart';
import 'package:new_shop/models/shoe.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
        builder: (context, value, child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // heading
                  const Text(
                    'Cart',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: ListView.builder(
                      itemCount: value.getUserCart().length,
                      itemBuilder: (context, index) {
                      // get individual shoe
                      Shoe individualShoe = value.getUserCart()[index];

                      // return the cart item
                      return CartItem(shoe: individualShoe,);
                    },
                    ),
                  )
                ],
              ),
            ),
            );
  }
}
