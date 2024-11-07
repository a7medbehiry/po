import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/components/widget.dart';

import 'package:pet_app/view_model/home_cubit/cubit.dart';

import '../../view_model/home_cubit/states.dart';

class ListYourPet extends StatefulWidget {


  @override
  State<ListYourPet> createState() => _ListYourPetState();
}

class _ListYourPetState extends State<ListYourPet> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool isPet = false;

  bool isMale = true;

  late String petName = '';
  late String age = '';
  late String type = 'Dog';
  late String gender = 'Male';
  late String purpose = 'For adoption';
late String breed;

  bool isForSale = false;
  String price = '';
  bool isadoption = true;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {

          if(state is SuccessAddMarketPetState){
            showToast(message: 'You are Pet Added Successfully', color: Colors.green);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headerOfScreen(
                            title: 'List Your Pet',
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
                              child: customTextFormField(
                                title: 'Age',
                                onSaved: (value) {
                                  age = value!;
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            chooseType(
                              name: 'dog',
                              onSelected: (value) {
                                type = value;
                              },
                            ),
                            chooseType(
                              name: 'cat',
                              onSelected: (value) {
                                type = value;
                              },
                            ),
                            chooseType(
                              name: 'fishe',
                              onSelected: (value) {
                                type = value;
                              },
                            ),
                            chooseType(
                              name: 'bird',
                              onSelected: (value) {
                                type = value;
                              },
                            ),
                            chooseType(
                              name: 'turtle',
                              onSelected: (value) {
                                type = value;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        customTextFormField(
                          title: 'Breed',
                          onSaved: (value) {
                            breed = value!;
                          },
                        ),

                        const SizedBox(
                          height: 30,
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
                                      : const Icon(
                                      Icons.radio_button_off_outlined)),
                              const Text('Female')
                            ]),
                          ],
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
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isadoption = true;
                                      purpose = 'For adoption';
                                      isForSale = false;
                                    });
                                  },
                                  icon: isadoption
                                      ? Icon(
                                    Icons.radio_button_checked,
                                    color: primaryColor, // Replace with primaryColor if defined
                                  )
                                      : const Icon(Icons.radio_button_off_outlined),
                                ),
                                const Text('For adoption'),
                              ],
                            ),
                            const SizedBox(width: 5),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isadoption = false;
                                      purpose = 'For sale';
                                      isForSale = true;
                                    });
                                  },
                                  icon: !isadoption
                                      ? Icon(
                                    Icons.radio_button_checked,
                                    color: primaryColor, // Replace with primaryColor if defined
                                  )
                                      : const Icon(Icons.radio_button_off_outlined),
                                ),
                                const Text('For sale'),
                              ],
                            ),
                          ],
                        ),

                        // Show the TextField only if isForSale is true
                        if (isForSale)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  price = value;
                                });
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Enter price',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),


                        const SizedBox(
                          height: 70,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingAddMarketPetState,
                          builder: (context)=>customButton(
                            title: 'List Now',
                            function: (){
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                print(petName);
                                print(age);
                                print(type);
                                print(gender);
                                print(isadoption);
                                HomeCubit.get(context).addNewMarketPet(
                                    name: petName,
                                    age: age,
                                    type: type,
                                    gender: gender,
                                    for_adoption: isadoption? 1:0,
                                    price: price,
                                  breed: breed
                                );
                              }
                          
                          
                            },
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                      ],
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
