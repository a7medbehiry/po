import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/components/constant.dart';

import '../../components/widget.dart';
import '../../model/store_model/all_store_model.dart';
import '../../view_model/home_cubit/cubit.dart';
import '../../view_model/home_cubit/states.dart';
import '../authentication/sign_in_screen.dart';



class StoresDetailsScreen extends StatefulWidget {
  final Store store;
  const StoresDetailsScreen({Key? key, required this.store}) : super(key: key);

  @override
  State<StoresDetailsScreen> createState() => _StoresDetailsScreenState();
}

class _StoresDetailsScreenState extends State<StoresDetailsScreen> {
  late Store store;

  @override
  void initState() {
    super.initState();
    store = widget.store;
    HomeCubit.get(context).getAllStore();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context,state){
        if(state is AddToCartSuccessState){
          showToast(message: 'Product Adding to Cart ',color: Colors.green);
        }
      },
      builder:(context,state){
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            HomeCubit.get(context).getAllStore();
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
                        SizedBox(width: 5),
                        Container(
                          width: 35,
                          height: 29,
                          child: Image.network(domain + '${store.picture}'),
                        ),
                        SizedBox(width: 5),
                        Text(
                          store.name,
                          style: TextStyle(fontSize: 20, fontFamily: 'PoppinsBold'),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    buildCategoryList(),
                  ],
                ),
              ),
            ),
          ),
        );
      } ,
    );
  }

  Widget buildCategoryList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var category in store.categories) ...[
          Text(
            category.name,
            style: TextStyle(fontSize: 18, fontFamily: 'PoppinsBold'),
          ),
          SizedBox(height: 15),
          Container(
            height: 210,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => buildProductItem(category.products[index]),
              separatorBuilder: (context, index) => SizedBox(width: 10),
              itemCount: category.products.length,
            ),
          ),
          SizedBox(height: 25),
        ],
      ],
    );
  }

  Widget buildProductItem(Product product) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 164,
        height: 190,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 90,
                child: Image.network(domain+product.productImages[0].image), // Adjust path if necessary
              ),
              SizedBox(height: 5),
              Text(
                product.name,
                style: TextStyle(fontSize: 12, fontFamily: 'PoppinsBold'),
              ),
              SizedBox(height: 5),
              Text(
                'Store: ${product.storeId}',
                style: TextStyle(fontSize: 10, color: grayTextColor),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '${product.price} EGP',
                        style: TextStyle(
                          fontSize: 10,
                          color: grayTextColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        '${product.saleAmount ?? product.price} EGP',
                        style: TextStyle(fontSize: 12, fontFamily: 'PoppinsBold'),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){

                      if(userToken!=''){
                        print('add to cart');
                        HomeCubit.get(context).addToCart(product.id, 1);
                      }else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Guest User'),
                              content: Text('You are currently logged in as a guest. Please log in to book a visit.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignInScreen(), // Navigate to the login screen
                                      ),
                                    );
                                  },
                                  child: Text('Login'),
                                ),
                              ],
                            );
                          },
                        );
                      }


                    },
                    child: Container(
                      width: 81,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          'Add to cart',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
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
