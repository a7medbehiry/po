import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/firebase_options.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/network/share/bloc_observer.dart';
import 'package:pet_app/view/authentication/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:pet_app/view/authentication/social_login/manager/cubit/social_cubit.dart';
import 'package:pet_app/view/chat/services/get_it_service.dart';
import 'package:pet_app/view/on_boarding/on_boarding_screen.dart';
import 'package:pet_app/view/profile/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:pet_app/view_model/home_cubit/cubit.dart';
import 'package:pet_app/view_model/home_cubit/states.dart';
import 'components/constant.dart';
import 'view/authentication/social_login/get_it.dart';
import 'view/notification/service/firebase_notifications.dart';

void main() async {
  Bloc.observer = const SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();
  setupGettItt();
  await FirebaseNotifications().initNotifications();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()
            ..getSearch(type: 'dog')
            ..getAllStore()
            ..getNumber(),
        ),
        BlocProvider(
          create: (context) => GetProfileDataCubit()..userGetProfileData(),
        ),
        BlocProvider(
          create: (context) => SocialCubit(),
        ),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            scaffoldMessengerKey: snackbarKey,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: 'Poppins',
              primaryColor: primaryColor,
              //hintColor: threeColor,
              //primarySwatch: Colors.teal
            ),
            home: const StartScreen(),
          );
        },
      ),
    );
  }
}
