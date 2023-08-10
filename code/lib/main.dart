import 'package:flutter/material.dart';

import 's01/check_signal_basic.dart';
import 's01/check_signal_get.dart';
import 's02/local_notification.dart';
import 's02/push_notification.dart';

void main() {
  var tipo = Tipos.pushNotification;
  switch (tipo) {
    case Tipos.checkSignalBasic:
      runApp(const CheckSignalBasic());
      break;
    case Tipos.checkSignalGet:
      runApp(const CheckSignalGet());
      break;
    case Tipos.localNotification:
      runApp(const LocalNotification());
      break;
    case Tipos.pushNotification:
      runApp(const PushNotification());
      break;
    default:
      runApp(const CheckSignalBasic());
      break;
  }
}

// Enumeracion para ejecucion principal de Wigets
enum Tipos { checkSignalBasic, checkSignalGet, localNotification, pushNotification }
