import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/profile/data/models/user_profile_models/add_bank_model.dart';
import 'package:pet_app/view/profile/data/models/user_profile_models/add_wallet_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of(context);

  AddBankModel? bankModel;
  AddWalletModel? walletModel;

  void userAddBank({
    required String name,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  }) {
    emit(PaymentAddBankLoading());
    DioHelper.postData(
      url: addBank,
      data: {
        'cardholder_name': name,
        'card_number': cardNumber,
        'expiry_date': expiryDate,
        'encrypted_cvv': cvv,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        bankModel = AddBankModel.fromJson(value.data);
        print('Parsed status: ${bankModel?.status}');
        print('Parsed message: ${bankModel?.message}');
        emit(PaymentAddBankSuccess(addBankModel: bankModel!));
      } else {
        emit(
          PaymentAddBankFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(PaymentAddBankFailure(message: error.toString()));
    });
  }

  void userAddWallet({
    required String phone,
    required String pin,
  }) {
    emit(PaymentAddWalletLoading());
    DioHelper.postData(
      url: addWallet,
      data: {
        'phone': phone,
        'pin': pin,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        walletModel = AddWalletModel.fromJson(value.data);
        print('Parsed status: ${walletModel?.status}');
        print('Parsed message: ${walletModel?.message}');
        emit(PaymentAddWalletSuccess(addWalletModel: walletModel!));
      } else {
        emit(
          PaymentAddWalletFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(PaymentAddWalletFailure(message: error.toString()));
    });
  }
}
