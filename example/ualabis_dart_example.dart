import 'package:ualabis_dart/src/uala_error.dart';
import 'package:ualabis_dart/ualabis_dart.dart';

void main() async {
  UalaSDK.init("userName", "clientId", "clientSecret", isDev: true);

  try {
    Order order = await UalaSDK.checkout.createOrder(
      amount: "10.2",
      description: 'test',
      callbackSuccess: 'https://www.google.com/search?q=failed',
      callbackFail: 'https://www.google.com/search?q=success',
    );
    print(order);

    Order generatedOrder = await UalaSDK.checkout.getOrder(order.uuid);
    print(generatedOrder);
  } on UalaError catch (e) {
    print(e.message);
  }
}
