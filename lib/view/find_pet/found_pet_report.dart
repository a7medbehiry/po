import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pet_app/components/constant.dart';
import 'package:image_picker/image_picker.dart'; // Add this dependency

import '../../components/widget.dart';
import '../../view_model/home_cubit/cubit.dart';
import '../../view_model/home_cubit/states.dart';
import '../authentication/sign_in_screen.dart';

class FoundPetReport extends StatefulWidget {
  const FoundPetReport({Key? key}) : super(key: key);

  @override
  State<FoundPetReport> createState() => _FoundPetReportState();
}

class _FoundPetReportState extends State<FoundPetReport> {
  bool isOwner = true;
  bool isMale = true;

  List<String> galleryImages = []; // Initialize with some default images

  final ImagePicker _picker = ImagePicker();

  Future<void> addImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        galleryImages.add(pickedFile.path);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool isGalleryValid = true; // Variable to track if gallery is valid

  late String petName, age, breed, location, time, info,address = '',
      lastAddress = '';

  String type = 'Dog';
  String gender = 'Male';

  void _selectLocation() async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => MapPickerScreen(
    //       onLocationSelected: (location) {
    //         setState(() {
    //           address = location; // Save raw address (lat,long)
    //         });
    //         showAddress(); // Get formatted address here
    //       },
    //     ),
    //   ),
    // );
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        // Build the address string you want
        String formattedAddress = '';
        if (place.locality != null) {
          formattedAddress += place.locality!;
        }
        if (place.subAdministrativeArea != null) {
          formattedAddress += (formattedAddress.isNotEmpty ? '، ' : '') + place.subAdministrativeArea!;
        }
        if (place.administrativeArea != null) {
          formattedAddress += (formattedAddress.isNotEmpty ? '، ' : '') + place.administrativeArea!;
        }
        return formattedAddress; // Return only the desired part
      } else {
        return "No address found";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  void showAddress() async {
    // Original address string
    String address1 = address;

    // Split the string and parse to double
    List<String> latLong = address1.split(',');
    double latitude = double.parse(latLong[0]);
    double longitude = double.parse(latLong[1]);

    // Call the function to get the name of the location
    String locationName = await getAddressFromLatLng(latitude, longitude);
    setState(() {
      lastAddress = locationName; // Update lastAddress to the formatted address
    });

    print("Address: $locationName");
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is SuccessAddFoundPetState) {
            showToast(
                message: 'You are Pet Added Successfully', color: Colors.green);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey, // Attach the key here
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headerOfScreen(
                              title: 'Found pet Reporting',
                              function: () {
                                Navigator.pop(context);
                              }),
                          SizedBox(height: 20),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: customTextFormField(
                          //         title: 'Pet Name',
                          //         onSaved: (value) {
                          //           petName = value!;
                          //         },
                          //       ),
                          //     ),
                          //     const SizedBox(width: 10),
                          //     Expanded(
                          //       child: customTextFormField(
                          //         title: 'Age',
                          //         onSaved: (value) {
                          //           age = value!;
                          //         },
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 20),
                          const Text('Pet Type',
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              chooseType(
                                name: 'Dog',
                                onSelected: (value) {
                                  type = value;
                                },
                              ),
                              chooseType(
                                name: 'Cat',
                                onSelected: (value) {
                                  type = value;
                                },
                              ),
                              chooseType(
                                name: 'Fish',
                                onSelected: (value) {
                                  type = value;
                                },
                              ),
                              chooseType(
                                name: 'Bird',
                                onSelected: (value) {
                                  type = value;
                                },
                              ),
                              chooseType(
                                name: 'Turtle',
                                onSelected: (value) {
                                  type = value;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text('Gender', style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Row(children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isMale = true;
                                        gender = 'Male';
                                      });
                                    },
                                    icon: isMale
                                        ? Icon(
                                      Icons.radio_button_checked,
                                      color: primaryColor,
                                    )
                                        : const Icon(
                                        Icons.radio_button_off_outlined)),
                                const Text('Male')
                              ]),
                              const SizedBox(width: 30),
                              Row(children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isMale = false;
                                        gender = 'Female';
                                      });
                                    },
                                    icon: !isMale
                                        ? Icon(
                                      Icons.radio_button_checked,
                                      color: primaryColor,
                                    )
                                        : const Icon(
                                        Icons.radio_button_off_outlined)),
                                const Text('Female')
                              ]),
                            ],
                          ),
                          customTextFormField(
                            title: 'Breed',
                            onSaved: (value) {
                              breed = value!;
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      _selectLocation();
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text('Found Pet Location'),
                                        SizedBox(height: 10),
                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.grey),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '$lastAddress',
                                              style: TextStyle(fontSize: 10),

                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),),
                              SizedBox(width: 10),
                              Expanded(
                                  child: customTextFormField(
                                    title: 'Found Pet time',
                                    onSaved: (value) {
                                      time = value!;
                                    },
                                  )),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text('Found pet info',
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.25), // Shadow color
                                  blurRadius: 4, // Softening the shadow
                                  spreadRadius: 0.5, // Extending the shadow
                                  offset: Offset(
                                      0, 0), // No offset to center the shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 10.0, right: 10),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide some information'; // Error message when validation fails
                                  }
                                  return null; // Return null when validation passes
                                },
                                onSaved: (value) {
                                  info = value!;
                                },
                                maxLines: 1, // Restricting to a single line
                                decoration: InputDecoration(
                                  hintText: 'I found this cute dog',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text('Gallery',
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'PoppinsBold')),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (var image in galleryImages)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      width: 106,
                                      height: 98,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.file(
                                        File(image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                GestureDetector(
                                  onTap: addImage,
                                  child: Container(
                                    width: 106,
                                    height: 98,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[300],
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isGalleryValid)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Please add at least one image.',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          SizedBox(height: 40),

                          ConditionalBuilder(
                            condition: state is! LoadingAddFoundPetState,
                            builder: (context) => customButton(
                              title: 'List Now',
                              function: () {

                                if(userToken!=''){
                                  setState(() {
                                    isGalleryValid = galleryImages
                                        .isNotEmpty; // Validate the gallery
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    HomeCubit.get(context).addFoundPet(
                                      type: type,
                                      gender: gender,
                                      breed: breed,
                                      found_location: lastAddress,
                                      found_time: time,
                                      found_info: info,
                                      images: galleryImages
                                          .map((image) => File(image))
                                          .toList(), // Convert paths to File objects
                                    );
                                  } else {
                                    print(
                                        "Form is not valid or currentState is null");
                                  }
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




                              },


                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

//initialization
  String selectedType = 'Dog';

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
