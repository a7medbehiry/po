import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/components/widget.dart';
import 'package:pet_app/model/get_breed_model.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/authentication/manager/get_breed_cubit/get_breed_cubit.dart';
import 'package:pet_app/view/chat/chats.dart';

import '../../model/home_model/get_search_filter_model.dart';
import '../authentication/sign_in_screen.dart';

class PetDatingProfile extends StatefulWidget {
  final Dog pet;
  PetDatingProfile({Key? key, required this.pet}) : super(key: key);

  @override
  State<PetDatingProfile> createState() => _PetDatingProfileState();
}

class _PetDatingProfileState extends State<PetDatingProfile> {
  double hightContainerLifeExpectancy = 40;
  double hightContainerwight = 40;

  double hightContainerHeight = 40;
  double hightContainerPhysicalcharacteristcs = 40;

  bool isOpen1 = false;
  bool isOpen2 = false;
  bool isOpen3 = false;
  bool isOpen4 = false;

  GetBreedModel? getBreedModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetBreedCubit()..userGetBreed(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 296,
                          child: widget.pet.picture == null
                              ? Image.asset(
                            'assets/images/default.jpg',
                            fit: BoxFit.cover,
                          )
                              : Image.network(
                            domain + widget.pet.picture!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  child: Image.asset(
                                      'assets/images/ArrowBack.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                //categories

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.pet.name,
                            style: TextStyle(
                                fontSize: 32, fontFamily: 'PoppinsBold'),
                          ),
                          Spacer(),
                          Text(
                            widget.pet.breed ?? 'unknown breed',
                            style:
                            TextStyle(fontSize: 16, color: grayTextColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 41,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 219, 229, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  widget.pet.gender == 'female'
                                      ? Image.asset('assets/images/female.png')
                                      : Image.asset('assets/images/male.png'),
                                  // Image.asset('widget.pet.genderIcon'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.pet.gender,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 41,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 246, 210, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 24,
                                      height: 24,
                                      child: Icon(
                                        Icons.cake_outlined,
                                        color: Color.fromRGBO(249, 175, 196, 1),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    (widget.pet.age).toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),

                            //https://captain-drive.webbing-agency.com/storage/app/public/$%7BcaptainGetDataModel?.data?.user?.picture
                            child: widget.pet.user.picture == null
                                ? Image.asset(
                              'assets/images/owner.jfif',
                              fit: BoxFit.contain,
                            )
                                : Image.network(
                                domain + '${widget.pet.user.picture}'),
                            // child: Image.asset('assets/images/owner.png',fit: BoxFit.fill,),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.pet.user.firstName,
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Pet Owner',
                                style: TextStyle(
                                    fontSize: 14, color: grayTextColor),
                              )
                            ],
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined,
                                  color: primaryColor, size: 15),
                              Text(
                                widget.pet.user.address,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: grayTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PetGalleryWidget(
                        petGallery: widget.pet.petGallery, // Ensure this is List<PetGallery>
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<GetBreedCubit, GetBreedState>(
                        listener: (context, state) {
                          if (state is GetBreedSuccess) {
                            if (state.getBreedModel.status) {
                              setState(() {
                                getBreedModel = state.getBreedModel;
                                // Update the breed options based on the selected type
                              });
                              print(CacheHelper.getData(key: 'token'));
                              print(CacheHelper.getData(key: 'id'));
                            } else {
                              print(state.getBreedModel.message);

                              showToast(
                                message: state.getBreedModel.message,
                                color: Colors.red,
                              );
                            }
                          } else if (state is GetBreedFailure) {
                            showToast(
                              message: state.message,
                              color: Colors.red,
                            );
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'About Breed',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'PoppinsBold'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: isOpen1 ? 82 : 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(
                                            0, 0, 0, 0.25), // Shadow color
                                        blurRadius: 4, // Softening the shadow
                                        spreadRadius:
                                        0.5, // Extending the shadow
                                        offset: Offset(0,
                                            0), // No offset to center the shadow
                                      ),
                                    ],
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Life Expectancy',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: primaryColor),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isOpen1 = !isOpen1;
                                              });
                                              print('${isOpen1}');
                                            },
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              child: isOpen1
                                                  ? Image.asset(
                                                  'assets/images/ArrowU.png')
                                                  : Image.asset(
                                                  'assets/images/ArrowD.png'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      isOpen1
                                          ?  Text(
                                        '${widget.pet.breedInfo?.lifeExpectancy}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black),
                                      )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: isOpen2 ? 82 : 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(
                                            0, 0, 0, 0.25), // Shadow color
                                        blurRadius: 4, // Softening the shadow
                                        spreadRadius:
                                        0.5, // Extending the shadow
                                        offset: Offset(0,
                                            0), // No offset to center the shadow
                                      ),
                                    ],
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'weight',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: primaryColor),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isOpen2 = !isOpen2;
                                              });
                                              print('${isOpen2}');
                                            },
                                            child: SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: isOpen2
                                                  ? Image.asset(
                                                  'assets/images/ArrowU.png')
                                                  : Image.asset(
                                                  'assets/images/ArrowD.png'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      isOpen2
                                          ?  Text(
                                        '${widget.pet.breedInfo?.weight}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.start,
                                      )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: isOpen3 ? 82 : 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(
                                            0, 0, 0, 0.25), // Shadow color
                                        blurRadius: 4, // Softening the shadow
                                        spreadRadius:
                                        0.5, // Extending the shadow
                                        offset: Offset(0,
                                            0), // No offset to center the shadow
                                      ),
                                    ],
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Height',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: primaryColor),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isOpen3 = !isOpen3;
                                              });
                                              print('${isOpen3}');
                                            },
                                            child: SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: isOpen3
                                                  ? Image.asset(
                                                  'assets/images/ArrowU.png')
                                                  : Image.asset(
                                                  'assets/images/ArrowD.png'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      isOpen3
                                          ?  Text(
                                        '${widget.pet.breedInfo?.height}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.start,
                                      )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: isOpen4 ? 265 : 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(
                                            0, 0, 0, 0.25), // Shadow color
                                        blurRadius: 4, // Softening the shadow
                                        spreadRadius:
                                        0.5, // Extending the shadow
                                        offset: Offset(0,
                                            0), // No offset to center the shadow
                                      ),
                                    ],
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Physical characteristcs',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: primaryColor),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isOpen4 = !isOpen4;
                                              });
                                              print('${isOpen4}');
                                            },
                                            child: SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: isOpen4
                                                  ? Image.asset(
                                                  'assets/images/ArrowU.png')
                                                  : Image.asset(
                                                  'assets/images/ArrowD.png'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      isOpen4
                                          ? Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${widget.pet.breedInfo?.physicalCharacteristics}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          // const SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 8,
                                          // ),
                                          // const Text(
                                          //   'Coat Grooming Frequency',
                                          //   style: TextStyle(
                                          //     fontSize: 12,
                                          //     color: Colors.black,
                                          //   ),
                                          //   textAlign: TextAlign.start,
                                          // ),
                                          // const SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 8,
                                          // ),
                                          // const Text(
                                          //   'Drooling Level',
                                          //   style: TextStyle(
                                          //     fontSize: 12,
                                          //     color: Colors.black,
                                          //   ),
                                          //   textAlign: TextAlign.start,
                                          // ),
                                          // const SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Container(
                                          //         height: 8,
                                          //         width: 32,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         10),
                                          //             color:
                                          //                 primaryColor),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 8,
                                          // ),
                                          // const Text(
                                          //   'Coat Type',
                                          //   style: TextStyle(
                                          //     fontSize: 12,
                                          //     color: Colors.black,
                                          //   ),
                                          //   textAlign: TextAlign.start,
                                          // ),
                                          // const SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Row(
                                          //         children: [
                                          //           Icon(
                                          //             Icons.close_rounded,
                                          //             color:
                                          //                 grayTextColor,
                                          //             size: 15,
                                          //           ),
                                          //           Text(
                                          //             'Curly',
                                          //             style: TextStyle(
                                          //                 fontSize: 10,
                                          //                 color:
                                          //                     grayTextColor),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Row(
                                          //         children: [
                                          //           Icon(
                                          //             Icons.close_rounded,
                                          //             color:
                                          //                 grayTextColor,
                                          //             size: 15,
                                          //           ),
                                          //           Text(
                                          //             'Rough',
                                          //             style: TextStyle(
                                          //                 fontSize: 10,
                                          //                 color:
                                          //                     grayTextColor),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Row(
                                          //         children: [
                                          //           Icon(
                                          //             Icons.check,
                                          //             color: primaryColor,
                                          //             size: 15,
                                          //           ),
                                          //           Text(
                                          //             'Double',
                                          //             style: TextStyle(
                                          //                 fontSize: 10,
                                          //                 color:
                                          //                     primaryColor),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Row(
                                          //         children: [
                                          //           Icon(
                                          //             Icons.close_rounded,
                                          //             color:
                                          //                 grayTextColor,
                                          //             size: 15,
                                          //           ),
                                          //           Text(
                                          //             'Silky',
                                          //             style: TextStyle(
                                          //                 fontSize: 10,
                                          //                 color:
                                          //                     grayTextColor),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Row(
                                          //         children: [
                                          //           Icon(
                                          //             Icons.close_rounded,
                                          //             color:
                                          //                 grayTextColor,
                                          //             size: 15,
                                          //           ),
                                          //           Text(
                                          //             'Hairless',
                                          //             style: TextStyle(
                                          //                 fontSize: 10,
                                          //                 color:
                                          //                     grayTextColor),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 8,
                                          // ),
                                          // const Text(
                                          //   'Coat Length',
                                          //   style: TextStyle(
                                          //     fontSize: 12,
                                          //     color: Colors.black,
                                          //   ),
                                          //   textAlign: TextAlign.start,
                                          // ),
                                          // const SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Row(
                                          //         children: [
                                          //           Icon(
                                          //             Icons.close_rounded,
                                          //             color:
                                          //                 grayTextColor,
                                          //             size: 15,
                                          //           ),
                                          //           Text(
                                          //             'Short',
                                          //             style: TextStyle(
                                          //                 fontSize: 10,
                                          //                 color:
                                          //                     grayTextColor),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Row(
                                          //         children: [
                                          //           Icon(
                                          //             Icons.check,
                                          //             color: primaryColor,
                                          //             size: 15,
                                          //           ),
                                          //           Text(
                                          //             'Meduim',
                                          //             style: TextStyle(
                                          //                 fontSize: 10,
                                          //                 color:
                                          //                     primaryColor),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.only(
                                          //               right: 8.0),
                                          //       child: Row(
                                          //         children: [
                                          //           Icon(
                                          //             Icons.close_rounded,
                                          //             color:
                                          //                 grayTextColor,
                                          //             size: 15,
                                          //           ),
                                          //           Text(
                                          //             'Long',
                                          //             style: TextStyle(
                                          //                 fontSize: 10,
                                          //                 color:
                                          //                     grayTextColor),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      customButton(
                          title: 'Send a request',
                          function: () {
                            CacheHelper.removeDate(key: 'token');
                            String s =CacheHelper.getData(key: 'token')??'';
                            print('tokennnnnnnnnnnn'+s);
                            if(userToken!=''){
                              showBookingConfirmation(context);
                            }else{
                              // Show an alert dialog for guest users
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
                          }),
                      const SizedBox(
                        height: 300,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBookingConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Stack(
            children: [
              Container(
                height: 223,
                width: double.infinity,
                child: Image.asset('assets/images/back.png'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: primaryColor,
                ),
              ),
              Container(
                height: 223,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Potential Match!',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'PoppinsBold'),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Send a request to start a chat!',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'PoppinsBold'),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Chats(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 150,
                                height: 46,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white),
                                child: Center(
                                  child: Text(
                                    'Send a request',
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 150,
                                height: 46,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: primaryColor,
                                    border: Border.all(color: Colors.white)),
                                child: Center(
                                  child: Text(
                                    'Cancel request',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PetGalleryWidget extends StatelessWidget {
  final List<PetGallery> petGallery;

  PetGalleryWidget({required this.petGallery});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gallery',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'PoppinsBold',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: petGallery.map((item) {
              // Access the 'image' property directly from PetGallery
              final imageUrl = item.image;

              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  width: 106,
                  height: 98,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                    domain + imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error); // Handle errors
                    },
                  )
                      : Image.asset('assets/images/default.jpg'),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
