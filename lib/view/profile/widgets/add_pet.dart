import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/components/widget.dart';
import 'package:pet_app/model/get_breed_model.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/authentication/custom_sign_up_date.dart';
import 'package:pet_app/view/authentication/manager/get_breed_cubit/get_breed_cubit.dart';
import 'package:pet_app/view/authentication/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:pet_app/view/profile/profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPet extends StatefulWidget {
  const AddPet({super.key});

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool isMale = true;
  late String petName, age, breed;
  late File pic;
  String type = 'Dog', gender = 'Male';

  GetBreedModel? getBreedModel;
  List<String> breedOptions = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => GetBreedCubit()..userGetBreed(),
        ),
      ],
      child: Scaffold(
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is AddPetSuccess) {
              if (state.addPetModel.status) {
                CacheHelper.saveData(
                  key: 'id',
                  value: state.addPetModel.data?.pet?.id,
                ).then((value) {
                  showAddPetConfirmation(context);
                });
              } else {
                print(state.addPetModel.message);
                print('تاكد من البيانات المدخله');
                showToast(
                  message: state.addPetModel.message,
                  color: Colors.red,
                );
              }
              if (state is AddPetFailure) {
                showToast(
                  message: state.addPetModel.message,
                  color: Colors.red,
                );
              }
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ModalProgressHUD(
                  inAsyncCall: state is SignUpLoading ? true : false,
                  progressIndicator: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: BlocConsumer<GetBreedCubit, GetBreedState>(
                      listener: (context, state) {
                        if (state is GetBreedSuccess) {
                          if (state.getBreedModel.status) {
                            setState(() {
                              getBreedModel = state.getBreedModel;
                              // Update the breed options based on the selected type
                              _updateBreedOptions(type);
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
                        return SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            autovalidateMode: autovalidateMode,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headerOfScreen(
                                    title: 'Add New Pet',
                                    function: () {
                                      Navigator.pop(context);
                                    }),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: customTextFormField(
                                        title: 'Pet Name',
                                        onSaved: (value) {
                                          petName = value!;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: CustomSignUpDate(
                                        onChanged: (data) {
                                          age = data;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    chooseType(
                                      name: 'Dog',
                                      onSelected: (value) {
                                        setState(() {
                                          type = value;
                                          _updateBreedOptions(type);
                                        });
                                      },
                                    ),
                                    chooseType(
                                      name: 'Cat',
                                      onSelected: (value) {
                                        setState(() {
                                          type = value;
                                          _updateBreedOptions(type);
                                        });
                                      },
                                    ),
                                    chooseType(
                                      name: 'Fish',
                                      onSelected: (value) {
                                        setState(() {
                                          type = value;
                                          _updateBreedOptions(type);
                                        });
                                      },
                                    ),
                                    chooseType(
                                      name: 'Bird',
                                      onSelected: (value) {
                                        setState(() {
                                          type = value;
                                          _updateBreedOptions(type);
                                        });
                                      },
                                    ),
                                    chooseType(
                                      name: 'Turtle',
                                      onSelected: (value) {
                                        setState(() {
                                          type = value;
                                          _updateBreedOptions(type);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Gender',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
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
                                              : const Icon(Icons
                                                  .radio_button_off_outlined)),
                                      const Text('Male')
                                    ]),
                                    const SizedBox(
                                      width: 30,
                                    ),
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
                                              : const Icon(Icons
                                                  .radio_button_off_outlined)),
                                      const Text('Female')
                                    ]),
                                  ],
                                ),
                                CustomBreedDropDown(
                                  title: 'Breed',
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  onTypeSelected: (String breedType) {
                                    breed = breedType;
                                  },
                                  breed: breedOptions,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: CustomPicImageFunction(
                                        onImageSelected: (value) {
                                          pic = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                customButton(
                                  title: 'Add Pet',
                                  function: () async {
                                    final SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    await preferences.setBool(
                                        'googleSignIn', false);

                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      SignUpCubit.get(context).userAddPet(
                                        name: petName,
                                        age: age,
                                        type: type,
                                        gender: gender,
                                        breed: breed,
                                        pic: pic,
                                      );
                                    } else {
                                      setState(() {
                                        autovalidateMode =
                                            AutovalidateMode.always;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _updateBreedOptions(String type) {
    // Filter breeds based on the selected type
    if (getBreedModel != null) {
      setState(() {
        breedOptions = getBreedModel!.data.breeds
            .where(
              (breed) => breed.type == type.toLowerCase(),
            )
            .map(
              (breed) => breed.name,
            )
            .toList();
      });
    }
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

class CustomBreedDropDown extends StatefulWidget {
  const CustomBreedDropDown({
    super.key,
    required this.width,
    required this.height,
    required this.onTypeSelected,
    this.text,
    this.title,
    required this.breed,
  });

  final double width, height;
  final Function(String) onTypeSelected;
  final String? text, title;
  final List<String> breed;

  @override
  State<CustomBreedDropDown> createState() => _CustomBreedDropDownState();
}

class _CustomBreedDropDownState extends State<CustomBreedDropDown> {
  String? selectedBreed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          widget.title ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400), // Border color
            color: const Color(0xffFEF7FF), // Background color
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(16),
              value: selectedBreed,
              hint: Text(
                widget.text ?? 'Select Breed',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              items: widget.breed.map((String breed) {
                return DropdownMenuItem<String>(
                  value: breed,
                  child: Text(breed),
                );
              }).toList(),
              onChanged: (String? breed) {
                setState(() {
                  selectedBreed = breed;
                  widget.onTypeSelected(selectedBreed!);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

void showAddPetConfirmation(BuildContext context) {
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: primaryColor,
              ),
              child: Image.asset('assets/images/back.png'),
            ),
            Container(
              height: 223,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Your pet is added successfully',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'PoppinsBold'),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 68,
                      height: 69,
                      child: Image.asset('assets/images/true.png'),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileView(),
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
                            'Continue',
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _pickImageFromGallery();
        if (_image == null) return;
        widget.onImageSelected!(_image!);
      },
      child: CustomPicImage(
        image: _image,
        pic: widget.pic,
      ),
    );
  }

  Future _pickImageFromGallery() async {
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
            if (pic != null)
              Container(
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
