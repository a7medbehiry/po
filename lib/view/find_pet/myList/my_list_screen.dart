import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/constant.dart';
import '../../../components/widget.dart';
import '../../../model/find_pet_model/get_my_found_pets_model.dart';
import '../../../model/find_pet_model/get_my_lost_pets_model.dart';
import '../../../view_model/home_cubit/cubit.dart';
import '../../../view_model/home_cubit/states.dart';


class MyListScreen extends StatefulWidget {
  const MyListScreen({Key? key}) : super(key: key);

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {

  Widget buildLostItem(LostPet pet) {
    return Container(
      width: 164,
      height: 200,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 106,
                  child: Image.network(domain+pet.lostPetGallery[0].image),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      //Cross-Square
                      GestureDetector(
                        onTap: (){
                          HomeCubit.get(context).deleteLostPet(pet.id);
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          child: Image.asset('assets/images/Cross-Square.png'),
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        child: Image.asset('assets/images/lost.png'),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  pet.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'PoppinsBold',
                  ),
                ),
                Spacer(),
                Text(
                  pet.age.toString(),
                  style: TextStyle(
                    fontSize: 10,
                    color: grayTextColor,
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: 24,
                  height: 24,
                  child: pet.gender=='female'?Image.asset('assets/images/female.png'):Image.asset('assets/images/male.png'),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              pet.breed,
              style: TextStyle(
                fontSize: 12,
                color: grayTextColor,
              ),
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: primaryColor, size: 15),
                Expanded(
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    pet.lastSeenLocation,
                    style: TextStyle(
                      fontSize: 11,
                      color: grayTextColor,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.watch_later_outlined, color: primaryColor, size: 13),
                SizedBox(
                  width: 3,
                ),
                Text(
                  pet.lastSeenTime,
                  style: TextStyle(
                    fontSize: 11,
                    color: grayTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



  Widget buildFoundItem(FoundPet pet) {
    return Container(
      width: 164,
      height: 200,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 106,
                  child: Image.network(domain+pet.foundPetGallery[0].image),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      //Cross-Square
                      GestureDetector(
                        onTap: (){
                          HomeCubit.get(context).deleteFoundPet(pet.id);
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          child: Image.asset('assets/images/Cross-Square.png'),
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        child: Image.asset('assets/images/found.png'),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  pet.type,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'PoppinsBold',
                  ),
                ),
                Spacer(),
                SizedBox(width: 5),
                Container(
                  width: 24,
                  height: 24,
                  child: pet.gender=='female'?Image.asset('assets/images/female.png'):Image.asset('assets/images/male.png'),
                ),
              ],
            ),
            SizedBox(height: 5),

            Row(
              children: [
                Icon(Icons.location_on_outlined, color: primaryColor, size: 15),
                Expanded(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    pet.foundLocation,
                    style: TextStyle(
                      fontSize: 11,
                      color: grayTextColor,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.watch_later_outlined, color: primaryColor, size: 13),
                SizedBox(
                  width: 3,
                ),
                Text(
                  pet.foundTime,
                  style: TextStyle(
                    fontSize: 11,
                    color: grayTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeCubit.get(context).getMyLostPets();
  }
  @override
  Widget build(BuildContext context) {
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
                        HomeCubit.get(context).getFoundPets();
                      },
                      child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border:
                              Border.all(color: primaryColor, width: 2)),
                          child: Center(
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 10,
                                color: primaryColor,
                              ))),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'My List',
                      style: TextStyle(fontSize: 20, fontFamily: 'PoppinsBold'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    buildItem(
                      home:()=>HomeCubit.get(context).getMyLostPets(),
                      title: 'Lost',
                      color: Color.fromRGBO(255,219,229, 1),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    buildItem(
                      home:()=>HomeCubit.get(context).getMyFoundPets(),
                      title: 'Found',
                      color: Color.fromRGBO(225,253,240, 1),
                    ),


                  ],
                ),


                SizedBox(
                  height: 20,
                ),
                selectedType=='Lost'
                    ?
                lost()
                    :
                Container(),


                selectedType=='Found'
                    ?
                found()
                    :
                Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //initialization
  String selectedType = 'Lost';

  Widget buildItem({
    required String title,
    required Color color,
    required Function home

  }){

    bool isSelected = selectedType == title; // Check if this animal type is selected

    return Expanded(
      child: GestureDetector(
        onTap: (){
          setState(() {
            home();
            selectedType = title;
          });
        },
        child: Container(
          height: 37,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: isSelected?Colors.black:Colors.transparent
              )
          ),
          child: Center(
            child: Text(title,style: TextStyle(
                fontSize: 16
            ),),
          ),
        ),
      ),
    );
  }


  Widget lost(){
    return Column(
      children: [
        BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is GetMyLostPetsErrorState) {
              showToast(message: 'No result', color: Colors.red);
            }
          },
          builder: (context, state){
            if (state is GetMyLostPetsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if(state is GetMyLostPetsSuccessState){

              var lostPets = HomeCubit.get(context).getMyLostPetsModel?.lostPets?? [];

              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: lostPets.length,
                padding: EdgeInsets.all(2),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.80, // Adjust the aspect ratio as needed
                ),
                itemBuilder: (context, index) {
                  return buildLostItem(lostPets[index]);
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

        ),
        // GridView.builder(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemCount: lostPets.length,
        //   padding: EdgeInsets.all(2),
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2, // Number of columns
        //     crossAxisSpacing: 10.0,
        //     mainAxisSpacing: 10.0,
        //     childAspectRatio: 0.80, // Adjust the aspect ratio as needed
        //   ),
        //   itemBuilder: (context, index) {
        //     return buildLostItem(lostPets[index]);
        //   },
        // ),

      ],
    );
  }

  Widget found(){
    return  Column(
      children: [
        BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is GetMyFoundPetsErrorState) {
              showToast(message: 'No result', color: Colors.red);
            }
          },
          builder: (context, state){
            if (state is GetMyFoundPetsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if(state is GetMyFoundPetsSuccessState){

              var foundPets = HomeCubit.get(context).getMyFoundPetsModel?.foundPets?? [];


              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: foundPets.length,
                padding: EdgeInsets.all(2),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.80, // Adjust the aspect ratio as needed
                ),
                itemBuilder: (context, index) {
                  return buildFoundItem(foundPets[index]);
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

        ),

      ],
    );
  }
}
