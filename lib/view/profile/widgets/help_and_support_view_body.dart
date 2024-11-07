import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/components/widget.dart';
import 'package:pet_app/view/profile/manager/help_and_support_cubit/help_and_support_cubit.dart';

class HelpAndSupportViewBody extends StatefulWidget {
  const HelpAndSupportViewBody({super.key});

  @override
  State<HelpAndSupportViewBody> createState() => _HelpAndSupportViewBodyState();
}

class _HelpAndSupportViewBodyState extends State<HelpAndSupportViewBody> {
  late String message = '';

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _messageController =
      TextEditingController(); // Add the TextEditingController

  @override
  void dispose() {
    _messageController.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocConsumer<HelpAndSupportCubit, HelpAndSupportState>(
        listener: (context, state) {
          if (state is HelpAndSupportSuccess) {
            if (state.helpAndSupportModel.status) {
              showSendingConfirmation(context);
              _messageController.clear(); // Clear the text field after sending
            } else {
              print(state.helpAndSupportModel.message);
              print('تاكد من البيانات المدخله');
              showToast(
                message: state.helpAndSupportModel.message,
                color: Colors.red,
              );
            }
          } else if (state is HelpAndSupportFailure) {
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
                children: [
                  headerOfScreen(
                    title: 'Help and support',
                    function: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 343,
                        height: 406,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFFFF6D2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                'We\'re committed to making your experience with our app the best it can be! If you have any questions, need help with something, or have a suggestion for improvement, we\'d love to hear from you.',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF939393)),
                                textAlign: TextAlign.center,
                              ),
                              customTextFormField(
                                controller:
                                    _messageController, // Attach the controller
                                onSaved: (value) {
                                  message = value!;
                                },
                                title: '',
                                hintText: 'I would like to Know',
                                hasBorder: false,
                                maxLines: 7,
                                color: const Color(0xFFFDFDFD),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 2,
                                    spreadRadius: 0.5,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -115,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/catss.png',
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  customButton(
                    title: 'Send',
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        HelpAndSupportCubit.get(context).userHelpAndSupport(
                          message: message,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void showSendingConfirmation(BuildContext context) {
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
                      'Feedback sent!',
                      style: TextStyle(
                          fontSize: 20,
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
                        Navigator.of(context).pop();
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
