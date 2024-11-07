import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/view/stores/checkout_screen.dart';
import 'package:pet_app/view_model/home_cubit/cubit.dart';

import '../../components/widget.dart';
import '../../model/store_model/cart_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getCartData();
    HomeCubit.get(context).getNumber();
  }

  @override
  Widget build(BuildContext context) {
    final cartModel = HomeCubit.get(context).cartModel;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        HomeCubit.get(context).getAllOffer();
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: primaryColor, width: 2),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 10,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Cart',
                      style: TextStyle(fontSize: 20, fontFamily: 'PoppinsBold'),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        print('${cartModel?.data?.cartItems[0].cartId ?? 0}');
                        HomeCubit.get(context).removeCart(
                            cartModel?.data?.cartItems[0].cartId ?? 0);
                      },
                      icon: Icon(Icons.delete_outline, color: Colors.red),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                // Location Row

                SizedBox(height: 40),
                cartModel == null ||
                    cartModel.data == null ||
                    cartModel.data!.cartItems.isEmpty
                    ? Center(
                  child: Column(
                    children: [
                      Image.asset('assets/images/cartempty.png'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Your cart is empty'),
                    ],
                  ),
                )
                    : Container(
                  height: cartModel.data!.cartItems.length * 150,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildCartItem(
                      cartModel.data!.cartItems[index],
                      cartModel.data!.products.firstWhere((product) =>
                      product.id ==
                          cartModel.data!.cartItems[index].productId),
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10),
                    itemCount: cartModel.data!.cartItems.length,
                  ),
                ),
                SizedBox(height: 20),
                // Summary Section
                cartModel == null
                    ? Container()
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Sub-Total: ',
                              style: TextStyle(
                                fontSize: 14,
                                color: grayTextColor,
                              ),
                            ),
                            SizedBox(width: 80),
                            Text(
                              '${cartModel.data?.totalPrice ?? 0} EGP',
                              style: TextStyle(
                                fontSize: 14,
                                color: grayTextColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Shipping Fees',
                              style: TextStyle(
                                fontSize: 14,
                                color: grayTextColor,
                              ),
                            ),
                            SizedBox(width: 60),
                            Text(
                              '0 EGP',
                              style: TextStyle(
                                fontSize: 14,
                                color: grayTextColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 221,
                          height: 1,
                          color: primaryColor,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 80),
                            Text(
                              '${(cartModel.data?.totalPrice ?? 0) + 0} EGP',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),
                customButton(
                  title: 'Check out',
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckOutScreen()));
                  },
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCartItem(CartItem cartItem, Product product) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 164,
        height: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25), // Shadow color
              blurRadius: 4, // Softening the shadow
              spreadRadius: 0.5, // Extending the shadow
              offset: Offset(0, 0), // No offset to center the shadow
            ),
          ],
        ),
        child: Padding(
          padding:
          const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 85,
                child: Image.network(domain +
                    (product.productImages.isNotEmpty
                        ? product.productImages[0].image
                        : '')), // Use a default image or placeholder if empty
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'PoppinsBold',
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'store: ${product.storeId}', // Store name from product data
                    style: TextStyle(
                      fontSize: 10,
                      color: grayTextColor,
                    ),
                  ),
                  Text(
                    '${product.price} EGP',
                    style: TextStyle(
                      fontSize: 10,
                      color: grayTextColor,
                      decoration: TextDecoration
                          .lineThrough, // Strike-through for old price
                    ),
                  ),
                  Text(
                    '${product.saleAmount ?? product.price} EGP',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      int newQuantity = cartItem.quantity - 1;
                      print(newQuantity);
                      // Check if the new quantity exceeds the available stock
                      if (newQuantity <= product.quantity) {
                        HomeCubit.get(context).updateProductQuantityFromCart(
                            product.id, newQuantity);
                      } else {
                        // Optionally, you can show a message to the user indicating the stock limit
                        print('Cannot add more than available stock.');
                      }
                    },
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: primaryColor,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          size: 12,
                          color: primaryColor,
                        ),
                      ),
                      // child: IconButton(
                      //   onPressed: () {
                      //     int newQuantity = cartItem.quantity-1;
                      //     print(newQuantity);
                      //     // Check if the new quantity exceeds the available stock
                      //     if (newQuantity <= product.quantity) {
                      //       HomeCubit.get(context).updateProductQuantityFromCart(product.id,newQuantity );
                      //     } else {
                      //       // Optionally, you can show a message to the user indicating the stock limit
                      //       print('Cannot add more than available stock.');
                      //     }
                      //   },
                      //   icon: Icon(
                      //     Icons.remove,
                      //     size: 20,
                      //     color: primaryColor,
                      //   ),
                      // ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('${cartItem.quantity}'), // Display cart item quantity
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      int newQuantity = cartItem.quantity + 1;
                      print(newQuantity);
                      // Check if the new quantity exceeds the available stock
                      if (newQuantity <= product.quantity) {
                        HomeCubit.get(context).updateProductQuantityFromCart(
                            product.id, newQuantity);
                      } else {
                        // Optionally, you can show a message to the user indicating the stock limit
                        print('Cannot add more than available stock.');
                      }
                    },
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: primaryColor,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 12,
                          color: primaryColor,
                        ),
                      ),
                      // child: IconButton(
                      //   onPressed: () {
                      //     int newQuantity = cartItem.quantity-1;
                      //     print(newQuantity);
                      //     // Check if the new quantity exceeds the available stock
                      //     if (newQuantity <= product.quantity) {
                      //       HomeCubit.get(context).updateProductQuantityFromCart(product.id,newQuantity );
                      //     } else {
                      //       // Optionally, you can show a message to the user indicating the stock limit
                      //       print('Cannot add more than available stock.');
                      //     }
                      //   },
                      //   icon: Icon(
                      //     Icons.remove,
                      //     size: 20,
                      //     color: primaryColor,
                      //   ),
                      // ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
