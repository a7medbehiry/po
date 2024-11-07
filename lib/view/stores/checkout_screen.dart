import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../components/constant.dart';
import '../../components/widget.dart';
import '../../view_model/home_cubit/cubit.dart';
import '../../view_model/home_cubit/states.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool isVisa = true;
  bool isVodafone = false;
  late String walletNumber = '';
  File? _selectedImage; // Add this variable to hold the selected image
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path); // Set the selected image
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeCubit.get(context).getNumber();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {

          if(state is SuccessCheckOutState){
            showToast(message: 'Order Submited Successfully!', color: Colors.green);
          }
        },
        builder: (context, state){
          var number = HomeCubit.get(context).getNumberModel?.data?.payment.number;

          return Scaffold(
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
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
                                      border: Border.all(color: primaryColor, width: 2)),
                                  child: Center(
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        size: 10,
                                        color: primaryColor,
                                      ))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Checkout',
                              style: TextStyle(fontSize: 20, fontFamily: 'PoppinsBold'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        Row(
                          children: [
                            IconButton(onPressed: (){
                              setState(() {
                                HomeCubit.get(context).getNumber();

                                isVodafone = !isVodafone;
                                isVisa = false;
                              });
                            }, icon: isVodafone ? Icon(Icons.radio_button_checked, color: primaryColor) : Icon(Icons.radio_button_off_outlined)),
                            Text(
                              'Vodafone Cash',
                              style: TextStyle(fontSize: 14, fontFamily: 'PoppinsBold'),
                            ),
                          ],
                        ),
                        isVodafone
                            ? Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Transfer number',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: primaryColor)
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text('${number}'),
                                      ],
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),

                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Wallet Number',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: primaryColor
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12.0,
                                        horizontal: 16.0,
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your wallet number';
                                      } else if (value.length != 11) {
                                        return 'Wallet number must be exactly 11 digits';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      walletNumber = value!;
                                    },
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 40,),
                            Column(
                              children: [
                                Text(
                                  'Upload a photo of the payment',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                _selectedImage == null
                                    ? IconButton(
                                    onPressed: _pickImage,
                                    icon: Icon(
                                      Icons.cloud_upload_outlined,
                                      color: primaryColor,
                                    ))
                                    : Image.file(_selectedImage!, height: 150, width: 150),
                              ],
                            ),
                          ],
                        )
                            : SizedBox(height: 0,),

                        SizedBox(
                          height: 40,
                        ),

                        ConditionalBuilder(
                          condition: state is! LoadingCheckOutState,
                          builder: (context){
                            return customButton(
                              title: 'Check out',
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  print(walletNumber);

                                  if (_selectedImage != null) {
                                    HomeCubit.get(context).CheckOut(
                                      phone: walletNumber,
                                      receipt: _selectedImage!,
                                    );
                                  } else {
                                    // Handle the case where no image is selected
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Please upload a photo of the payment.')),
                                    );
                                  }
                                }
                              },
                            );
                          },
                          fallback: (context)=>Center(child: CircularProgressIndicator()),


                        ),

                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },


      ),
    );
  }
}
