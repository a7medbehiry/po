import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/view/profile/manager/help_and_support_cubit/help_and_support_cubit.dart';
import 'package:pet_app/view/profile/widgets/help_and_support_view_body.dart';

class HelpAndSupportView extends StatelessWidget {
  const HelpAndSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (context) => HelpAndSupportCubit(),
        child:const  SafeArea(
          child: HelpAndSupportViewBody(),
        ),
      ),
    );
  }
}
