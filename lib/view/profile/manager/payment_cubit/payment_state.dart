part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentAddBankInitial extends PaymentState {}

final class PaymentAddBankLoading extends PaymentState {}

final class PaymentAddBankSuccess extends PaymentState {
  final AddBankModel addBankModel;

  PaymentAddBankSuccess({required this.addBankModel});
}

final class PaymentAddBankFailure extends PaymentState {
  final String message;
  PaymentAddBankFailure({required this.message});
}

final class PaymentAddWalletInitial extends PaymentState {}

final class PaymentAddWalletLoading extends PaymentState {}

final class PaymentAddWalletSuccess extends PaymentState {
  final AddWalletModel addWalletModel;

  PaymentAddWalletSuccess({required this.addWalletModel});
}

final class PaymentAddWalletFailure extends PaymentState {
  final String message;
  PaymentAddWalletFailure({required this.message});
}
