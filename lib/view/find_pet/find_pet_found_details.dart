import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/components/widget.dart';

import '../../model/find_pet_model/get_found_pets_model.dart';


class FindPetFoundDetails extends StatefulWidget {
  final FoundPet pet;
  FindPetFoundDetails({Key? key,required this.pet}) : super(key: key);

  @override
  State<FindPetFoundDetails> createState() => _FindPetFoundDetailsState();
}

class _FindPetFoundDetailsState extends State<FindPetFoundDetails> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    children: [

                      Container(
                        width: double.infinity,
                        height: 296,
                        child: Image.network(domain+widget.pet.foundPetGallery[0].image,fit: BoxFit.contain,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap:(){
                                Navigator.pop(context);
                              },
                              child: Container(

                                width: 25,
                                height: 25,
                                child: Image.asset('assets/images/ArrowBack.png'),
                              ),
                            ),
                            Spacer(),

                            Container(
                              width: 32,
                              height: 32,
                              child: Image.asset('assets/images/found.png'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              //categories

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.pet.type,style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'PoppinsBold'
                        ),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined, color: primaryColor, size: 15),
                                Text(
                                  widget.pet.foundLocation,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: grayTextColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.watch_later_outlined, color: primaryColor, size: 13),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  widget.pet.foundTime,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: grayTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 41,
                          width: 107,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 219, 229, 1),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.pet.gender=='female'?Image.asset('assets/images/female.png'):Image.asset('assets/images/male.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(widget.pet.gender,style: TextStyle(
                                  fontSize: 16
                              ),),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child:widget.pet.user.picture==null?Image.asset('assets/images/owner.jfif',fit: BoxFit.cover,): Image.network(domain+widget.pet.user.picture!,fit: BoxFit.fill,),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.pet.user.firstName,style: TextStyle(fontSize: 14),),
                            Text('Pet Finder',style: TextStyle(fontSize: 14,color: grayTextColor),)

                          ],
                        ),
                        Spacer(),


                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    PetGalleryWidget(
                      petGallery: widget.pet.foundPetGallery,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Found pet info',style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'PoppinsBold'
                    ),),
                    SizedBox(
                      height: 20,
                    ),
                    Text(widget.pet.foundInfo,style: TextStyle(
                        fontSize: 14,
                        color: grayTextColor
                    ),),

                    SizedBox(
                      height: 30,
                    ),
                    customButton(title: 'Send a message', function: (){

                      showBookingConfirmation(context);

                    }),

                    SizedBox(
                      height: 300,
                    ),






                  ],
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }

  void showBookingConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Stack(
            children: [

              Container(
                height: 223,
                width: double.infinity,
                child: Image.asset('assets/images/back.png'),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: primaryColor,
                ),
              ),
              Container(
                height: 223,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Potential Match!',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'PoppinsBold'
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Send a request to start a chat!',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'PoppinsBold'
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 150,
                                height: 46,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white
                                ),
                                child: Center(
                                  child:Text('Send a request',style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 14

                                  ),),
                                ),

                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 150,
                                height: 46,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: primaryColor,
                                    border: Border.all(
                                        color: Colors.white
                                    )
                                ),
                                child: Center(
                                  child:Text('Cancel request',style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14
                                  ),),
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),

            ],
          ),
        );
      },
    );
  }



}

class PetGalleryWidget extends StatelessWidget {
  final List<FoundPetGallery> petGallery;

  PetGalleryWidget({required this.petGallery});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gallery',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'PoppinsBold',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: petGallery.map((galleryItem) {
              final imageUrl = galleryItem.image;

              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  width: 106,
                  height: 98,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                    domain + imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error); // Handle errors
                    },
                  )
                      : Image.asset('assets/images/default.jpg'),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}





