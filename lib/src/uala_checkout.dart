import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ualabis_dart/src/uala_error.dart';

import 'notifications.dart';
import 'order.dart';

class UalaCheckout {
  final Map<String, String> config;

  UalaCheckout(this.config);

  Future<void> _createToken() async {
    try {
      var response = await http.post(
        Uri.parse("${config['authBaseUrl']}/token"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "user_name": config["userName"]!,
          "client_id": config["clientId"]!,
          "client_secret_id": config["clientSecret"]!,
          "grant_type": 'client_credentials',
        }),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        config['authToken'] = data["access_token"];
        config['authTokenExpirationTime'] =
            (DateTime.now().millisecondsSinceEpoch +
                (int.parse(data["expires_in"]) * 1000)) as String;
      } else {
        throw UalaError(
          message: data['description'],
          errorCode: data['code'],
          statusCode: response.statusCode,
        );
      }
    } on UalaError catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw UalaError(
        message: 'Unknown error',
        errorCode: '999',
        statusCode: 0,
      );
    }
  }

  Future<void> _validateToken() async {
    if (DateTime.now().millisecondsSinceEpoch >= int.parse(config["authTokenExpirationTime"] ?? "0")) {
      await _createToken();
    }
  }

  Future<Order> createOrder({
    required String amount,
    required String description,
    required String callbackFail,
    required String callbackSuccess,
    String? notificationUrl,
  }) async {
    try {
      await _validateToken();

      var response = await http.post(
        Uri.parse("${config['baseUrl']}/checkout"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer ${config['authToken']}",
        },
        body: jsonEncode(<String, String>{
          "amount": amount,
          "description": description,
          "userName": config["userName"]!,
          "callback_fail": callbackFail,
          "callback_success": callbackSuccess,
          "notification_url": notificationUrl ?? "",
        }),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Order.from(data);
      } else {
        throw UalaError(
          message: data['description'],
          errorCode: data['code'],
          statusCode: response.statusCode,
        );
      }
    } on UalaError catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw UalaError(
        message: 'Unknown error',
        errorCode: '999',
        statusCode: 0,
      );
    }
  }

  Future<Order> getOrder(String orderId) async {
    try {
      await _validateToken();

      var response = await http.post(
        Uri.parse("${config['baseUrl']}/order/$orderId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer ${config['authToken']}",
        },
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Order.from(data);
      } else {
        throw UalaError(
          message: data['description'],
          errorCode: data['code'],
          statusCode: response.statusCode,
        );
      }
    } on UalaError catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw UalaError(
        message: 'Unknown error',
        errorCode: '999',
        statusCode: 0,
      );
    }
  }

  Future<Notifications> getFailedNotifications() async {
    try {
      await _validateToken();

      var response = await http.post(
        Uri.parse("${config['baseUrl']}/notifications"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer ${config['authToken']}",
        },
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Notifications.from(data);
      } else {
        throw UalaError(
          message: data['description'],
          errorCode: data['code'],
          statusCode: response.statusCode,
        );
      }
    } on UalaError catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw UalaError(
        message: 'Unknown error',
        errorCode: '999',
        statusCode: 0,
      );
    }
  }
}