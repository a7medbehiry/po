import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/profile/data/models/user_profile_models/profile_get_data_model/profile_get_data_model.dart';
import 'package:pet_app/view/profile/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:pet_app/view/stores/cart_screen.dart';
import 'package:pet_app/view/stores/stores_details_screen.dart';

import '../../components/constant.dart';
import '../../components/widget.dart';
import '../../model/store_model/all_offer_model.dart';
import '../../model/store_model/all_store_model.dart';
import '../../view_model/home_cubit/cubit.dart';
import '../../view_model/home_cubit/states.dart';
import '../authentication/sign_in_screen.dart';
import '../profile/profile_view.dart';

class Product {
  final String name;
  final String storeName;
  final String price;
  final String descount;
  final String imageUrl;
  final String offpresent;

  Product(
      {required this.name,
        required this.storeName,
        required this.price,
        required this.descount,
        required this.imageUrl,
        required this.offpresent});
}

class StoresScreen extends StatefulWidget {
  StoresScreen({Key? key}) : super(key: key);

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  ProfileGetDataModel? profileGetDataModel;

  Widget buildProductItem(Offer product) {
    return Container(
      width: 164,
      height: 190,
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 90,
              child: Image.network(domain + product.firstImage.image),
            ),
            SizedBox(height: 5),
            Text(
              product.name,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'PoppinsBold',
              ),
            ),
            SizedBox(height: 5),
            Text(
              'type : ' + product.type,
              style: TextStyle(
                fontSize: 10,
                color: grayTextColor,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      product.price + ' EGP',
                      style: TextStyle(
                        fontSize: 10,
                        color: grayTextColor,
                        decoration: TextDecoration
                            .lineThrough, // Strike-through for old price
                      ),
                    ),
                    Text(
                      product.offer.toString() + ' EGP',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'PoppinsBold',
                      ),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    print('add to cart');
                    HomeCubit.get(context).addToCart(product.id, 1);
                    HomeCubit.get(context).getAllOffer();
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
    );
  }

  Widget buildStoreItem(Store store) {
    return Container(
      width: 164,
      height: 190,
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 112,
              child: Image.network(domain + store.picture!),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoresDetailsScreen(
                          store: store,
                        )));
              },
              child: Container(
                width: double.infinity,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
                child: Center(
                  child: Text(
                    'Go to store',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOffer = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeCubit.get(context).getAllOffer();
    GetProfileDataCubit.get(context).userGetProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetProfileDataCubit, GetProfileDataState>(
      listener: (context, state) {
        if (state is GetProfileDataSuccess) {
          if (state.profileGetDataModel.status!) {
            setState(() {
              profileGetDataModel = state.profileGetDataModel;
              GetProfileDataCubit.get(context).userGetProfileData();
            });
            print(CacheHelper.getData(key: 'token'));
            print(CacheHelper.getData(key: 'id'));
          } else {
            print(state.profileGetDataModel.message);

            showToast(
              message: state.profileGetDataModel.message!,
              color: Colors.red,
            );
          }
          if (state is GetProfileDataFailure) {
            showToast(
              message: state.profileGetDataModel.message!,
              color: Colors.red,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Hider of screen
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if(userToken!='') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileView(),
                                  ));
                            }
                            else{
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
                          child: ClipOval(
                            child:
                            profileGetDataModel?.data?.user?.picture != null
                                ? Image.network(
                              'https://pet-app.webbing-agency.com/storage/app/public/${profileGetDataModel?.data?.user?.picture}',
                              fit: BoxFit.fill,
                              width: 55,
                              height: 55,
                            )
                                : const CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Hi , ',
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'PoppinsBold'),
                        ),
                        userToken==''?
                        Text(
                          profileGetDataModel?.data?.user?.firstName ??
                              'you is Guest',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'PoppinsBold',
                              color: primaryColor),
                        )
                            :
                        Text(
                          profileGetDataModel?.data?.user?.firstName ??
                              'User name',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'PoppinsBold',
                              color: primaryColor),
                        ),

                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 14,
                          height: 14,
                          child: Image.asset('assets/images/Hand.png'),
                        ),
                        Spacer(),


                        GestureDetector(
                          onTap: () {

                            if(userToken!='') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartScreen()));

                            }
                            else{
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
                            width: 24,
                            height: 24,
                            child: Image.asset('assets/images/cart.png'),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    //Search
                    // Container(
                    //   width: double.infinity,
                    //   height: 48,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       border: Border.all(color: primaryColor)),
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 16.0, right: 16),
                    //     child: Row(
                    //       children: [
                    //         Icon(
                    //           Icons.search,
                    //           color: grayTextColor,
                    //         ),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           'Search here',
                    //           style:
                    //           TextStyle(fontSize: 14, color: grayTextColor),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    SizedBox(
                      height: 30,
                    ),

                    //Offers and stores
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                HomeCubit.get(context).getAllOffer();
                                isOffer = true;
                              });
                            },
                            child: Container(
                              height: 37,
                              width: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(255, 219, 229, 1),
                                  border: Border.all(
                                      color: isOffer
                                          ? Colors.black
                                          : Colors.transparent)),
                              child: Center(
                                child: Text(
                                  'Offers',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                HomeCubit.get(context).getAllStore();
                                isOffer = false;
                              });
                            },
                            child: Container(
                              height: 37,
                              width: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(255, 246, 210, 1),
                                  border: Border.all(
                                      color: !isOffer
                                          ? Colors.black
                                          : Colors.transparent)),
                              child: Center(
                                child: Text(
                                  'Stores',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    !isOffer
                        ?

                    //store
                    BlocConsumer<HomeCubit, HomeStates>(
                      listener: (context, state) {
                        if (state is GetStoreErrorState) {
                          showToast(
                              message: 'No result', color: Colors.red);
                          // Handle error state here (show snackbar, dialog, etc.)
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('Error: ${HomeCubit.get(context).getSearchFilterModel?.message ?? 'Unknown error'}')),
                          // );
                        }
                      },
                      builder: (context, state) {
                        if (state is GetStoreLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetStoreSuccessState) {
                          var Stores = HomeCubit.get(context)
                              .getAllStoreModel
                              ?.stores ??
                              [];

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: Stores.length,
                            padding: EdgeInsets.all(2),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio:
                              0.82, // Adjust the aspect ratio as needed
                            ),
                            itemBuilder: (context, index) {
                              return buildStoreItem(Stores[index]);
                            },
                          );
                        }
                        return Container();
                        // return Column(
                        //   children: [
                        //     GridView.builder(
                        //       shrinkWrap: true,
                        //       physics: NeverScrollableScrollPhysics(),
                        //       itemCount: Products.length,
                        //       padding: EdgeInsets.all(2),
                        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //         crossAxisCount: 2, // Number of columns
                        //         crossAxisSpacing: 10.0,
                        //         mainAxisSpacing: 10.0,
                        //         childAspectRatio: 0.82, // Adjust the aspect ratio as needed
                        //       ),
                        //       itemBuilder: (context, index) {
                        //         return buildProductItem(Products[index]);
                        //       },
                        //     ),
                        //   ],
                        // );
                      },
                    )
                        :

                    //offer
                    BlocConsumer<HomeCubit, HomeStates>(
                      listener: (context, state) {
                        if (state is GetOfferErrorState) {
                          showToast(
                              message: 'No result', color: Colors.red);
                        }
                        if (state is AddToCartSuccessState) {
                          showToast(
                              message: 'Product Adding to Cart',
                              color: Colors.green);
                        }
                      },
                      builder: (context, state) {
                        if (state is GetOfferLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetOfferSuccessState) {
                          var offers = HomeCubit.get(context)
                              .getAllOfferModel
                              ?.data
                              ?.offers ?? [];

                          return offers==[]
                              ?
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: offers.length,
                            padding: EdgeInsets.all(2),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio:
                              0.82, // Adjust the aspect ratio as needed
                            ),
                            itemBuilder: (context, index) {
                              return buildProductItem(offers[index]);
                            },
                          )
                              :
                          Container(
                            child: Text('There No Offers At The Moment '),
                          );
                        }
                        return Container(
                          child: Text('There No Offers At The Moment '),
                        );
                        // return Column(
                        //   children: [
                        //     GridView.builder(
                        //       shrinkWrap: true,
                        //       physics: NeverScrollableScrollPhysics(),
                        //       itemCount: Products.length,
                        //       padding: EdgeInsets.all(2),
                        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //         crossAxisCount: 2, // Number of columns
                        //         crossAxisSpacing: 10.0,
                        //         mainAxisSpacing: 10.0,
                        //         childAspectRatio: 0.82, // Adjust the aspect ratio as needed
                        //       ),
                        //       itemBuilder: (context, index) {
                        //         return buildProductItem(Products[index]);
                        //       },
                        //     ),
                        //   ],
                        // );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
