import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/components/widget.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/clinics/data/models/get_all_clinics/get_all_clinics.dart';
import 'package:pet_app/view/clinics/manager/add_book_cubit/add_book_cubit.dart';
import 'package:pet_app/view/clinics/manager/get_all_clinics_cubit/get_all_clinics_cubit.dart';

import '../../components/constant.dart';
import 'data/models/get_all_clinics/datum.dart';

class AvailableTime {
  final String time;
  bool isSelected;

  AvailableTime({required this.time, this.isSelected = false});
}

class BookAVisitScreen extends StatefulWidget {
  final Datum doctor;
  final int index;
  const BookAVisitScreen(
      {super.key, required this.doctor, required this.index});

  @override
  State<BookAVisitScreen> createState() => _BookAVisitScreenState();
}

class _BookAVisitScreenState extends State<BookAVisitScreen> {
  DateTime selectedDate = DateTime.now();
  int selectedTimeIndex = 0;

  final List<AvailableTime> availableTimes = [
    AvailableTime(time: '10:30', isSelected: false),
    AvailableTime(time: '11:30', isSelected: false),
    AvailableTime(time: '12:30', isSelected: false),
    AvailableTime(time: '1:30', isSelected: false),
    AvailableTime(time: '2:30', isSelected: false),
    AvailableTime(time: '3:30', isSelected: false),
    AvailableTime(time: '4:30', isSelected: false),
    AvailableTime(time: '5:30', isSelected: false),
  ];

  GetAllClinicsModel? getOneClinicModel;
  DateTime? time;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetAllClinicsCubit()..getAllClinicsFunction(),
        ),
        BlocProvider(
          create: (context) => AddBookCubit(),
        ),
      ],
      child: Scaffold(
        body: BlocConsumer<GetAllClinicsCubit, GetAllClinicsState>(
          listener: (context, state) {
            if (state is GetAllClinicsSuccess) {
              if (state.getAllClinicsModel.status!) {
                setState(() {
                  getOneClinicModel = state.getAllClinicsModel;
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
            if (state is GetAllClinicsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(color: primaryColor, width: 2),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 10,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            'Book a visit',
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'PoppinsBold'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      if (getOneClinicModel != null)
                        Container(
                          width: double.infinity,
                          height: 125,
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
                                  height: 118,
                                  child: Image.network(
                                      'https://pet-app.webbing-agency.com/storage/app/public/${getOneClinicModel!.data!.clinics?.data?[widget.index].picture}'),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      getOneClinicModel!
                                              .data!
                                              .clinics
                                              ?.data?[widget.index]
                                              .clinicName ??
                                          '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'PoppinsBold',
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      getOneClinicModel!
                                              .data!
                                              .clinics
                                              ?.data?[widget.index]
                                              .specialization ??
                                          '',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: grayTextColor,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: primaryColor,
                                          size: 16,
                                        ),
                                        Text(
                                          getOneClinicModel!
                                                  .data!
                                                  .clinics
                                                  ?.data?[widget.index]
                                                  .address ??
                                              '',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.monetization_on_outlined,
                                          color: primaryColor,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '${getOneClinicModel!.data!.clinics?.data?[widget.index].medicalFees} EGP',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 40),
                      const Text(
                        'Working Time',
                        style:
                            TextStyle(fontSize: 18, fontFamily: 'PoppinsBold'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${getOneClinicModel?.data?.clinics?.data?[widget.index].workingTimes}',
                        style: TextStyle(fontSize: 16, color: grayTextColor),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Working Days',
                        style:
                            TextStyle(fontSize: 18, fontFamily: 'PoppinsBold'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${getOneClinicModel?.data?.clinics?.data?[widget.index].workingDays}',
                        style: TextStyle(fontSize: 16, color: grayTextColor),
                      ),
                      const SizedBox(height: 40),
                      BlocConsumer<AddBookCubit, AddBookState>(
                        listener: (context, state) {
                          if (state is AddBookSuccess) {
                            if (state.addBookModel.status) {
                              CacheHelper.saveData(
                                key: 'id',
                                value: state.addBookModel.data?.book?.id,
                              ).then((value) {
                                showBookingConfirmation(context);
                              });
                            } else {
                              print(state.addBookModel.message);
                              print('تاكد من البيانات المدخله');
                              showToast(
                                message: state.addBookModel.message,
                                color: Colors.red,
                              );
                            }
                            if (state is AddBookFailure) {
                              showToast(
                                message: state.addBookModel.message,
                                color: Colors.red,
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Choose The Date',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'PoppinsBold'),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 75,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 7,
                                  itemBuilder: (context, index) {
                                    DateTime date = DateTime.now()
                                        .add(Duration(days: index));
                                    bool isSelected =
                                        selectedDate.day == date.day;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedDate = date;
                                        });
                                      },
                                      child: Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: isSelected
                                              ? primaryColor
                                              : Colors.grey[300],
                                        ),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                DateFormat('E').format(date),
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                date.day.toString(),
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 40),
                              const Text(
                                'Choose The Time',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'PoppinsBold'),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 40,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: availableTimes.length,
                                  itemBuilder: (context, index) {
                                    bool isSelected =
                                        selectedTimeIndex == index;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedTimeIndex = index;
                                        });
                                      },
                                      child: Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: isSelected
                                              ? primaryColor
                                              : Colors.grey[300],
                                        ),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: Center(
                                          child: Text(
                                            availableTimes[index].time,
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 50),
                              customButton(
                                title: 'Book Now',
                                function: () {
                                  if (selectedTimeIndex < 0) {
                                    showToast(
                                      message: 'Please select a time.',
                                      color: Colors.red,
                                    );
                                    return;
                                  }

                                  DateFormat formatter =
                                      DateFormat('yyyy-MM-dd HH:mm:ss');
                                  String selectedTime =
                                      availableTimes[selectedTimeIndex].time;
                                  DateTime appointmentDateTime = DateTime(
                                    selectedDate.year,
                                    selectedDate.month,
                                    selectedDate.day,
                                    int.parse(selectedTime.split(':')[0]),
                                    int.parse(selectedTime.split(':')[1]),
                                  );

                                  String formattedDateTime =
                                      formatter.format(appointmentDateTime);

                                  AddBookCubit.get(context).userAddBook(
                                      time: formattedDateTime,
                                      id: getOneClinicModel
                                          ?.data?.clinics?.data?[0].id);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showBookingConfirmation(BuildContext context) {
    if (selectedTimeIndex < 0) {
      showToast(
        message: 'Please select a time.',
        color: Colors.red,
      );
      return;
    }

    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String selectedTime = availableTimes[selectedTimeIndex].time;
    DateTime appointmentDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      int.parse(selectedTime.split(':')[0]),
      int.parse(selectedTime.split(':')[1]),
    );

    String formattedDateTime = formatter.format(appointmentDateTime);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: primaryColor,
                ),
                child: Image.asset('assets/images/back.png'),
              ),
              Container(
                height: 300,
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
                        'Booking Confirmed!',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'PoppinsBold',
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 68,
                        height: 69,
                        child: Image.asset('assets/images/true.png'),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Your appointment is scheduled for $formattedDateTime',
                        style: const TextStyle(color: Colors.white),
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
                            color: Colors.white,
                          ),
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

  void showToast({required String message, required Color color}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
