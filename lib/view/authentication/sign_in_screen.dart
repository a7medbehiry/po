import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/authentication/social_login/domain/repos/auth_repo.dart';
import 'package:pet_app/view/authentication/social_login/manager/cubit/social_cubit.dart';
import 'package:pet_app/view/authentication/social_login/manager/sign_in_cubit/sign_in_cubit.dart';
import 'package:pet_app/view/authentication/social_login_button.dart';
import 'package:pet_app/view/chat/domain/repos/auth_repo.dart';
import 'package:pet_app/view/chat/manager/firebase_sign_in_cubit/firebase_sign_in_cubit.dart';
import 'package:pet_app/view/authentication/manager/sign_in_cubit/sign_in_cubit.dart';
import 'package:pet_app/view/authentication/owner_sign-up_screen.dart';
import 'package:pet_app/view/chat/services/get_it_service.dart';

import '../../components/widget.dart';
import '../Layout/layout_screen.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  final String? email;
  const SignInScreen({super.key, this.email});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email;
  late String password;

  @override
  void initState() {
    super.initState();
    // Initialize the email with the value passed from the widget, if any
    email = widget.email ?? '';
  }

  bool isSignInSuccess = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInCubit(),
        ),
        BlocProvider(
          create: (context) => FirebaseSignInCubit(
            getIt<AuthRepo>(),
          ),
        ),
        BlocProvider(
          create: (context) => SignInnCubit(
            getIt<AuthRepoo>(),
          ),
        ),
      ],
      child: Scaffold(
        body: BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              if (state.signInModel.status) {
                CacheHelper.saveData(
                        key: 'token', value: state.signInModel.data?.token)
                    .then((value) {
                  userToken = state.signInModel.data?.token;
                  print(userToken);

                  setState(() {
                    isSignInSuccess = true;
                  });

                  context
                      .read<FirebaseSignInCubit>()
                      .signInWithEmailAndPassword(
                        email,
                        password,
                      );

                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const LayoutScreen(),
                  //   ),
                  // );
                });
              } else {
                print(state.signInModel.message);
                print('تاكد من البيانات المدخله');
                showToast(
                  message: state.signInModel.message,
                  color: Colors.red,
                );
              }
              if (state is SignInFailure) {
                showToast(
                  message: state.signInModel.message,
                  color: Colors.red,
                );
              }
            }
          },
          builder: (context, state) {
            return BlocConsumer<FirebaseSignInCubit, FirebaseSignInState>(
              listener: (context, state) {
                if (state is FirebaseSignInSuccess && isSignInSuccess) {
                  CacheHelper.saveData(
                      key: 'name', value: state.userEntity.name);
                  CacheHelper.saveData(
                          key: 'email', value: state.userEntity.email)
                      .then((value) {
                    userEmail = state.userEntity.email;
                    print(userEmail);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LayoutScreen(),
                      ),
                    );
                  });
                }

                if (state is FirebaseSignInFailure) {
                  showToast(
                    message: state.message,
                    color: Colors.red,
                  );
                }
              },
              builder: (context, state) {
                return BlocConsumer<SignInnCubit, SignInnState>(
                  listener: (context, state) {
                    if (state is SignInnSuccess) {
                      CacheHelper.saveData(
                          key: 'name', value: state.userEntity.name);
                      CacheHelper.saveData(
                              key: 'email', value: state.userEntity.email)
                          .then((value) {
                        userEmail = state.userEntity.email;
                        print(userEmail);
                        // context.read<SocialCubit>().social(
                        //       name: state.userEntity.name,
                        //       email: state.userEntity.email,
                        //     );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LayoutScreen(),
                          ),
                        );
                      });
                    }

                    if (state is SignInnFailure) {
                      showToast(
                        message: state.message,
                        color: Colors.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: SafeArea(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ModalProgressHUD(
                            inAsyncCall: state is SignInLoading ||
                                state is FirebaseSignInLoading,
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
                                        title: 'Sign in',
                                        function: () {
                                          Navigator.pop(context);
                                        }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            const Text('Welcome Back !'),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 96,
                                              height: 115,
                                              child: Image.asset(
                                                  'assets/images/dog.png'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    customTextFormField(
                                      title: 'Email',
                                      onSaved: (value) {
                                        email = value!;
                                      },
                                    ),
                                    PasswordTextFormField(
                                      title: 'Password',
                                      onSaved: (value) {
                                        password = value!;
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        customTextButton(
                                            title: 'Forgot Password',
                                            function: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ForgotPasswordScreen()));
                                            }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    customButton(
                                        title: 'Sign In',
                                        function: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            SignInCubit.get(context).userSignIn(
                                              email: email,
                                              password: password,
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Don\'t have an account ?',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        customTextButton(
                                          title: 'Sign up',
                                          function: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const OwnerSignUpScreen()));
                                          },
                                        ),
                                      ],
                                    ),
                                    SocialLoginButton(
                                      onPressed: () {
                                        context
                                            .read<SignInnCubit>()
                                            .signInWithGoogle(context);
                                      },
                                      image: 'assets/images/google.png',
                                      title: 'Sign In with google',
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SocialLoginButton(
                                      onPressed: () {
                                        context
                                            .read<SignInnCubit>()
                                            .signInWithFacebook();
                                      },
                                      image: 'assets/images/facebook.png',
                                      title: 'Sign In with Facebook',
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Platform.isIOS
                                        ? Column(
                                            children: [
                                              SocialLoginButton(
                                                onPressed: () {
                                                  // context.read<SignInnCubit>().signInWithApple();
                                                },
                                                image:
                                                    'assets/images/apple.png',
                                                title: 'Sign In with Apple',
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
