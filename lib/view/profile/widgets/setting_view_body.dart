import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/components/widget.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/authentication/sign_in_screen.dart';
import 'package:pet_app/view/profile/data/models/user_profile_models/profile_get_data_model/profile_get_data_model.dart';
import 'package:pet_app/view/profile/manager/edit_profile_data_cubit/edit_profile_data_cubit.dart';
import 'package:pet_app/view/profile/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:pet_app/view/profile/manager/log_out_cubit/log_out_cubit.dart';
import 'package:pet_app/view/profile/widgets/custom_image_picker_function.dart';

class SettingViewBody extends StatefulWidget {
  const SettingViewBody({super.key});

  @override
  State<SettingViewBody> createState() => _SettingViewBodyState();
}

class _SettingViewBodyState extends State<SettingViewBody> {
  final _controller = ValueNotifier<bool>(false);

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  ProfileGetDataModel? profileGetDataModel;

  bool isEditingName = false;
  bool isEditingPassword = false;
  bool isEditingAddress = false;
  bool isEditingVisa = false;
  bool isEditingVodafone = false;

  late File pic;
  late String fName, lName;
  String previousFName = '';
  String previousLName = '';

  late String oldPassword, newPassword, confirmPassword;

  String previousOld = 'Current password';
  String previousNew = 'new password';
  String previousConfirm = 'confirm new password';

  late String address;
  String previousAddress = '';

  late String cardName, cardNumber, expiryDate, cvv;

  String previousCardName = '';
  String previousCardNumber = '';
  String previousExpiryDate = '';
  String previousCVV = '***';

  late String phoneNumber, pin;

