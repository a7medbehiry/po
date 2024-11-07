import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pet_app/view/authentication/forgot_password_screen.dart';
import 'package:pet_app/view/authentication/manager/check_mail_cubit/check_mail_cubit.dart';

import '../../components/constant.dart';
import '../../components/widget.dart';
import 'new_password_screen.dart';

class CheckMailScreen extends StatefulWidget {
  final String email;
  const CheckMailScreen({super.key, required this.email});

  @override
  State<CheckMailScreen> createState() => _CheckMailScreenState();
}

class _CheckMailScreenState extends State<CheckMailScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String otp;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckMailCubit(),
      child: Scaffold(
        body: BlocConsumer<CheckMailCubit, CheckMailState>(
          listener: (context, state) {
            if (state is CheckMailSuccess) {
              if (state.checkMailModel.status) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewPasswordScreen(
                              email: widget.email,
                            )));
              } else {
                print(state.checkMailModel.message);
                print('تاكد من البيانات المدخله');
                showToast(
                  message: state.checkMailModel.message,
                  color: Colors.red,
                );
              }
              if (state is CheckMailFailure) {
                showToast(
                  message: state.checkMailModel.message,
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
                    inAsyncCall: state is CheckMailLoading ? true : false,
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
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPasswordScreen()));
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
                                          Image.asset('assets/images/r2.png'),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Please enter the OTP sent to your phone\n number',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OtpTextField(
                                  numberOfFields: 4,
                                  enabledBorderColor: Colors.grey.shade500,
                                  focusedBorderColor: primaryColor,
                                  showFieldAsBox: true,
                                  onSubmit: (String code) {
                                    setState(() {
                                      otp = code;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customTextButton(
                                  title: 'Resend OTP',
                                  function: () {},
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            customButton(
                                title: 'Continue',
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    CheckMailCubit.get(context).userCheckMail(
                                      email: widget.email,
                                      otp: otp,
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
