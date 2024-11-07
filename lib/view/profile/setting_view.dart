import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/view/profile/manager/edit_profile_data_cubit/edit_profile_data_cubit.dart';
import 'package:pet_app/view/profile/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:pet_app/view/profile/manager/log_out_cubit/log_out_cubit.dart';
import 'package:pet_app/view/profile/manager/payment_cubit/payment_cubit.dart';
import 'package:pet_app/view/profile/widgets/setting_view_body.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LogOutCubit(),
          ),
          BlocProvider(
            create: (context) => GetProfileDataCubit()..userGetProfileData(),
          ),
          BlocProvider(
            create: (context) => EditProfileDataCubit(),
          ),
          BlocProvider(
            create: (context) => PaymentCubit(),
          ),
        ],
        child: const SafeArea(
          child: SettingViewBody(),
        ),
      ),
    );
  }
}