  String previousPhoneNumber = '';
  String previousPin = '*****';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetProfileDataCubit, GetProfileDataState>(
      listener: (context, state) {
        if (state is GetProfileDataSuccess) {
          if (state.profileGetDataModel.status!) {
            setState(() {
              profileGetDataModel = state.profileGetDataModel;
            });
            print(CacheHelper.getData(key: 'token'));
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
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerOfScreen(
                    title: 'Settings',
                    function: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<EditProfileDataCubit, EditProfileDataState>(
                    listener: (context, state) {
                      if (state is EditProfileDataSuccess) {
                        if (state.changeProfileDataModel.status) {
                          showToast(
                            message: state.changeProfileDataModel.message,
                            color: Colors.green,
                          );
                        } else {
                          print(state.changeProfileDataModel.message);
                          print('تاكد من البيانات المدخله');
                          showToast(
                            message: state.changeProfileDataModel.message,
                            color: Colors.red,
                          );
                        }
                        if (state is EditProfileDataFailure) {
                          showToast(
                            message: state.changeProfileDataModel.message,
                            color: Colors.red,
                          );
                        }
                      }
                      if (state is ChangePasswordSuccess) {
                        if (state.changePasswordModel.status) {
                          showToast(
                            message: state.changePasswordModel.message,
                            color: Colors.green,
                          );
                        } else {
                          print(state.changePasswordModel.message);
                          print('تاكد من البيانات المدخله');
                          showToast(
                            message: state.changePasswordModel.message,
                            color: Colors.red,
                          );
                        }
                        if (state is ChangePasswordFailure) {
                          showToast(
                            message: state.changePasswordModel.message,
                            color: Colors.red,
                          );
                        }
                      }
                      if (state is UploadProfilePicSuccess) {
                        if (state.uploadProfilePicModel.status) {
                          showToast(
                            message: 'Picture Uploaded Successfully',
                            color: Colors.green,
                          );
                        } else {
                          print(state.uploadProfilePicModel.message);
                          print('تاكد من البيانات المدخله');
                          showToast(
                            message: state.uploadProfilePicModel.message,
                            color: Colors.red,
                          );
                        }
                        if (state is UploadProfilePicFailure) {
                          showToast(
                            message: state.uploadProfilePicModel.message,
                            color: Colors.red,
                          );
                        }
                      }
                      if (state is ChangeAddressSuccess) {
                        if (state.changeAddressModel.status) {
                          showToast(
                            message: 'Address Changed Successfully',
                            color: Colors.green,
                          );
                        } else {
                          print(state.changeAddressModel.message);
                          print('تاكد من البيانات المدخله');
                          showToast(
                            message: state.changeAddressModel.message,
                            color: Colors.red,
                          );
                        }
                        if (state is ChangeAddressFailure) {
                          showToast(
                            message: state.changeAddressModel.message,
                            color: Colors.red,
                          );
                        }
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImagePickerFunction(
                                onImageSelected: (value) {
                                  pic = value;
                                },
                                pic: profileGetDataModel?.data?.user?.picture !=
                                        null
                                    ? 'https://pet-app.webbing-agency.com/storage/app/public/${profileGetDataModel?.data?.user?.picture}'
                                    : null,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                                '${profileGetDataModel?.data?.user?.firstName ?? ''} ${profileGetDataModel?.data?.user?.lastName ?? ''}'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Account',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.transparent,
                              border: Border.all(
                                color: primaryColor,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/images/User-1.png'),
                                      const SizedBox(
                                        width: 24,
                                      ),
                                      const Text('Name'),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (isEditingName) {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();

                                                // Check if there is an actual change before calling the cubit function
                                                if (fName != previousFName ||
                                                    lName != previousLName) {
                                                  EditProfileDataCubit.get(
                                                          context)
                                                      .changeUserName(
                                                    firstName: fName,
                                                    lastName: lName,
                                                  );

                                                  // Update the previous name variables after change
                                                  previousFName = fName;
                                                  previousLName = lName;
                                                }
                                              }
                                            }
                                            GetProfileDataCubit.get(context)
                                                .userGetProfileData();

                                            // Toggle the edit state
                                            isEditingName = !isEditingName;
                                          });
                                        },
                                        child: Image.asset(
                                          isEditingName
                                              ? 'assets/images/Tick-1.png'
                                              : 'assets/images/edit.png',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  if (isEditingName)
                                    customProfileTextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          List<String> nameParts =
                                              value.trim().split(' ');

                                          if (nameParts.length > 1) {
                                            fName = nameParts[0];
                                            lName = nameParts.length > 1
                                                ? nameParts.sublist(1).join(' ')
                                                : ' ';
                                          } else {
                                            fName = nameParts[0];
                                            lName = '';
                                          }
                                        });
                                      },
                                      width: 220,
                                      hintText:
                                          '${profileGetDataModel?.data?.user?.firstName ?? ''} ${profileGetDataModel?.data?.user?.lastName ?? ''}',
                                      hasBorder: false,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 2,
                                          spreadRadius: 0.5,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset('assets/images/Lock.png'),
                                      const SizedBox(
                                        width: 24,
                                      ),
                                      const Text('Password'),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (isEditingPassword) {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();

                                                // Check if there is an actual change before calling the cubit function
                                                if (oldPassword != previousOld ||
                                                    newPassword !=
                                                        previousNew ||
                                                    confirmPassword !=
                                                        previousConfirm) {
                                                  EditProfileDataCubit.get(
                                                          context)
                                                      .userChangePassword(
                                                    oldPassword: oldPassword,
                                                    password: newPassword,
                                                    confirmPassword:
                                                        confirmPassword,
                                                  );

                                                  // Update the previous name variables after change
                                                  previousOld = oldPassword;
                                                  previousNew = newPassword;
                                                  previousConfirm =
                                                      confirmPassword;
                                                }
                                              }
                                            }

                                            // Toggle the edit state
                                            isEditingPassword =
                                                !isEditingPassword;
                                          });
                                        },
                                        child: Image.asset(
                                          isEditingPassword
                                              ? 'assets/images/Tick-1.png'
                                              : 'assets/images/edit.png',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  if (isEditingPassword)
                                    CustomPasswordProfileTextFormField(
                                      onSaved: (value) {
                                        oldPassword = value!;
                                      },
                                      width: 220,
                                      hintText: 'Current password',
                                      // hasBorder: false,
                                      // password: true,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 2,
                                          spreadRadius: 0.5,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  if (isEditingPassword)
                                    CustomPasswordProfileTextFormField(
                                      onSaved: (value) {
                                        newPassword = value!;
                                      },
                                      width: 220,
                                      hintText: 'New password',
                                      // hasBorder: false,
                                      // password: true,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 2,
                                          spreadRadius: 0.5,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  if (isEditingPassword)
                                    CustomPasswordProfileTextFormField(
                                      onSaved: (value) {
                                        confirmPassword = value!;
                                      },
                                      width: 220,
                                      hintText: 'Confirm new password',
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 2,
                                          spreadRadius: 0.5,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                  if (isEditingPassword)
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  Row(
                                    children: [
                                      Image.asset('assets/images/Location.png'),
                                      const SizedBox(
                                        width: 24,
                                      ),
                                      const Text('Address'),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (isEditingAddress) {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();

                                                // Check if there is an actual change before calling the cubit function
                                                if (address !=
                                                    previousAddress) {
                                                  EditProfileDataCubit.get(
                                                          context)
                                                      .userChangeAddress(
                                                    address: address,
                                                  );

                                                  // Update the previous name variables after change
                                                  previousAddress = address;
                                                }
                                              }
                                            }
                                            GetProfileDataCubit.get(context)
                                                .userGetProfileData();

                                            // Toggle the edit state
                                            isEditingAddress =
                                                !isEditingAddress;
                                          });
                                        },
                                        child: Image.asset(
                                          isEditingAddress
                                              ? 'assets/images/Tick-1.png'
                                              : 'assets/images/edit.png',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  // if (isEditingAddress)
                                  //   customProfileTextFormField(
                                  //     onSaved: (value) {
                                  //       address = value!;
                                  //     },
                                  //     hintText:
                                  //         '${profileGetDataModel?.data?.user?.}',
                                  //     hasBorder: false,
                                  //     boxShadow: const [
                                  //       BoxShadow(
                                  //         color: Colors.black26,
                                  //         blurRadius: 2,
                                  //         spreadRadius: 0.5,
                                  //         offset: Offset(0, 0),
                                  //       ),
                                  //     ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Notification',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                      border: Border.all(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/notify.png'),
                              const SizedBox(
                                width: 24,
                              ),
                              const Text('Push Notifications'),
                              const Spacer(),
                              AdvancedSwitch(
                                controller: _controller,
                                activeColor: Colors.green,
                                inactiveColor: Colors.grey,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                width: 50.0,
                                height: 30.0,
                                enabled: true,
                                disabledOpacity: 0.5,
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 24,
                  // ),
                  // ),
                  // Text(
                  //   'Payment',
                  //   style: TextStyle(
                  //     color: primaryColor,
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w700,
                  //     fontFamily: 'Poppins',
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // BlocConsumer<PaymentCubit, PaymentState>(
                  //   listener: (context, state) {
                  //     if (state is PaymentAddBankSuccess) {
                  //       if (state.addBankModel.status) {
                  //         showToast(
                  //           message: state.addBankModel.message,
                  //           color: Colors.green,
                  //         );
                  //       } else {
                  //         print(state.addBankModel.message);
                  //         print('تاكد من البيانات المدخله');
                  //         showToast(
                  //           message: state.addBankModel.message,
                  //           color: Colors.red,
                  //         );
                  //       }
                  //       if (state is PaymentAddBankFailure) {
                  //         showToast(
                  //           message: state.addBankModel.message,
                  //           color: Colors.red,
                  //         );
                  //       }
                  //     }
                  //     if (state is PaymentAddWalletSuccess) {
                  //       if (state.addWalletModel.status) {
                  //         showToast(
                  //           message: state.addWalletModel.message,
                  //           color: Colors.green,
                  //         );
                  //       } else {
                  //         print(state.addWalletModel.message);
                  //         print('تاكد من البيانات المدخله');
                  //         showToast(
                  //           message: state.addWalletModel.message,
                  //           color: Colors.red,
                  //         );
                  //       }
                  //       if (state is PaymentAddWalletFailure) {
                  //         showToast(
                  //           message: state.addWalletModel.message,
                  //           color: Colors.red,
                  //         );
                  //       }
                  //     }
                  //   },
                  //   builder: (context, state) {
                  //     return Column(
                  //       children: [
                  //         Container(
                  //           width: double.infinity,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(8),
                  //             color: Colors.transparent,
                  //             border: Border.all(
                  //               color: primaryColor,
                  //               width: 2,
                  //             ),
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(8),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Row(
                  //                   children: [
                  //                     Image.asset('assets/images/credit.png'),
                  //                     const SizedBox(
                  //                       width: 24,
                  //                     ),
                  //                     const Text(
                  //                       'My Visa',
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.w600,
                  //                       ),
                  //                     ),
                  //                     const Spacer(),
                  //                     GestureDetector(
                  //                       onTap: () {
                  //                         setState(() {
                  //                           if (isEditingVisa) {
                  //                             if (_formKey.currentState!
                  //                                 .validate()) {
                  //                               _formKey.currentState!.save();

                  //                               // Check if there is an actual change before calling the cubit function
                  //                               if (cardName !=
                  //                                       previousCardName ||
                  //                                   cardNumber !=
                  //                                       previousCardNumber ||
                  //                                   expiryDate !=
                  //                                       previousExpiryDate ||
                  //                                   cvv != previousCVV) {
                  //                                 PaymentCubit.get(context)
                  //                                     .userAddBank(
                  //                                   name: cardName,
                  //                                   cardNumber: cardNumber,
                  //                                   expiryDate: expiryDate,
                  //                                   cvv: cvv,
                  //                                 );

                  //                                 // Update the previous name variables after change
                  //                                 previousCardName = cardName;
                  //                                 previousCardNumber =
                  //                                     cardNumber;
                  //                                 previousExpiryDate =
                  //                                     expiryDate;
                  //                                 previousCVV = cvv;
                  //                               }
                  //                             }
                  //                           }
                  //                           GetProfileDataCubit.get(context)
                  //                               .userGetProfileData();
                  //                           // Toggle the edit state
                  //                           isEditingVisa = !isEditingVisa;
                  //                         });
                  //                       },
                  //                       child: Image.asset(
                  //                         isEditingVisa
                  //                             ? 'assets/images/Tick-1.png'
                  //                             : 'assets/images/edit.png',
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 16,
                  //                 ),
                  //                 if (isEditingVisa)
                  //                   const Text(
                  //                     'Card Holder Name',
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.w600,
                  //                     ),
                  //                   ),
                  //                 if (isEditingVisa)
                  //                   const SizedBox(
                  //                     height: 8,
                  //                   ),
                  //                 if (isEditingVisa)
                  //                   customProfileTextFormField(
                  //                     onSaved: (value) {
                  //                       cardName = value!;
                  //                     },
                  //                     hintText: profileGetDataModel!
                  //                             .data!.bankCards!.isEmpty
                  //                         ? ''
                  //                         : '${profileGetDataModel?.data?.user?.bankcard?.last.cardholderName}',
                  //                     hasBorder: false,
                  //                     boxShadow: const [
                  //                       BoxShadow(
                  //                         color: Colors.black26,
                  //                         blurRadius: 2,
                  //                         spreadRadius: 0.5,
                  //                         offset: Offset(0, 0),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 if (isEditingVisa)
                  //                   const SizedBox(
                  //                     height: 8,
                  //                   ),
                  //                 if (isEditingVisa)
                  //                   const Text(
                  //                     'Card Number',
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.w600,
                  //                     ),
                  //                   ),
                  //                 if (isEditingVisa)
                  //                   const SizedBox(
                  //                     height: 8,
                  //                   ),
                  //                 if (isEditingVisa)
                  //                   customProfileTextFormField(
                  //                     onSaved: (value) {
                  //                       cardNumber = value!;
                  //                     },
                  //                     keyboardType: TextInputType.number,
                  //                     hintText: profileGetDataModel!
                  //                             .data!.bankCards!.isEmpty
                  //                         ? ''
                  //                         : '${profileGetDataModel?.data?.user?.bankcard?.last.cardNumber}',
                  //                     hasBorder: false,
                  //                     boxShadow: const [
                  //                       BoxShadow(
                  //                         color: Colors.black26,
                  //                         blurRadius: 2,
                  //                         spreadRadius: 0.5,
                  //                         offset: Offset(0, 0),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 if (isEditingVisa)
                  //                   Row(
                  //                     children: [
                  //                       Expanded(
                  //                         child: customTextFormField(
                  //                           onSaved: (value) {
                  //                             expiryDate = value!;
                  //                           },
                  //                           hasBorder: false,
                  //                           color: const Color(0xffFDFDFD),
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.w600,
                  //                           title: 'Expiry Date',
                  //                           hintText: profileGetDataModel!
                  //                                   .data!.bankCards!.isEmpty
                  //                               ? ''
                  //                               : '${profileGetDataModel?.data?.user?.bankcard?.last.expiryDate}',
                  //                           boxShadow: const [
                  //                             BoxShadow(
                  //                               color: Colors.black26,
                  //                               blurRadius: 2,
                  //                               spreadRadius: 0.5,
                  //                               offset: Offset(0, 0),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       const SizedBox(
                  //                         width: 10,
                  //                       ),
                  //                       Expanded(
                  //                         child: customTextFormField(
                  //                           onSaved: (value) {
                  //                             cvv = value!;
                  //                           },
                  //                           hasBorder: false,
                  //                           color: const Color(0xffFDFDFD),
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.w600,
                  //                           title: 'CVV',
                  //                           hintText: '***',
                  //                           boxShadow: const [
                  //                             BoxShadow(
                  //                               color: Colors.black26,
                  //                               blurRadius: 2,
                  //                               spreadRadius: 0.5,
                  //                               offset: Offset(0, 0),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 const SizedBox(
                  //                   height: 16,
                  //                 ),
                  //                 Row(
                  //                   children: [
                  //                     Image.asset('assets/images/vodafone.png'),
                  //                     const SizedBox(
                  //                       width: 24,
                  //                     ),
                  //                     const Text(
                  //                       'Vodafone Cash',
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.w600,
                  //                       ),
                  //                     ),
                  //                     const Spacer(),
                  //                     GestureDetector(
                  //                       onTap: () {
                  //                         setState(() {
                  //                           if (isEditingVodafone) {
                  //                             if (_formKey.currentState!
                  //                                 .validate()) {
                  //                               _formKey.currentState!.save();

                  //                               // Check if there is an actual change before calling the cubit function
                  //                               if (phoneNumber !=
                  //                                       previousPhoneNumber ||
                  //                                   pin != previousPin) {
                  //                                 PaymentCubit.get(context)
                  //                                     .userAddWallet(
                  //                                         phone: phoneNumber,
                  //                                         pin: pin);

                  //                                 // Update the previous name variables after change
                  //                                 previousPhoneNumber =
                  //                                     phoneNumber;

                  //                                 previousPin = pin;
                  //                               }
                  //                             }
                  //                           }
                  //                           GetProfileDataCubit.get(context)
                  //                               .userGetProfileData();
                  //                           // Toggle the edit state
                  //                           isEditingVodafone =
                  //                               !isEditingVodafone;
                  //                         });
                  //                       },
                  //                       child: Image.asset(
                  //                         isEditingVodafone
                  //                             ? 'assets/images/Tick-1.png'
                  //                             : 'assets/images/edit.png',
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 16,
                  //                 ),
                  //                 if (isEditingVodafone)
                  //                   const Text(
                  //                     'Wallet Number',
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.w600,
                  //                     ),
                  //                   ),
                  //                 if (isEditingVodafone)
                  //                   const SizedBox(
                  //                     height: 8,
                  //                   ),
                  //                 if (isEditingVodafone)
                  //                   customProfileTextFormField(
                  //                     onSaved: (value) {
                  //                       phoneNumber = value!;
                  //                     },
                  //                     hintText: profileGetDataModel!
                  //                             .data!.wallets!.isEmpty
                  //                         ? ''
                  //                         : '${profileGetDataModel?.data?.user?.wallet?.last.phone}',
                  //                     hasBorder: false,
                  //                     boxShadow: const [
                  //                       BoxShadow(
                  //                         color: Colors.black26,
                  //                         blurRadius: 2,
                  //                         spreadRadius: 0.5,
                  //                         offset: Offset(0, 0),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 if (isEditingVodafone)
                  //                   const SizedBox(
                  //                     height: 8,
                  //                   ),
                  //                 if (isEditingVodafone)
                  //                   const Text(
                  //                     'PIN',
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.w600,
                  //                     ),
                  //                   ),
                  //                 if (isEditingVodafone)
                  //                   const SizedBox(
                  //                     height: 8,
                  //                   ),
                  //                 if (isEditingVodafone)
                  //                   customProfileTextFormField(
                  //                     onSaved: (value) {
                  //                       pin = value!;
                  //                     },
                  //                     hintText: '*****',
                  //                     hasBorder: false,
                  //                     boxShadow: const [
                  //                       BoxShadow(
                  //                         color: Colors.black26,
                  //                         blurRadius: 2,
                  //                         spreadRadius: 0.5,
                  //                         offset: Offset(0, 0),
                  //                       ),
                  //                     ],
                  //                   ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Log Out',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BlocConsumer<LogOutCubit, LogOutState>(
                    listener: (context, state) {
                      if (state is LogOutSuccess) {
                        if (state.logOutModel.status) {
                          CacheHelper.removeDate(key: 'email');
                          CacheHelper.removeDate(
                            key: 'token',
                          ).then((value) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          });
                        } else {
                          print(state.logOutModel.message);
                          showToast(
                            message: state.logOutModel.message,
                            color: Colors.red,
                          );
                        }
                        if (state is LogOutFailure) {
                          showToast(
                            message: state.logOutModel.message,
                            color: Colors.red,
                          );
                        }
                      }
                    },
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          LogOutCubit.get(context).userLogout();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent,
                            border: Border.all(
                              color: primaryColor,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                        'assets/images/Logout-Vertical.png'),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                    const Text('Log Out'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
