import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/components/widget.dart';
import 'package:pet_app/model/get_breed_model.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/Layout/layout_screen.dart';
import 'package:pet_app/view/authentication/custom_sign_up_date.dart';
import 'package:pet_app/view/authentication/manager/get_breed_cubit/get_breed_cubit.dart';
import 'package:pet_app/view/chat/domain/repos/auth_repo.dart';
import 'package:pet_app/view/chat/manager/firebase_sign_up_cubit/firebase_sign_up_cubit.dart';
import 'package:pet_app/view/authentication/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:pet_app/view/chat/services/get_it_service.dart';

class PetSignUpScreen extends StatefulWidget {
  const PetSignUpScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    required this.address,
  });

  final String firstName,
      lastName,
      email,
      phone,
      password,
      confirmPassword,
      address;

  @override
  State<PetSignUpScreen> createState() => _PetSignUpScreenState();
}

class _PetSignUpScreenState extends State<PetSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool isPet = false;
  bool isMale = true;

  late String petName, age, breed = '';
  String type = 'dog', gender = 'Male'; // Default type set to 'dog'

  bool isSignUpSuccess = false;

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
          create: (context) => FirebaseSignUpCubit(
            getIt<AuthRepo>(),
          ),
        ),
        BlocProvider(
          create: (context) => GetBreedCubit()..userGetBreed(),
        ),
      ],
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            if (state.signUpModel.status) {
              CacheHelper.saveData(
                  key: 'email', value: state.signUpModel.data?.user.email);
              CacheHelper.saveData(
                      key: 'token', value: state.signUpModel.data?.token)
                  .then((value) {
                userToken = state.signUpModel.data?.token;
                print(userToken);

                setState(() {
                  isSignUpSuccess = true;
                });

                // Trigger Firebase sign-up after API sign-up success
                context
                    .read<FirebaseSignUpCubit>()
                    .createUserWithEmailAndPassword(
                      petName,
                      widget.email,
                      widget.password,
                    );
                //  Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const LayoutScreen(),
                //     ),
                //   );
              });
            } else {
              print(state.signUpModel.message);
              print('تأكد من البيانات المدخلة');
              showToast(
                message: state.signUpModel.message,
                color: Colors.red,
              );
            }
            if (state is SignUpFailure) {
              showToast(
                message: state.signUpModel.message,
                color: Colors.red,
              );
            }
          }
        },
        builder: (context, state) {
          return BlocConsumer<FirebaseSignUpCubit, FirebaseSignUpState>(
            listener: (context, state) {
              if (state is FirebaseSignUpSuccess && isSignUpSuccess) {
                CacheHelper.saveData(key: 'name', value: state.userEntity.name);
                CacheHelper.saveData(
                    key: 'email', value: state.userEntity.email);
                CacheHelper.saveData(key: 'uId', value: state.userEntity.email)
                    .then((value) {
                  userEmail = state.userEntity.email;

                  print(userEmail);
                  print(state.userEntity.uId);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LayoutScreen(),
                    ),
                  );
                });
              }

              if (state is FirebaseSignUpFailure) {
                showToast(
                  message: state.message,
                  color: Colors.red,
                );
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: SafeArea(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ModalProgressHUD(
                      inAsyncCall: state is SignUpLoading ||
                          state is FirebaseSignUpLoading,
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
                                        title: 'Sign Up',
                                        function: () {
                                          Navigator.pop(context);
                                        }),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    //toggle icons
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: isPet
                                                          ? primaryColor
                                                          : Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: isPet
                                                      ? primaryColor
                                                      : Colors.white),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: isPet
                                                            ? Colors.white
                                                            : Colors.grey[300]),
                                                    child: Center(
                                                        child: Text(
                                                      '1',
                                                      style: TextStyle(
                                                          color: isPet
                                                              ? primaryColor
                                                              : Colors.grey),
                                                    )),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Owner',
                                                    style: TextStyle(
                                                        color: isPet
                                                            ? Colors.white
                                                            : Colors.grey,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isPet = true;
                                              });
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: !isPet
                                                          ? primaryColor
                                                          : Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: !isPet
                                                      ? primaryColor
                                                      : Colors.white),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: !isPet
                                                            ? Colors.white
                                                            : Colors.grey[300]),
                                                    child: Center(
                                                        child: Text(
                                                      '2',
                                                      style: TextStyle(
                                                          color: !isPet
                                                              ? primaryColor
                                                              : Colors.grey),
                                                    )),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Pet',
                                                    style: TextStyle(
                                                        color: !isPet
                                                            ? Colors.white
                                                            : Colors.grey,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

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
                                                      Icons
                                                          .radio_button_checked,
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
                                                      Icons
                                                          .radio_button_checked,
                                                      color: primaryColor,
                                                    )
                                                  : const Icon(Icons
                                                      .radio_button_off_outlined)),
                                          const Text('Female')
                                        ]),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 10,
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
                                      height: 70,
                                    ),
                                    customButton(
                                      title: 'Sign Up',
                                      function: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          SignUpCubit.get(context).userSignUp(
                                            firstName: widget.firstName,
                                            lastName: widget.lastName,
                                            email: widget.email,
                                            phone: widget.phone,
                                            address: widget.address,
                                            password: widget.password,
                                            confirmPassword:
                                                widget.confirmPassword,
                                            name: petName,
                                            age: age,
                                            type: type,
                                            gender: gender,
                                            breed: breed,
                                            join: 1,
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
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _updateBreedOptions(String type) {
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
