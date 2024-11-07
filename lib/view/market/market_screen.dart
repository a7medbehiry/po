import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/components/widget.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/chat/chats.dart';
import 'package:pet_app/view/notification/notification_view.dart';
import 'package:pet_app/view/profile/data/models/user_profile_models/profile_get_data_model/profile_get_data_model.dart';
import 'package:pet_app/view/profile/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:pet_app/view_model/home_cubit/states.dart';

import '../../model/market_model/get_market_filter.dart';
import '../../view_model/home_cubit/cubit.dart';
import '../authentication/sign_in_screen.dart';
import '../profile/profile_view.dart';
import 'list_your_pet.dart';
import 'market_pet_profile.dart';

class MarketScreen extends StatefulWidget {
  MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {


  Widget buildPetItem(Pet pet, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MarketPetProfile(
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
                    child: pet.picture == null
                        ? Image.asset(
                      'assets/images/default.jpg',
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                      domain + pet.picture!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  pet.forAdoption == false
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 60,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          pet.price + ' EGP',
                          style: TextStyle(
                              fontSize: 10, fontFamily: 'PoppinsBold'),
                        ),
                      ),
                    ),
                  )
                      : Container(),
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
                    (pet.age).toString() + ' year',
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
                pet.breed ?? 'unknown breed',
                style: TextStyle(
                  fontSize: 12,
                  color: grayTextColor,
                ),
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      color: primaryColor, size: 15),
                  Expanded(
                    child: Text(
                      pet.user.address ?? 'unknown breed',
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
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor),
                child: Center(
                  child: pet.forAdoption == true
                      ? Text(
                    'Adopt Now',
                    style: TextStyle(color: Colors.white),
                  )
                      : Text(
                    'Buy Now',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int selectedIndex = 0;

  void _selectAnimal(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeCubit.get(context).getMarketFilter(type: 'dog');
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
          key: _scaffoldKey,
          endDrawer: SearchDrawer(),
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
                    Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: GestureDetector(
                          onTap: () {
                            print('ddd');
                            _scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: grayTextColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Search here',
                                style: TextStyle(
                                    fontSize: 14, color: grayTextColor),
                              ),
                              Spacer(),
                              Container(
                                width: 24,
                                height: 24,
                                child: Image.asset('assets/images/Filter.png'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    //categories
                    Text(
                      'Categories',
                      style: TextStyle(fontSize: 18, fontFamily: 'PoppinsBold'),
                    ),

                    SizedBox(
                      height: 16,
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          AnimalSelector(
                            image: 'assets/images/Dog Face.png',
                            name: 'Dogs',
                            isSelected: selectedIndex == 0,
                            onSelect: () {
                              _selectAnimal(0);
                              HomeCubit.get(context)
                                  .getMarketFilter(type: 'dog');
                            },
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          AnimalSelector(
                              image: 'assets/images/CatFace.png',
                              name: 'Cats',
                              isSelected: selectedIndex == 1,
                              onSelect: () {
                                _selectAnimal(1);
                                HomeCubit.get(context)
                                    .getMarketFilter(type: 'cat');
                              }),
                          SizedBox(
                            width: 15,
                          ),
                          AnimalSelector(
                              image: 'assets/images/Fish.png',
                              name: 'Fish',
                              isSelected: selectedIndex == 2,
                              onSelect: () {
                                _selectAnimal(2);
                                HomeCubit.get(context)
                                    .getMarketFilter(type: 'fishe');
                              }),
                          SizedBox(
                            width: 15,
                          ),
                          AnimalSelector(
                              image: 'assets/images/BabyChick.png',
                              name: 'Bird',
                              isSelected: selectedIndex == 3,
                              onSelect: () {
                                _selectAnimal(3);
                                HomeCubit.get(context)
                                    .getMarketFilter(type: 'bird');
                              }),
                          SizedBox(
                            width: 15,
                          ),
                          AnimalSelector(
                              image: 'assets/images/Turtle.png',
                              name: 'Turtle',
                              isSelected: selectedIndex == 4,
                              onSelect: () {
                                _selectAnimal(4);
                                HomeCubit.get(context)
                                    .getMarketFilter(type: 'turtle');
                              }),
                          SizedBox(
                            width: 15,
                          ),
                          AnimalSelector(
                              image: 'assets/images/Monkey.png',
                              name: 'Monkey',
                              isSelected: selectedIndex == 5,
                              onSelect: () {
                                _selectAnimal(5);
                                HomeCubit.get(context)
                                    .getMarketFilter(type: 'monkey');
                              }),
                          SizedBox(
                            width: 15,
                          ),
                          AnimalSelector(
                              image: 'assets/images/Rabbit.png',
                              name: 'Rabbit',
                              isSelected: selectedIndex == 6,
                              onSelect: () {
                                _selectAnimal(6);
                                HomeCubit.get(context)
                                    .getMarketFilter(type: 'rabbit');
                              }),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Row(
                      children: [
                        Text(
                          'Find New Buddies',
                          style: TextStyle(
                              fontSize: 18, fontFamily: 'PoppinsBold'),
                        ),
                        Spacer(),
                        customTextButton(
                            title: 'List your pet',
                            function: () {
                              if(userToken!=''){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListYourPet()));

                              }else{
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
                            })
                      ],
                    ),

                    SizedBox(
                      height: 16,
                    ),

                    // BlocConsumer to update GridView when type changes
                    BlocConsumer<HomeCubit, HomeStates>(
                      listener: (context, state) {
                        if (state is GetMarketErrorState) {
                          showToast(message: 'No result', color: Colors.red);
                        }
                      },
                      builder: (context, state) {
                        if (state is GetMarketLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetMarketSuccessState) {
                          var pets = HomeCubit.get(context)
                              .getMarketFilterModel
                              ?.pets ??
                              [];

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: pets.length,
                            padding: EdgeInsets.all(2),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 0.70,
                            ),
                            itemBuilder: (context, index) {
                              return buildPetItem(pets[index], context);
                            },
                          );
                        } else {
                          // Initial or other states
                          return Container(
                            child: Center(
                                child: Text(
                                  'No result',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'PoppinsBold',
                                      color: Colors.red),
                                )),
                          ); // Placeholder or empty state
                        }
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

class AnimalSelector extends StatefulWidget {
  final String image;
  final String name;
  final bool isSelected;
  final VoidCallback onSelect;

  AnimalSelector({
    required this.image,
    required this.name,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  _AnimalSelectorState createState() => _AnimalSelectorState();
}

class _AnimalSelectorState extends State<AnimalSelector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: Column(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.isSelected ? primaryColor : Colors.transparent,
                width: 3.0,
              ),
            ),
            child: ClipOval(
              child: Image.asset(widget.image),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.name,
            style: const TextStyle(fontSize: 16, fontFamily: 'PoppinsBold'),
          ),
        ],
      ),
    );
  }
}

class SearchDrawer extends StatefulWidget {
  @override
  State<SearchDrawer> createState() => _SearchDrawerState();
}

class _SearchDrawerState extends State<SearchDrawer> {
  late String petName, age;

  String type = 'dog';

  String gender = 'male';
  String purpose = 'For adoption';

  bool isMale = true;
  bool isadoption = true;
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: secondColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Filter ',
                  style: TextStyle(fontSize: 20, fontFamily: 'PoppinsBold'),
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  'Pet Type',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    chooseType(
                      name: 'dog',
                      onSelected: (value) {
                        type = value;
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    chooseType(
                      name: 'fishe',
                      onSelected: (value) {
                        type = value;
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    chooseType(
                      name: 'monkey',
                      onSelected: (value) {
                        type = value;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    chooseType(
                      name: 'turtle',
                      onSelected: (value) {
                        type = value;
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    chooseType(
                      name: 'bird',
                      onSelected: (value) {
                        type = value;
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    chooseType(
                      name: 'cat',
                      onSelected: (value) {
                        type = value;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'Choose Breed',
                          style: TextStyle(fontSize: 14, color: grayTextColor),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_down_rounded),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Gender',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Row(children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isMale = true;
                              gender = 'male';
                            });
                          },
                          icon: isMale
                              ? Icon(
                            Icons.radio_button_checked,
                            color: primaryColor,
                          )
                              : const Icon(Icons.radio_button_off_outlined)),
                      const Text('male')
                    ]),
                    const SizedBox(
                      width: 30,
                    ),
                    Row(children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isMale = false;
                              gender = 'female';
                            });
                          },
                          icon: !isMale
                              ? Icon(
                            Icons.radio_button_checked,
                            color: primaryColor,
                          )
                              : const Icon(Icons.radio_button_off_outlined)),
                      const Text('female')
                    ]),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Age',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      controller: ageController,
                      decoration: InputDecoration(
                        hintText: '3 Years',
                        hintStyle: TextStyle(
                          color: grayTextColor,
                        ),
                        border: InputBorder.none, // Removes the underline
                        contentPadding:
                        EdgeInsets.zero, // Optional: Removes extra padding
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Purpose',
                  style: TextStyle(fontSize: 16),
                ),

                Row(
                  children: [
                    Row(children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isadoption = true;
                              purpose = 'For adoption';
                            });
                          },
                          icon: isadoption
                              ? Icon(
                            Icons.radio_button_checked,
                            color: primaryColor,
                          )
                              : const Icon(Icons.radio_button_off_outlined)),
                      const Text('For adoption')
                    ]),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isadoption = false;
                              purpose = 'For sale';
                            });
                          },
                          icon: !isadoption
                              ? Icon(
                            Icons.radio_button_checked,
                            color: primaryColor,
                          )
                              : const Icon(Icons.radio_button_off_outlined)),
                      const Text('For sale')
                    ]),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          print(type);
                          print(gender);
                          print(ageController.text);
                          print(purpose);
                          HomeCubit.get(context).getMarketFilter(
                              type: type,
                              gender: gender,
                              age: ageController.text,
                              adaption:
                              purpose == 'For adoption' ? true : false);
                          //ageController
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor),
                          child: Center(
                            child: Text(
                              'Done',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primaryColor)),
                        child: Center(
                          child: Text(
                            'Clear',
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Add more ListTiles or other widgets as needed
              ],
            ),
          ),
        ),
      ),
    );
  }

  //initialization
  String selectedType = 'dog';

  Widget chooseType(
      {required String name, required ValueChanged<String> onSelected}) {
    bool isSelected =
        selectedType == name; // Check if this animal type is selected

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = name;
          onSelected(selectedType);
        });
      },
      child: Container(
        width: 61,
        height: 37,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? secondColor : Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25), // Shadow color
              blurRadius: 4, // Softening the shadow
              spreadRadius: 0.5, // Extending the shadow
              offset: Offset(0, 0), // No offset to center the shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
