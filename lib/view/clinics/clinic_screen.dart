import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/components/widget.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/clinics/data/models/get_all_clinics/datum.dart';
import 'package:pet_app/view/clinics/data/models/get_all_clinics/get_all_clinics.dart';
import 'package:pet_app/view/clinics/manager/get_all_clinics_cubit/get_all_clinics_cubit.dart';
import 'package:pet_app/view/profile/data/models/user_profile_models/profile_get_data_model/profile_get_data_model.dart';
import 'package:pet_app/view/profile/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:pet_app/view/profile/profile_view.dart';

import '../../components/constant.dart';
import 'book_avisit_screen.dart';

class ClinicScreen extends StatefulWidget {
  ClinicScreen({Key? key}) : super(key: key);

  @override
  State<ClinicScreen> createState() => _ClinicScreenState();
}

class _ClinicScreenState extends State<ClinicScreen> {
  GetAllClinicsModel? getAllClinicsModel;
  ProfileGetDataModel? profileGetDataModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetProfileDataCubit.get(context).userGetProfileData();
  }

  Widget buildDoctorItem(Datum doctor, int index) {
    return Container(
      width: 164,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            spreadRadius: 0.5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 109,
              height: 144,
              child: Image.network(
                'https://pet-app.webbing-agency.com/storage/app/public/${doctor.picture}',
              ), // Replace with actual network image
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  doctor.clinicName ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'PoppinsBold',
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  doctor.specialization ?? 'Specialist',
                  style: TextStyle(
                    fontSize: 12,
                    color: grayTextColor,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: primaryColor,
                          size: 16,
                        ),
                        Text(
                          doctor.address ?? 'Location',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          color: primaryColor,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${doctor.medicalFees ?? 'N/A'} EGP",
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => GetAllClinicsCubit(),
                          child: BookAVisitScreen(
                            doctor: doctor,
                            index: index, // Pass the index here
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 194,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        'Book a Visit',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAllClinicsCubit()..getAllClinicsFunction(),
      child: BlocConsumer<GetProfileDataCubit, GetProfileDataState>(
        listener: (context, state) {
          if (state is GetProfileDataSuccess) {
            if (state.profileGetDataModel.status!) {
              setState(() {
                profileGetDataModel = state.profileGetDataModel;
                GetProfileDataCubit.get(context).userGetProfileData();
              });
              print(CacheHelper.getData(key: 'token'));
              print(CacheHelper.getData(key: 'id'));
            } else {
              print(state.profileGetDataModel.message);

              showToast(
                message: state.profileGetDataModel.message!,
                color: Colors.red,
              );
            }
            if (state is GetProfileDataFailure) {
              showToast(
                message: state.profileGetDataModel.message!,
                color: Colors.red,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocConsumer<GetAllClinicsCubit, GetAllClinicsState>(
                  listener: (context, state) {
                    if (state is GetAllClinicsSuccess) {
                      if (state.getAllClinicsModel.status!) {
                        setState(() {
                          getAllClinicsModel = state.getAllClinicsModel;
                        });
                        print(CacheHelper.getData(key: 'token'));
                        print(CacheHelper.getData(key: 'id'));
                      } else {
                        print(state.getAllClinicsModel.message);
                        showToast(
                          message: state.getAllClinicsModel.message!,
                          color: Colors.red,
                        );
                      }
                    } else if (state is GetAllClinicsFailure) {
                      showToast(
                        message: state.message,
                        color: Colors.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (getAllClinicsModel == null ||
                        getAllClinicsModel?.data?.clinics?.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      final clinics = getAllClinicsModel!.data!.clinics!.data!;

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Header
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileView(),
                                        ));
                                  },
                                  child: ClipOval(
                                    child: profileGetDataModel
                                                ?.data?.user?.picture !=
                                            null
                                        ? Image.network(
                                            'https://pet-app.webbing-agency.com/storage/app/public/${profileGetDataModel?.data?.user?.picture}',
                                            fit: BoxFit.fill,
                                            width: 55,
                                            height: 55,
                                          )
                                        : const CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            child: Center(
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Hi , ',
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'PoppinsBold'),
                                ),
                                Text(
                          profileGetDataModel?.data?.user?.firstName ?? 'User name',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'PoppinsBold',
                                      color: primaryColor),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: Image.asset('assets/images/Hand.png'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            //Search
                            Container(
                              width: double.infinity,
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: primaryColor)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.search, color: grayTextColor),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Search here',
                                      style: TextStyle(
                                          fontSize: 14, color: grayTextColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            //Doctors
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  buildDoctorItem(clinics[index], index),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemCount: clinics.length,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
