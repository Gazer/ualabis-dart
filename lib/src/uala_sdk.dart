import 'uala_checkout.dart';

class UalaSDK {
  static final Map<String, String> _config = {};
  
  static const _apiBaseUrls = {
    "stage": 'https://checkout.stage.ua.la/1',
    "production": 'https://checkout.prod.ua.la/1',
  };

  static const _authApiBaseUrls = {
    "stage": 'https://auth.stage.ua.la/1/auth',
    "production": 'https://auth.prod.ua.la/1/auth',
  };

  static late UalaCheckout checkout;

  static init(
    String userName,
    String clientId,
    String clientSecret,
    {bool isDev = true}
  ) {
    _config['userName'] = userName;
    _config['clientId'] = clientId;
    _config['clientSecret'] = clientSecret;
    _config['baseUrl'] = isDev ? _apiBaseUrls["stage"]! : _apiBaseUrls['production']!;
    _config['authBaseUrl'] =
        isDev ? _authApiBaseUrls["stage"]! : _authApiBaseUrls['production']!;
  
    checkout = UalaCheckout(_config);
  }
}