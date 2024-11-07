import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pet_app/view/authentication/manager/create_new_password_cubit/create_new_password_cubit.dart';
import 'package:pet_app/view/authentication/sign_in_screen.dart';

import '../../components/constant.dart';
import '../../components/widget.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;
  const NewPasswordScreen({super.key, required this.email});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String password, confirmPassword;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateNewPasswordCubit(),
      child: Scaffold(
        body: BlocConsumer<CreateNewPasswordCubit, CreateNewPasswordState>(
          listener: (context, state) {
            if (state is CreateNewPasswordSuccess) {
              if (state.createNewPasswordModel.status) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              } else {
                print(state.createNewPasswordModel.message);
                print('تاكد من البيانات المدخله');
                showToast(
                  message: state.createNewPasswordModel.message,
                  color: Colors.red,
                );
              }
              if (state is CreateNewPasswordFailure) {
                showToast(
                  message: state.createNewPasswordModel.message,
                  color: Colors.red,
                );
              }
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ModalProgressHUD(
                    inAsyncCall:
                        state is CreateNewPasswordLoading ? true : false,
                    progressIndicator: Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: autovalidateMode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headerOfScreen(
                                title: 'Reset password',
                                function: () {
                                  Navigator.pop(context);
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 248,
                                      height: 165,
                                      child:
                                          Image.asset('assets/images/r3.png'),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Enter your new password',
                                      style: TextStyle(
                                          fontSize: 14, color: grayTextColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PasswordTextFormField(
                              title: 'password',
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
                              height: 40,
                            ),
                            customButton(
                                title: 'Reset Password',
                                function: () {
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>CodeScreen()));
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    CreateNewPasswordCubit.get(context)
                                        .userCreateNewPassword(
                                      email: widget.email,
                                      password: password,
                                      confirmPassword: confirmPassword,
                                    );
                                  } else {
                                    setState(() {
                                      autovalidateMode =
                                          AutovalidateMode.always;
                                    });
                                  }
                                }),
                            const SizedBox(
                              height: 5,
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
      ),
    );
  }
}
