import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:pet_app/model/find_pet_model/add_your_lost_pet.dart';
import 'package:pet_app/model/find_pet_model/get_found_pets_model.dart';
import 'package:pet_app/model/find_pet_model/get_lost_pets_model.dart';
import 'package:pet_app/model/find_pet_model/get_my_lost_pets_model.dart';
import 'package:pet_app/model/store_model/checkout_model.dart';
import 'package:pet_app/model/store_model/get_number_model.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view_model/home_cubit/states.dart';

import '../../model/find_pet_model/add_your_found_pet.dart';
import '../../model/find_pet_model/get_my_found_pets_model.dart';
import '../../model/home_model/get_search_filter_model.dart';
import '../../model/market_model/add_new_market_pet.dart';
import '../../model/market_model/get_market_filter.dart';
import '../../model/store_model/all_offer_model.dart';
import '../../model/store_model/all_store_model.dart';
import '../../model/store_model/cart_model.dart';
import '../../network/end_points.dart';
import '../../network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates>{

//newww

  HomeCubit() : super(HomeInitialState());


  static HomeCubit get(context) => BlocProvider.of(context);


  // GetDogsModel? getDogsModel;
  //
  // void getDogs(){
  //   emit(GetDogsLoadingState());
  //
  //   DioHelper.getData(
  //       url: GETDOGS,
  //       query: null,
  //     token: CacheHelper.getData(key: 'token'),
  //
  //   ).then((value){
  //     getDogsModel = GetDogsModel.fromJson(value?.data);
  //     print('data getDogsModel : ${getDogsModel.toString()}');
  //     print(getDogsModel?.message);
  //     print(getDogsModel?.status);
  //     // Accessing the data
  //     print('Status: ${getDogsModel?.status}');
  //     print('Message: ${getDogsModel?.message}');
  //     print('Dogs: ${getDogsModel?.dogs.length}');
  //     print('Current Page: ${getDogsModel?.pagination.currentPage}');
  //
  //     emit(GetDogsSuccessState());
  //
  //   }).catchError((error){
  //
  //     emit(GetDogsErrorState());
  //
  //     print('error get dog' + error.toString());
  //   });
  //
  //
  // }


  GetSearchFilterModel? getSearchFilterModel;

  void getSearch({
    required String type,
    String? gender,
    String? age
  })
  {
    emit(GetSearchLoadingState());

    // Initialize the requestData map with the required 'type' key
    final Map<String, dynamic> requestData = {
      'type': type,
    };

    // Conditionally add 'gender' and 'age' to requestData if they are not null or empty
    if (gender != null && gender.isNotEmpty) {
      requestData['gender'] = gender;
    }

    if (age != null && age.isNotEmpty) {
      requestData['age'] = age;
    }


    DioHelper.getData(
      url: GETSEARCH,
      query: null,
      token: CacheHelper.getData(key: 'token'),
        data: requestData

    ).then((value){
      getSearchFilterModel = GetSearchFilterModel.fromJson(value?.data);
      print('data getSearchModel : ${getSearchFilterModel.toString()}');
      print(getSearchFilterModel?.message);
      print(getSearchFilterModel?.status);
      // Accessing the data
      print('Status: ${getSearchFilterModel?.status}');
      print('Message: ${getSearchFilterModel?.message}');
      print('Dogs: ${getSearchFilterModel?.pets.length}');
      print('Current Page: ${getSearchFilterModel?.pagination.currentPage}');
      emit(GetSearchSuccessState());

    }).catchError((error){

      emit(GetSearchErrorState());
      print('error get search' + error.toString());
    });


  }


  GetAllStoreModel? getAllStoreModel;

  void getAllStore()
  {
    emit(GetStoreLoadingState());
    DioHelper.getData(
        url: GETALLSTORE,
        query: null,
        token: CacheHelper.getData(key: 'token'),
    ).then((value){
      getAllStoreModel = GetAllStoreModel.fromJson(value?.data);
      print('data getSearchModel : ${getAllStoreModel.toString()}');
      print(getAllStoreModel?.message);
      print(getAllStoreModel?.status);
      // Accessing the data
      print('Status: ${getAllStoreModel?.status}');
      print('Message: ${getAllStoreModel?.message}');

      emit(GetStoreSuccessState());
    }).catchError((error){
      emit(GetStoreErrorState());
      print('error get search' + error.toString());
    });


  }

  GetAllOfferModel? getAllOfferModel;

  void getAllOffer()
  {
    emit(GetOfferLoadingState());
    DioHelper.getData(
      url: GETALLOFFER,
      query: null,
      token: CacheHelper.getData(key: 'token'),
    ).then((value){
      getAllOfferModel = GetAllOfferModel.fromJson(value?.data);
      print('data getOfferModel : ${getAllOfferModel.toString()}');
      print(getAllOfferModel?.message);
      print(getAllOfferModel?.status);
      print(getAllOfferModel?.data.offers.length);

      // Accessing the data
      print('Status: ${getAllOfferModel?.status}');
      print('Message: ${getAllOfferModel?.message}');

      emit(GetOfferSuccessState());
    }).catchError((error){
      emit(GetOfferErrorState());
      print('error get search' + error.toString());
    });


  }


  // GetStoreDataModel? getStoreDataModel;
  //
  // void getStoreDate()
  // {
  //   emit(GetStoreDataLoadingState());
  //   DioHelper.getData(
  //     url: GETSTOREDATA,
  //     query: null,
  //     token: CacheHelper.getData(key: 'token'),
  //   ).then((value){
  //     getStoreDataModel = GetStoreDataModel.fromJson(value?.data);
  //     print('data getStoreData : ${getStoreDataModel.toString()}');
  //     print(getStoreDataModel?.message);
  //     print(getStoreDataModel?.status);
  //     print(getStoreDataModel?.data.store.name);
  //
  //     // Accessing the data
  //     print('Status: ${getStoreDataModel?.status}');
  //     print('Message: ${getStoreDataModel?.message}');
  //
  //     emit(GetStoreDataSuccessState());
  //   }).catchError((error){
  //     emit(GetStoreDataErrorState());
  //     print('error get search' + error.toString());
  //   });
  //
  //
  // }


  void addToCart(int productId,int quantity){
    emit(AddToCartLoadingState());
    DioHelper.postData(
      url: ADDTOCART,
      query: null,
      token: CacheHelper.getData(key: 'token'),
      data: {
        'product_id':productId,
        'quantity':quantity,
      },
    ).then((value) {
      if (value != null) {
        print('data add cart : ${jsonEncode(value.data)}');
        emit(AddToCartSuccessState());
        // getCartData(); // Re-fetch cart data to update numberOfCart
      } else {
        emit(AddToCartErrorState());
      }
    }).catchError((error){
      emit(AddToCartErrorState());
      print('error' + error.toString());
    });
  }

  void removeCart(int cartId){
    emit(RemoveCartLoadingState());
    DioHelper.postData(
      url: REMOVECART,
      query: null,
      token: CacheHelper.getData(key: 'token'),
      data: {
        'cart_id':cartId,
      },
    ).then((value) {
      if (value != null) {
        print('data remove cart : ${jsonEncode(value.data)}');
        emit(RemoveCartSuccessState());
        getCartData();
      } else {
        emit(RemoveCartErrorState());
      }
    }).catchError((error){
      emit(RemoveCartErrorState());
      print('error' + error.toString());
    });
  }


  void updateProductQuantityFromCart(int productId,int newQuantity){

    emit(UpdateCartLoadingState());
    DioHelper.postData(
      url: UPDATEPRODUCTQUANTITYCART,
      query: null,
      token: CacheHelper.getData(key: 'token'),
      data: {
        'product_id':productId,
        'quantity':newQuantity,
      },
    ).then((value) {
      if (value != null) {
        print('data Update cart : ${jsonEncode(value.data)}');
        emit(UpdateCartSuccessState());
        getCartData();
      } else {
        emit(UpdateCartErrorState());
      }
    }).catchError((error){
      emit(UpdateCartErrorState());
      print('error' + error.toString());
    });


  }



  CartModel? cartModel;
  Future<void> getCartData()async{
    emit(GetCartLoadingState());
    DioHelper.getData(
        url: GETCART,
        query: null,
        token: CacheHelper.getData(key: 'token')
    ).then((value) {
      if (value != null) {
        print('data get cart : ${jsonEncode(value.data)}');
        cartModel = CartModel.fromJson(value.data);
        print('cart status: ${cartModel?.status}');
        print('cart message: ${cartModel?.message}');
        // print('cart lenght: ${cartModel?.data.length}');
        // Calculate the total number of items in the cart
        emit(GetCartSuccessState());
      } else {
        emit(GetCartErrorState());
      }
    }).catchError((error){
      emit(GetCartErrorState());
      print('error' + error.toString());
    });
  }




  GetMarketFilterModel? getMarketFilterModel;

  void getMarketFilter({
    required String type,
    String? gender,
    String? age,
    bool? adaption
  })
  {
    emit(GetMarketLoadingState());

    // Initialize the requestData map with the required 'type' key
    final Map<String, dynamic> requestData = {
      'type': type,
    };

    // Conditionally add 'gender' and 'age' to requestData if they are not null or empty
    if (gender != null && gender.isNotEmpty) {
      requestData['gender'] = gender;
    }

    if (age != null && age.isNotEmpty) {
      requestData['age'] = age;
    }

    if (adaption != null ) {
      requestData['for_adoption'] = adaption;
    }


    DioHelper.getData(
        url: GETMARKET,
        query: null,
        token: CacheHelper.getData(key: 'token'),
        data: requestData

    ).then((value){
      getMarketFilterModel = GetMarketFilterModel.fromJson(value?.data);
      print('data getSearchModel : ${getMarketFilterModel.toString()}');
      print(getMarketFilterModel?.message);
      print(getMarketFilterModel?.status);
      // Accessing the data
      print('Status: ${getMarketFilterModel?.status}');
      print('Message: ${getMarketFilterModel?.message}');
      print('Dogs: ${getMarketFilterModel?.pets.length}');
      print('Current Page: ${getMarketFilterModel?.pagination.currentPage}');
      emit(GetMarketSuccessState());

    }).catchError((error){

      emit(GetMarketErrorState());
      print('error get search' + error.toString());
    });


  }


  AddNewMarketPetModel? addNewMarketPetModel;


  void addNewMarketPet({
    required var name,
    required var age,
    required var type,
    required var gender,
     var breed,
    required var for_adoption,
    required var price,
})
  {
    emit(LoadingAddMarketPetState());
    DioHelper.postData(
      url: ADDNEWMARKETPET,
      query: null,
      token: CacheHelper.getData(key: 'token'),
      data: {
        'name':name,
        'age':age,
        'type':type,
        'gender':gender,
        'breed':breed,
        'for_adoption':for_adoption,
        'price':price,
      },
    ).then((value) {
      if (value != null) {
        print('data add New Market Pet : ${jsonEncode(value.data)}');
        addNewMarketPetModel = AddNewMarketPetModel.fromJson(value.data);
        print(addNewMarketPetModel?.message);
        print(addNewMarketPetModel?.status);
        emit(SuccessAddMarketPetState());
      } else {
        emit(ErrorAddMarketPetState());
      }
    }).catchError((error){
      emit(ErrorAddMarketPetState());
      print('error' + error.toString());
    });
  }





  GetFoundPetsModel? getFoundPetsModel;

  void getFoundPets({
    String? type,
    String? gender,
    String? breed,
  })
  {
    emit(GetFoundPetsLoadingState());

    // Initialize the requestData map
    final Map<String, dynamic> requestData = {};

    // Conditionally add 'type', 'gender', and 'breed' to requestData if they are not null or empty
    if (type != null && type.isNotEmpty) {
      requestData['type'] = type;
    }

    if (gender != null && gender.isNotEmpty) {
      requestData['gender'] = gender;
    }

    if (breed != null && breed.isNotEmpty) {
      requestData['breed'] = breed;
    }
    DioHelper.getData(
      url: GETFOUNDPETS,
      query: null,
      token: CacheHelper.getData(key: 'token'),
      data: requestData,
    ).then((value) {
      getFoundPetsModel = GetFoundPetsModel.fromJson(value?.data);
      print('data getFoundPetsModel : ${getFoundPetsModel.toString()}');
      print(getFoundPetsModel?.message);
      print(getFoundPetsModel?.status);
      // Accessing the data
      print('Status: ${getFoundPetsModel?.status}');
      print('Message: ${getFoundPetsModel?.message}');
      print('Dogs: ${getFoundPetsModel?.foundPets.length}');
      print('Current Page: ${getFoundPetsModel?.pagination.currentPage}');
      emit(GetFoundPetsSuccessState());
    }).catchError((error) {
      emit(GetFoundPetsErrorState());
      print('error get search' + error.toString());
    });
  }


  GetMyFoundPetsModel? getMyFoundPetsModel;

  void getMyFoundPets() {
    emit(GetMyFoundPetsLoadingState());

    DioHelper.getData(
      url: GETMYFOUNDPETS,
      query: null,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print('Response Data: ${value?.data}'); // Print the raw response
      if (value?.data is Map<String, dynamic>) {
        getMyFoundPetsModel = GetMyFoundPetsModel.fromJson(value!.data as Map<String, dynamic>);
        print('data getMyFoundPetsModel : ${getMyFoundPetsModel.toString()}');
        print(getMyFoundPetsModel?.message);
        print(getMyFoundPetsModel?.status);
        print('Found Pets Count: ${getMyFoundPetsModel?.foundPets.length}');
        emit(GetMyFoundPetsSuccessState());
      } else {
        print('Unexpected data format');
      }
    }).catchError((error) {
      emit(GetMyFoundPetsErrorState());
      print('error get search: ' + error.toString());
    });
  }



  GetLostPetsModel? getLostPetsModel;

  void getLostPets({
    String? type,
    String? gender,
    String? age,
  })
  {
    emit(GetLostPetsLoadingState());

    // Initialize the requestData map
    final Map<String, dynamic> requestData = {};

    // Conditionally add 'type', 'gender', and 'breed' to requestData if they are not null or empty
    if (type != null && type.isNotEmpty) {
      requestData['type'] = type;
    }

    if (gender != null && gender.isNotEmpty) {
      requestData['gender'] = gender;
    }

    if (age != null && age.isNotEmpty) {
      requestData['age'] = age;
    }
    DioHelper.getData(
      url: GETLOSTPETS,
      query: null,
      token: CacheHelper.getData(key: 'token'),
      data: requestData,
    ).then((value) {
      getLostPetsModel = GetLostPetsModel.fromJson(value?.data);
      print('data getFoundPetsModel : ${getLostPetsModel.toString()}');
      print(getLostPetsModel?.message);
      print(getLostPetsModel?.status);
      // Accessing the data
      print('Status: ${getLostPetsModel?.status}');
      print('Message: ${getLostPetsModel?.message}');
      print('Dogs: ${getLostPetsModel?.lostPets.length}');
      print('Current Page: ${getLostPetsModel?.pagination.currentPage}');
      emit(GetLostPetsSuccessState());
    }).catchError((error) {
      emit(GetLostPetsErrorState());
      print('error get search' + error.toString());
    });
  }

  GetMyLostPetsModel? getMyLostPetsModel;

  void getMyLostPets()
  {
    emit(GetMyLostPetsLoadingState());

    DioHelper.getData(
      url: GETMYLOSTPETS,
      query: null,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      getMyLostPetsModel = GetMyLostPetsModel.fromJson(value?.data);
      print('Status: ${getMyLostPetsModel?.status}');
      print('Message: ${getMyLostPetsModel?.message}');
      print('Dogs: ${getMyLostPetsModel?.lostPets.length}');
      emit(GetMyLostPetsSuccessState());
    }).catchError((error) {
      emit(GetMyLostPetsErrorState());
      print('error get My Lost' + error.toString());
    });
  }


 late AddYourLostPet? addYourLostPet;

  void addLostPet({
    required String name,
    required String age,
    required String type,
    required String gender,
    required String breed,
    required String lastseen_location,
    required String lastseen_time,
    required String lastseen_info,
    required List<File> images, // Updated to handle a list of images
  }) async
  {
    emit(LoadingAddLostPetState());

    Map<String, dynamic> formDataMap = {
      'name': name,
      'age': age,
      'type': type,
      'gender': gender,
      'breed': breed,
      'lastseen_location': lastseen_location,
      'lastseen_time': lastseen_time,
      'lastseen_info': lastseen_info,
    };

    // If the server expects 'images[]'
    for (var i = 0; i < images.length; i++) {
      formDataMap['images[$i]'] = await MultipartFile.fromFile(
        images[i].path,
        filename: images[i].path.split('/').last,
      );
    }


    FormData formData = FormData.fromMap(formDataMap);

    DioHelper.postImageData(
      url: ADDLOSTPET,
      data: formData,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        addYourLostPet = AddYourLostPet.fromJson(value.data);
        print('Parsed status: ${addYourLostPet?.status}');
        print('Parsed message: ${addYourLostPet?.message}');
        print('Parsed id: ${addYourLostPet?.data.pet.id}');
        emit(SuccessAddLostPetState());
      } else {
        emit(ErrorAddLostPetState());
      }
    }).catchError((error) {
      emit(ErrorAddLostPetState());
    });
  }


  late AddYourFoundPet? addYourFoundPet;

  void addFoundPet({
    required String type,
    required String gender,
    required String breed,
    required String found_location,
    required String found_time,
    required String found_info,
    required List<File> images, // Updated to handle a list of images
  }) async
  {
    emit(LoadingAddFoundPetState());

    Map<String, dynamic> formDataMap = {
      'type': type,
      'gender': gender,
      'breed': breed,
      'found_location': found_location,
      'found_time': found_time,
      'found_info': found_info,
    };

    // If the server expects 'images[]'
    for (var i = 0; i < images.length; i++) {
      formDataMap['images[$i]'] = await MultipartFile.fromFile(
        images[i].path,
        filename: images[i].path.split('/').last,
      );
    }


    FormData formData = FormData.fromMap(formDataMap);

    DioHelper.postImageData(
      url: ADDFOUNDPET,
      data: formData,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        addYourFoundPet = AddYourFoundPet.fromJson(value.data);
        print('Parsed status: ${addYourFoundPet?.status}');
        print('Parsed message: ${addYourFoundPet?.message}');
        print('Parsed id: ${addYourFoundPet?.data.pet.id}');
        emit(SuccessAddFoundPetState());
      } else {
        emit(ErrorAddFoundPetState());
      }
    }).catchError((error) {
      emit(ErrorAddFoundPetState());
    });
  }


  GetNumberModel? getNumberModel;

  void getNumber()
  {
    emit(GetNumberLoadingState());

    DioHelper.getData(
      url: GETNUMBER,
      query: null,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      getNumberModel = GetNumberModel.fromJson(value?.data);
      print('Status: ${getNumberModel?.status}');
      print('Message: ${getNumberModel?.message}');
      print('number: ${getNumberModel?.data?.payment.number}');
      emit(GetNumberSuccessState());
    }).catchError((error) {
      emit(GetNumberErrorState());
      print('error get Number' + error.toString());
    });
  }



  late CheckOutModel? checkOutModel;

  void CheckOut({
    required String phone,
    required File receipt, // Updated to handle a single image
  }) async
  {
    emit(LoadingCheckOutState());

    Map<String, dynamic> formDataMap = {
      'phone': phone,
      'receipt': await MultipartFile.fromFile(
        receipt.path,
        filename: receipt.path.split('/').last,
      ),
    };

    FormData formData = FormData.fromMap(formDataMap);

    DioHelper.postImageData(
      url: CHECKOUT,
      data: formData,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        checkOutModel = CheckOutModel.fromJson(value.data);
        print('Parsed status: ${checkOutModel?.status}');
        print('Parsed message: ${checkOutModel?.message}');
        emit(SuccessCheckOutState());
      } else {
        emit(ErrorCheckOutState());
      }
    }).catchError((error) {
      emit(ErrorCheckOutState());
    });
  }



  Future<void> deleteFoundPet(int petId) async {
    var headers = {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}', // Replace with actual authorization token
    };

    var dio = Dio();

    try {
      var response = await dio.request(
        'https://pet-app.webbing-agency.com/api/found-pets/$petId/delete',
        options: Options(
          method: 'POST',
          headers: headers,
          followRedirects: true,  // Allow redirects
          validateStatus: (status) {
            // Accept any status code
            return status != null && status < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Pet deleted successfully');
        getMyFoundPets();
        print(json.encode(response.data)); // Print response data if needed
      } else if (response.statusCode == 302) {
        // Handle redirection manually if needed
        print('Redirecting to: ${response.headers.value('location')}');
      } else {
        print('Failed to delete pet: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error deleting pet: $e');
    }
  }

  Future<void> deleteLostPet(int petId) async {
    var headers = {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}', // Replace with actual authorization token
    };

    var dio = Dio();

    try {
      var response = await dio.request(
        'https://pet-app.webbing-agency.com/api/lost-pets/$petId/delete',
        options: Options(
          method: 'POST',
          headers: headers,
          followRedirects: true,  // Allow redirects
          validateStatus: (status) {
            // Accept any status code
            return status != null && status < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Pet deleted successfully');
        getMyLostPets();
        print(json.encode(response.data)); // Print response data if needed
      } else if (response.statusCode == 302) {
        // Handle redirection manually if needed
        print('Redirecting to: ${response.headers.value('location')}');
      } else {
        print('Failed to delete pet: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error deleting pet: $e');
    }
  }




}
