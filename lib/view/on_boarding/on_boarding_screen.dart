import 'package:flutter/material.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/Layout/layout_screen.dart';
import 'package:pet_app/view/authentication/owner_sign-up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/constant.dart';
import '../../components/widget.dart';
import '../authentication/sign_in_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String? token;
  String? email;
  bool openingViewSeen = false;

  @override
  void initState() {
    super.initState();
    _checkOpeningViewStatus();
  }

  Future<void> _checkOpeningViewStatus() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    bool seen = preferences.getBool('openingViewSeen') ?? false;
    token = CacheHelper.getData(key: 'token');
    email = CacheHelper.getData(key: 'email');

    // Check if the widget is still mounted before using context or setState
    if (!mounted) return;

    if (seen) {
      if (token == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignInScreen()));
      } else if (email == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignInScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LayoutScreen()));
      }
    } else {
      setState(() {
        openingViewSeen = true;
      });
    }
  }

  Future<void> _markOpeningViewSeen() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('openingViewSeen', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Image.asset(
                  'assets/images/start.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Welcome to Petify',
                style: TextStyle(fontFamily: 'PoppinsBold', fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                ' Your one-stop shop for all things pet! Find your furry soulmate through our innovative dating feature, connect with local clinics and stores, browse adoptable pets, or even find your dream breed through reputable breeders',
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // Perform async operation
                        await _markOpeningViewSeen();

                        // Check if the widget is still mounted before using context
                        if (!context.mounted) return;

                        // Perform navigation based on the email value
                        if (token == null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OwnerSignUpScreen()));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LayoutScreen()));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: primaryColor)),
                        child: Center(
                            child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18, color: primaryColor),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: customButton(
                      title: 'Sign in',
                      function: () async {
                        await _markOpeningViewSeen();

                        // Check if the widget is still mounted before using context
                        if (!context.mounted) return;

                        // Perform navigation based on the email value
                        if (token == null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LayoutScreen()));
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
