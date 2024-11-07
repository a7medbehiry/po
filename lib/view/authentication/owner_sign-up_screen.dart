import 'package:flutter/material.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/components/widget.dart';
import 'package:pet_app/view/authentication/pet_sign_up_screen.dart';

class OwnerSignUpScreen extends StatefulWidget {
  const OwnerSignUpScreen({super.key});

  @override
  State<OwnerSignUpScreen> createState() => _OwnerSignUpScreenState();
}

class _OwnerSignUpScreenState extends State<OwnerSignUpScreen> {
  bool isOwner = true;

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String firstName = '',
      lastName = '',
      email = '',
      phone = '',
      password = '',
      confirmPassword = '',
      address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                            isOwner = true;
                            setState(() {});
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        isOwner ? primaryColor : Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                                color: isOwner ? primaryColor : Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: isOwner
                                          ? Colors.white
                                          : Colors.grey[300]),
                                  child: Center(
                                      child: Text(
                                    '1',
                                    style: TextStyle(
                                        color: isOwner
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
                                      color:
                                          isOwner ? Colors.white : Colors.grey,
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
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PetSignUpScreen(
                                    firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    phone: phone,
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    address: address,
                                  ),
                                ),
                              );
                            } else {
                              setState(() {
                                autovalidateMode = AutovalidateMode.always;
                              });
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        !isOwner ? primaryColor : Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                                color: !isOwner ? primaryColor : Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: !isOwner
                                          ? Colors.white
                                          : Colors.grey[300]),
                                  child: Center(
                                      child: Text(
                                    '2',
                                    style: TextStyle(
                                        color: !isOwner
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
                                      color:
                                          !isOwner ? Colors.white : Colors.grey,
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
                          title: 'First Name',
                          onSaved: (value) {
                            firstName = value!;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: customTextFormField(
                          title: 'Last Name',
                          onSaved: (value) {
                            lastName = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                  customTextFormField(
                    title: 'Email',
                    onSaved: (value) {
                      email = value!;
                    },
                  ),
                  customTextFormField(
                    title: 'Phone Number',
                    onSaved: (value) {
                      phone = value!;
                    },
                  ),
                  customTextFormField(
                    title: 'Address',
                    onSaved: (value) {
                      address = value!;
                    },
                  ),
                  PasswordTextFormField(
                    title: 'Password',
                    onSaved: (value) {
                      password = value!;
                    },
                  ),
                  PasswordTextFormField(
                    title: 'Confirm Password',
                    onSaved: (value) {
                      confirmPassword = value!;
                    },
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  customButton(
                    title: 'Next',
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PetSignUpScreen(
                              firstName: firstName,
                              lastName: lastName,
                              email: email,
                              phone: phone,
                              password: password,
                              confirmPassword: confirmPassword,
                              address: address,
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
