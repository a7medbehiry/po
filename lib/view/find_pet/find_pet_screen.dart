import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/chat/chats.dart';
import 'package:pet_app/view/notification/notification_view.dart';
import 'package:pet_app/view/profile/data/models/user_profile_models/profile_get_data_model/profile_get_data_model.dart';
import 'package:pet_app/view/profile/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import '../../components/widget.dart';
import '../../model/find_pet_model/get_found_pets_model.dart';
import '../../model/find_pet_model/get_lost_pets_model.dart';
import '../../view_model/home_cubit/cubit.dart';
import '../../view_model/home_cubit/states.dart';
import '../authentication/sign_in_screen.dart';
import '../profile/profile_view.dart';
import 'find_pet_found_details.dart';
import 'find_pet_lost_details.dart';
import 'find_your_lost_pet.dart';
import 'found_pet_report.dart';
import 'myList/my_list_screen.dart';

class FindPetScreen extends StatefulWidget {
  FindPetScreen({Key? key}) : super(key: key);

  @override
  State<FindPetScreen> createState() => _FindPetScreenState();
}

class _FindPetScreenState extends State<FindPetScreen> {
  Widget buildLostItem(LostPet pet) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FindPetLostDetails(
                  pet: pet,
                )));
      },
      child: Container(
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
                    child: Image.network(domain + pet.lostPetGallery[0].image,
                        fit: BoxFit.contain),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                    pet.age.toString()+' year',
                    style: TextStyle(
                      fontSize: 10,
                      color: grayTextColor,
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    width: 24,
                    height: 24,
                    child: pet.gender == 'female'
                        ? Image.asset('assets/images/female.png')
                        : Image.asset('assets/images/male.png'),
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
                  Icon(Icons.location_on_outlined,
                      color: primaryColor, size: 15),
                  Expanded(
                    child: Text(
                      pet.lastSeenLocation,
                      style: TextStyle(
                        fontSize: 11,
                        color: grayTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.watch_later_outlined,
                      color: primaryColor, size: 13),
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
      ),
    );
  }

  Widget buildFoundItem(FoundPet pet) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FindPetFoundDetails(
                  pet: pet,
                )));
      },
      child: Container(
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
                    child: Image.network(
                      domain + pet.foundPetGallery[0].image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                    pet.gender,
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
                    child: pet.gender == 'female'
                        ? Image.asset('assets/images/female.png')
                        : Image.asset('assets/images/male.png'),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      color: primaryColor, size: 15),
                  Expanded(
                    child: Text(
                      pet.foundLocation,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
                  Icon(Icons.watch_later_outlined,
                      color: primaryColor, size: 13),
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
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeCubit.get(context).getLostPets();
    GetProfileDataCubit.get(context).userGetProfileData();
  }

  ProfileGetDataModel? profileGetDataModel;

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
                                  builder: (context) => const Chats(),
                                ),
                              );

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
                            child: Image.asset('assets/images/chat.png'),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {

                            if(userToken!='') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NotificationView(),
                                ),
                              );
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
                            child: Image.asset('assets/images/noti.png'),
                          ),
                        ),
                      ],
                    ),


                    SizedBox(
                      height: 30,
                    ),
                    //Search

                    SizedBox(
                      height: 10,
                    ),

                    selectedType == 'Lost'
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FindYourLostPet()));
                            },
                            child: Text(
                              'List a lost pet',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                              ),
                            )),
                      ],
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FoundPetReport()));
                            },
                            child: Text(
                              'List a found pet',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                              ),
                            )),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        buildItem(
                          home: () => HomeCubit.get(context).getLostPets(),
                          title: 'Lost',
                          color: Color.fromRGBO(255, 219, 229, 1),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        buildItem(
                          home: () => HomeCubit.get(context).getFoundPets(),
                          title: 'Found',
                          color: Color.fromRGBO(225, 253, 240, 1),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyListScreen()));
                            },
                            child: Container(
                              height: 37,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 246, 210, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'My list',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    selectedType == 'Lost' ? lost() : Container(),

                    selectedType == 'Found' ? found() : Container(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //initialization
  String selectedType = 'Lost';

  Widget buildItem(
      {required String title, required Color color, required Function home}) {
    bool isSelected =
        selectedType == title; // Check if this animal type is selected

    return Expanded(
      child: GestureDetector(
        onTap: () {
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
                  color: isSelected ? Colors.black : Colors.transparent)),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget lost() {
    return Column(
      children: [
        BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is GetLostPetsErrorState) {
              showToast(message: 'No result', color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is GetLostPetsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetLostPetsSuccessState) {
              var lostPets =
                  HomeCubit.get(context).getLostPetsModel?.lostPets ?? [];

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
      ],
    );
  }

  Widget found() {
    return Column(
      children: [
        BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is GetFoundPetsErrorState) {
              showToast(message: 'No result', color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is GetFoundPetsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetFoundPetsSuccessState) {
              var foundPets =
                  HomeCubit.get(context).getFoundPetsModel?.foundPets ?? [];

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
