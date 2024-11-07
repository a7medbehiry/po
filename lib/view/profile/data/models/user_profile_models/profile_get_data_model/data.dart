import 'bank_card.dart';
import 'user.dart';
import 'wallet.dart';

class Data {
  User? user;
  List<BankCard>? bankCards;
  List<Wallet>? wallets;

  Data({this.user, this.bankCards, this.wallets});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      bankCards: (json['bankCards'] as List<dynamic>?)
          ?.map((e) => BankCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      wallets: (json['wallets'] as List<dynamic>?)
          ?.map((e) => Wallet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'bankCards': bankCards?.map((e) => e.toJson()).toList(),
      'wallets': wallets?.map((e) => e.toJson()).toList(),
    };
  }
}
