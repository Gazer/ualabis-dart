# Ualá API Checkout Dart SDK

<img align="right" src="https://dart.dev/assets/img/shared/dart/logo+text/horizontal/white.svg" width="250"/>

Un-Official Dart SDK for Ualá Bis API Checkout

SDK Javascript no-oficial de Ualá Bis API Checkout

USE AT YOUR OWN RISK. THIS IS JUST AN EXPERIMENT FOR NOW

TO DOs
======

* Write tests
* Parse response value
* Test it :)

---
>Made with 💙 by Ricardo Markiewicz // [@gazeria](https://twitter.com/gazeria).

## Content
  - [Installation](#installation) | [Instalación](#instalación)
  - [Functions](#functions) | [Funciones](#funciones)
  - [Usage](#usage) | [Uso](#uso)
  - [API Checkout Docs](#api-checkout-docs)

## Installation
Add library to the pubspec.yml:

```yaml
dependencies:
  ualabis-dart: 0.0.1
```

Install the package:
```sh
dart pub get
```

List of all functions:
  - UalaSDK.init
  - UalaSDK.checkout.createOrder
  - UalaSDK.checkout.getOrder
  - UalaSDK.checkout.getFailedNotifications

## Usage
The package needs to be configured with your account's secret key

```dart
import 'package:ualabis_dart/ualabis_dart.dart';

void main() async {
  UalaSDK.init("userName", "clientId", "clientSecret", isDev: true);

  Order order = await UalaSDK.checkout.createOrder(
    amount: "10.2",
    description: 'test',
    callbackSuccess: 'https://www.google.com/search?q=failed',
    callbackFail: 'https://www.google.com/search?q=success',
  );

  Order generatedOrder = await UalaSDK.checkout.getOrder(order.uuid);
}
```


# Español

## Instalación
Agregue el paquete en su pubspec.yml:

```yaml
dependencies:
  ualabis-dart: 0.0.1
```

Instale el paquete con el siguiente comando:
```sh
dart pub get
```

## Funciones
Listado de todas las funciones:
  - UalaSDK.init
  - UalaSDK.checkout.createOrder
  - UalaSDK.checkout.getOrder
  - UalaSDK.checkout.getFailedNotifications

## Uso
Para hacer uso del SDK es necesario que configure sus credenciales como se muestra a continuación:

```dart
import 'package:ualabis_dart/ualabis_dart.dart';

void main() async {
  UalaSDK.init("userName", "clientId", "clientSecret", isDev: true);

  Order order = await UalaSDK.checkout.createOrder(
    amount: "10.2",
    description: 'test',
    callbackSuccess: 'https://www.google.com/search?q=failed',
    callbackFail: 'https://www.google.com/search?q=success',
  );

  Order generatedOrder = await UalaSDK.checkout.getOrder(order.uuid);
}
```

## API Checkout Docs
Also you can show Api Checkout Documentation in https://developers.ualabis.com.ar
