import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:pet_app/view/Layout/layout_screen.dart';
import 'package:pet_app/view/authentication/custom_sign_up_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/components/widget.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/profile/data/models/get_all_pets_model/get_all_pets_model.dart';
import 'package:pet_app/view/profile/data/models/pet_profile_models/get_pet_model/get_pet_model.dart';
import 'package:pet_app/view/profile/help_and_support_view.dart';
import 'package:pet_app/view/profile/manager/add_gallery_cubit/add_gallery_cubit.dart';
import 'package:pet_app/view/profile/manager/edit_pet_data_cubit/edit_pet_data_cubit.dart';
import 'package:pet_app/view/profile/manager/get_all_pets_cubit/get_all_pets_cubit.dart';
import 'package:pet_app/view/profile/manager/get_pet_data_cubit/get_pet_data_cubit.dart';
import 'package:pet_app/view/profile/setting_view.dart';
import 'package:pet_app/view/profile/widgets/gallery_list_view_builder.dart';
import 'package:pet_app/view/profile/widgets/pet_list_view_builder.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  _ProfileViewBodyState createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  // Variable to manage the visibility of the camera icon
  bool _showCameraIcon = false;
  bool _readOnly = true;
  bool _isClicked = true;

  GetPetModel? getPetModel;
  GetAllPetsModel? getAllPetsModel;

  late File pic;

  late String name;
  String previousName = '';

  String? age, gender, type, breed;
  String previousAge = '',
      previousGender = '',
      previousType = '',
      previousBreed = '';

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  int selectedPetIndex = 0;

  @override
  void initState() {
    super.initState();
    googleSignIn();
  }

  bool seen = false;
  Future<void> googleSignIn() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    seen = preferences.getBool('googleSignIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllPetsCubit, GetAllPetsState>(
      listener: (context, state) {
        if (state is GetAllPetsSuccess) {
          if (state.getAllPetsModel.status!) {
            setState(() {
              getAllPetsModel = state.getAllPetsModel;
            });
            print(CacheHelper.getData(key: 'token'));
            print(CacheHelper.getData(key: 'id'));
          } else {
            print(state.getAllPetsModel.message);

            showToast(
              message: state.getAllPetsModel.message!,
              color: Colors.red,
            );
          }
        } else if (state is GetAllPetsFailure) {
          showToast(
            message: state.message,
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      headerOfScreen(
                        title: 'My Pet Profile',
                        function: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LayoutScreen(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const HelpAndSupportView(),
                              ),
                            );
                          },
                          child: Image.asset('assets/images/info.png')),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingView()));
                        },
                        child: Image.asset('assets/images/Setting.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<GetPetDataCubit, GetPetDataState>(
                    listener: (context, state) {
                      if (state is GetPetDataSuccess) {
                        if (state.getPetModel.status!) {
                          setState(() {
                            getPetModel = state.getPetModel;
                          });
                          print(CacheHelper.getData(key: 'token'));
                          print(CacheHelper.getData(key: 'id'));
                        } else {
                          print(state.getPetModel.message);

                          showToast(
                            message: state.getPetModel.message,
                            color: Colors.red,
                          );
                        }
                        if (state is GetPetDataFailure) {
                          showToast(
                            message: state.getPetModel.message,
                            color: Colors.red,
                          );
                        }
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 70,
                            width: MediaQuery.of(context).size.height,
                            child: PetListViewBuilder(
                              getAllPetsModel: getAllPetsModel,
                              onPetSelected: (petId) {
                                GetPetDataCubit.get(context).userGetPetData(
                                  id: petId,
                                );
                              },
                              onSelected: (index) {
                                setState(() {
                                  selectedPetIndex = index;

                                  GetPetDataCubit.get(context).userGetPetData(
                                    id: getAllPetsModel?.data?.pets?[index].id,
                                  );
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          BlocConsumer<EditPetDataCubit, EditPetDataState>(
                            listener: (context, state) {
                              if (state is EditPetPicSuccess) {
                                if (state.petPicModel.status) {
                                  GetAllPetsCubit.get(context).getAllPetsData();
                                } else {
                                  print(state.petPicModel.message);
                                  print('تاكد من البيانات المدخله');
                                  showToast(
                                    message: state.petPicModel.message,
                                    color: Colors.red,
                                  );
                                }
                                if (state is EditPetPicFailure) {
                                  showToast(
                                    message: state.petPicModel.message,
                                    color: Colors.red,
                                  );
                                }
                              }

                              if (state is EditPetNameSuccess) {
                                if (state.petNameModel.status) {
                                  showToast(
                                    message: 'Pet Name changed successfully',
                                    color: Colors.green,
                                  );
                                } else {
                                  print(state.petNameModel.message);
                                  print('تاكد من البيانات المدخله');
                                  showToast(
                                    message: state.petNameModel.message,
                                    color: Colors.red,
                                  );
                                }
                                if (state is EditPetNameFailure) {
                                  showToast(
                                    message: state.petNameModel.message,
                                    color: Colors.red,
                                  );
                                }
                              }

                              if (state is EditPetInfoSuccess) {
                                if (state.changeProfileInfoModel.status) {
                                  showToast(
                                    message: 'Pet Info changed successfully',
                                    color: Colors.green,
                                  );
                                } else {
                                  print(state.changeProfileInfoModel.message);
                                  print('تاكد من البيانات المدخله');
                                  showToast(
                                    message:
                                        state.changeProfileInfoModel.message,
                                    color: Colors.red,
                                  );
                                }
                                if (state is EditPetInfoFailure) {
                                  showToast(
                                    message:
                                        state.changeProfileInfoModel.message,
                                    color: Colors.red,
                                  );
                                }
                              }
                            },
                            builder: (context, state) {
                              return Visibility(
                                visible: !seen,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CustomPicImageFunction(
                                                pic: getAllPetsModel
                                                            ?.data
                                                            ?.pets?[
                                                                selectedPetIndex]
                                                            .picture !=
                                                        null
                                                    ? 'https://pet-app.webbing-agency.com/storage/app/public/${getAllPetsModel?.data?.pets?[selectedPetIndex].picture}'
                                                    : null,
                                                onImageSelected: (value) {
                                                  pic = value;
                                                  EditPetDataCubit.get(context)
                                                      .uploadPetPic(
                                                    pic: pic,
                                                    id: getAllPetsModel
                                                        ?.data
                                                        ?.pets?[
                                                            selectedPetIndex]
                                                        .id,
                                                  );
                                                },
                                              ),
                                              if (_showCameraIcon)
                                                Positioned(
                                                  top: 8,
                                                  left: 8,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      // Handle camera icon tap here
                                                    },
                                                    child: Image.asset(
                                                        'assets/images/camera-01.png'),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          height: 50,
                                          child: TextFormField(
                                            onSaved: (value) {
                                              name = value!;
                                            },
                                            readOnly: _readOnly,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: getAllPetsModel
                                                      ?.data
                                                      ?.pets?[selectedPetIndex]
                                                      .name ??
                                                  'Pet name',
                                              hintStyle: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (!_readOnly) {
                                                _formKey.currentState!.save();

                                                EditPetDataCubit.get(context)
                                                    .changePetName(
                                                  name: name,
                                                  id: getAllPetsModel
                                                      ?.data
                                                      ?.pets?[selectedPetIndex]
                                                      .id,
                                                );
                                              }
                                              GetPetDataCubit.get(context)
                                                  .userGetPetData();

                                              _readOnly = !_readOnly;
                                            });
                                          },
                                          child: Image.asset(
                                            !_readOnly
                                                ? 'assets/images/check.png'
                                                : 'assets/images/edit.png',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Info',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (!_isClicked) {
                                                _formKey.currentState!.save();
                                                EditPetDataCubit.get(context)
                                                    .changePetInfo(
                                                        age: age,
                                                        gender: gender,
                                                        type: type,
                                                        breed: breed,
                                                        id: getAllPetsModel
                                                            ?.data
                                                            ?.pets?[
                                                                selectedPetIndex]
                                                            .id);
                                              }
                                              GetPetDataCubit.get(context)
                                                  .userGetPetData();

                                              _isClicked = !_isClicked;
                                            });
                                          },
                                          child: Text(
                                            !_isClicked ? 'Done' : 'Edit',
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomSignUpDate(
                                            text: getAllPetsModel?.data
                                                ?.pets?[selectedPetIndex].age,
                                            onChanged: (data) {
                                              age = data;
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: CustomGenderDropDown(
                                            onGenderSelected: (value) {
                                              gender = value;
                                            },
                                            width: double.infinity,
                                            height: 48,
                                            title: 'Gender',
                                            text: getAllPetsModel
                                                    ?.data
                                                    ?.pets?[selectedPetIndex]
                                                    .gender ??
                                                'gender',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomTypeDropDown(
                                            onTypeSelected: (value) {
                                              type = value;
                                            },
                                            width: double.infinity,
                                            height: 48,
                                            title: 'Type',
                                            text: getAllPetsModel
                                                    ?.data
                                                    ?.pets?[selectedPetIndex]
                                                    .type ??
                                                'type',
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: customTextFormField(
                                            hasBorder: false,
                                            readOnly: true,
                                            title: 'Breed',
                                            hintText: getAllPetsModel
                                                    ?.data
                                                    ?.pets?[selectedPetIndex]
                                                    .breed ??
                                                'Breed',
                                            color: const Color(0xFFD8D4F9),
                                            onSaved: (value) {
                                              breed = value!;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Visibility(
                            visible: !seen,
                            child: const Row(
                              children: [
                                Text(
                                  'Gallery',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          BlocConsumer<AddGalleryCubit, AddGalleryState>(
                            listener: (context, state) {
                              if (state is AddGallerySuccess) {
                                if (state.addGalleryModel.status) {
                                  showToast(
                                    message: state.addGalleryModel.message,
                                    color: Colors.green,
                                  );
                                } else {
                                  print(state.addGalleryModel.message);
                                  print('تاكد من البيانات المدخله');
                                  showToast(
                                    message: state.addGalleryModel.message,
                                    color: Colors.red,
                                  );
                                }
                                if (state is AddGalleryFailure) {
                                  showToast(
                                    message: state.addGalleryModel.message,
                                    color: Colors.red,
                                  );
                                }
                              }
                            },
                            builder: (context, state) {
                              return Visibility(
                                visible: !seen,
                                child: SizedBox(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: GalleryListViewBuilder(
                                    getAllPetsModel: getAllPetsModel,
                                    selectedIndex:
                                        selectedPetIndex, // Pass the selectedIndex
                                    onPetSelected: (petId) {
                                      GetPetDataCubit.get(context)
                                          .userGetPetData(
                                        id: petId,
                                      );
                                    },
                                    onSelected: (index) {
                                      setState(() {
                                        selectedPetIndex = index;

                                        GetPetDataCubit.get(context)
                                            .userGetPetData(
                                          id: getAllPetsModel
                                              ?.data?.pets?[index].id,
                                        );
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomPicImageFunction extends StatefulWidget {
  final Function(File)? onImageSelected;
  final String? pic;
  const CustomPicImageFunction({super.key, this.onImageSelected, this.pic});

  @override
  State<CustomPicImageFunction> createState() => _CustomPicImageFunctionState();
}

class _CustomPicImageFunctionState extends State<CustomPicImageFunction> {
  File? _image;

  Future<void> _uploadImageToFirebase() async {
    if (_image == null) return;

    // Create a unique file name
    final fileName = Uuid().v4() + path.extension(_image!.path);

    // Upload image to Firebase Storage
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_profile_pics')
        .child(fileName);
    try {
      final uploadTask = storageRef.putFile(_image!);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore with the new image URL
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'profileImageUrl': downloadUrl,
        });
      }
      CacheHelper.saveData(key: 'profileImageUrl', value: downloadUrl);

      // Optionally, you can pass the downloadUrl to the callback
      widget.onImageSelected?.call(_image!);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _pickImageFromGallery();
        if (_image == null) return;
        await _uploadImageToFirebase();
      },
      child: CustomPicImage(
        image: _image,
        pic: widget.pic,
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _image = File(image.path);
    });
  }
}

class CustomPicImage extends StatelessWidget {
  const CustomPicImage({
    super.key,
    required File? image,
    this.pic,
  }) : _image = image;

  final File? _image;
  final String? pic;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            pic != null
                ? Container(
                    width: 131,
                    height: 145,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: primaryColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        pic!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : Container(
                    width: 131,
                    height: 145,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: primaryColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/default.jpg',
                      ),
                    ),
                  ),
            if (_image != null)
              Container(
                width: 131,
                height: 145,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: primaryColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            if (_image == null && pic == null)
              Container(
                width: 131,
                height: 145,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[400],
                  border: Border.all(
                    width: 2,
                    color: primaryColor,
                  ),
                ),
                child: Icon(
                  Icons.add_circle,
                  color: primaryColor,
                  size: 74,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
