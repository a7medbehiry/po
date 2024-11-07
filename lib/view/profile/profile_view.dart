import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/view/profile/manager/add_gallery_cubit/add_gallery_cubit.dart';
import 'package:pet_app/view/profile/manager/edit_pet_data_cubit/edit_pet_data_cubit.dart';
import 'package:pet_app/view/profile/manager/get_all_pets_cubit/get_all_pets_cubit.dart';
import 'package:pet_app/view/profile/manager/get_pet_data_cubit/get_pet_data_cubit.dart';
import 'package:pet_app/view/profile/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetAllPetsCubit()..getAllPetsData(),
        ),
        BlocProvider(
          create: (context) => GetPetDataCubit()..userGetPetData(),
        ),
        BlocProvider(
          create: (context) => EditPetDataCubit(),
        ),
        BlocProvider(
          create: (context) => AddGalleryCubit(),
        ),
      ],
      child: const Scaffold(
        backgroundColor: Color(0xFFFCFCFC),
        body: SafeArea(
          child: ProfileViewBody(),
        ),
      ),
    );
  }
}
