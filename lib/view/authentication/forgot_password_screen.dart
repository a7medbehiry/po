import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pet_app/view/authentication/manager/forget_password_cubit/forget_password_cubit.dart';

import '../../components/constant.dart';
import '../../components/widget.dart';
import 'check_mail_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String email;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Scaffold(
        body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            if (state is ForgetPasswordSuccess) {
              if (state.forgetPasswordModel.status) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckMailScreen(
                      email: email,
                    ),
                  ),
                );
              } else {
                print(state.forgetPasswordModel.message);
                print('تاكد من البيانات المدخله');
                showToast(
                  message: state.forgetPasswordModel.message,
                  color: Colors.red,
                );
              }
              if (state is ForgetPasswordFailure) {
                showToast(
                  message: state.forgetPasswordModel.message,
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
                    inAsyncCall: state is ForgetPasswordLoading ? true : false,
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
                                          Image.asset('assets/images/r1.png'),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Enter the email address or phone\n number associated with your account to\n receive OTP',
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
                            customTextFormField(
                                title: 'Email or Phone Number',
                                onSaved: (value) {
                                  email = value!;
                                }),
                            const SizedBox(
                              height: 40,
                            ),
                            customButton(
                                title: 'Continue',
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    ForgetPasswordCubit.get(context)
                                        .userForgetPassword(
                                      email: email,
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
