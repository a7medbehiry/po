import 'package:dio/dio.dart';

class PaymobManager {
  final Dio _dio = Dio();

  final String apiKey = 'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T0RJM056RXlMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuTHFObjZQcW5Uc1FXTWkyN3ZFb0c5NzBrcllHcjhrUmxyN0s2c0FSZlkzdVlMNGxLb0xWb3d1S0Rkbms4Y0pjaTFsZFZmRWRTN21qdC1YVjVieW5zWmc='; // Replace with your API key
  final String integrationId = '3936210'; // Replace with your Integration ID
  final String iframeId = '768024'; // Replace with your IFrame ID

  Future<String> payWithPaymob(int amount) async {
    try {
      String token = await getToken();
      int orderId = await getOrderId(token: token, amount: (100 * amount).toString());
      String paymentKey = await getPaymentKey(token: token, orderId: orderId.toString(), amount: (100 * amount).toString());
      return paymentKey;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    Response response = await _dio.post(
      'https://accept.paymobsolutions.com/api/auth/tokens',
      data: {'api_key': apiKey},
    );
    return response.data['token'];
  }

  Future<int> getOrderId({required String token, required String amount}) async {
    final response = await _dio.post(
      'https://accept.paymobsolutions.com/api/ecommerce/orders',
      data: {
        'auth_token': token,
        'delivery_needed': true,
        'amount_cents': amount, // Amount in cents
        'currency': 'EGP',
        'items': [],
      },
    );
    return response.data['id'];
  }

  Future<String> getPaymentKey({required String token, required String orderId, required String amount}) async {
    final response = await _dio.post(
      'https://accept.paymobsolutions.com/api/acceptance/payment_keys',
      data: {
        'auth_token': token,
        'amount_cents': amount, // Amount in cents
        'currency': 'EGP',
        'order_id': orderId,
        'billing_data': {
          'apartment': 'NA',
          'email': 'email@example.com',
          'floor': 'NA',
          'first_name': 'First Name',
          'street': 'Street Name',
          'building': 'NA',
          'phone_number': '01234567890',
          'shipping_method': 'NA',
          'postal_code': '12345',
          'city': 'Cairo',
          'country': 'EG',
          'last_name': 'Last Name',
          'state': 'NA',
        },
        'integration_id': integrationId,
      },
    );
    return response.data['token'];
  }

  String getIframeId() {
    return iframeId;
  }
}
